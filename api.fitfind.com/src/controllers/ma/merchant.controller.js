import { StatusCodes } from "http-status-codes";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Config, Merchant } from "../../startup/models.js";
import { asyncHandler } from '../../services/asynchandler.js';
import geodist from "geodist";

export const merchantController = {
    getNearbyMerchants: asyncHandler(async (req, res) => {
        const { lat, lng, type, search } = req.body;

        if (!lat || !lng) {
            return res.status(StatusCodes.BAD_REQUEST).json({
                success: false,
                message: "Invalid latitude or longitude values",
            });
        }

        // Fetch radius from config (default 10km if not found)
        const findConfig = await Config.findOne({ where: { type: 'geo-fencing-radius' } });
        const searchInKm = findConfig ? parseInt(findConfig.keyValue) : 10;

        // Base query conditions
        const whereStatement = {
            status: "approved",
            isAvailable: true,
        };

        if (type) {
            whereStatement.type = { $in: type };
        }

        if (search) {
            whereStatement.$or = [
                { businessName: { $regex: search, $options: "i" } },
                { businessNameAr: { $regex: search, $options: "i" } },
                { description: { $regex: search, $options: "i" } },
                { descriptionAr: { $regex: search, $options: "i" } },
            ];
        }

        // Fetch merchants matching the search criteria
        const merchants = await Merchant.find(whereStatement);

        if (!merchants.length) {
            return generateApiResponse(res, StatusCodes.OK, true, "No nearby merchants found", { merchants: [] });
        }

        // Process merchants asynchronously
        const nearbyMerchants = await Promise.all(
            merchants.map(async (merchant) => {
                let nearestLocation = null;
                let minDistance = Infinity;

                // Check gym location if available
                if (merchant.gymLocation) {
                    const gymDist = geodist(
                        { lat, lng },
                        { lat: merchant.gymLocation.latitude, lng: merchant.gymLocation.longitude },
                        { unit: "km" }
                    );

                    if (gymDist <= searchInKm && gymDist < minDistance) {
                        minDistance = gymDist;
                        nearestLocation = {
                            type: "gym",
                            latitude: merchant.gymLocation.latitude,
                            longitude: merchant.gymLocation.longitude,
                            distanceInKm: gymDist,
                        };
                    }
                }

                // Check academy location if available
                if (merchant.academyLocation) {
                    const academyDist = geodist(
                        { lat, lng },
                        { lat: merchant.academyLocation.latitude, lng: merchant.academyLocation.longitude },
                        { unit: "km" }
                    );

                    if (academyDist <= searchInKm && academyDist < minDistance) {
                        minDistance = academyDist;
                        nearestLocation = {
                            type: "academy",
                            latitude: merchant.academyLocation.latitude,
                            longitude: merchant.academyLocation.longitude,
                            distanceInKm: academyDist,
                        };
                    }
                }

                // If a valid nearby location was found, include merchant in response
                if (nearestLocation) {
                    return {
                        ...merchant.toObject(),
                        nearestLocation,
                    };
                }
                return null;
            })
        );

        // Filter out merchants that are null (not within search radius)
        const filteredMerchants = nearbyMerchants.filter(Boolean);

        return generateApiResponse(
            res,
            StatusCodes.OK,
            true,
            "Merchants fetched successfully",
            { merchants: filteredMerchants }
        );
    }),
}