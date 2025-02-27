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

        const findConfig = await Config.findOne({
            where: {
                type: 'geo-fencing-radius',
            },
        });

        const searchInKm = findConfig ? parseInt(findConfig.keyValue) : 10;

        const userCurrentLocation = {
            lat: lat,
            lng: lng,
        };

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

        const merchants = await Merchant.find(whereStatement);


        var nearbyMerchants = [];

        if (merchants.length) {

            merchants.forEach(async (merchant) => {

                var isNearByMerchant = {
                    lat: merchant.location.latitude,
                    lng: merchant.location.longitude,
                }

                var dist = geodist(userCurrentLocation, isNearByMerchant, {
                    format: true,
                    unit: "meters",
                });

                var distanceInMeters = dist.substr(0, dist.indexOf(" "));
                var distanceInKm = dist.substr(0, dist.indexOf(" ")) / 1000;

                if (distanceInKm < searchInKm) {

                    var data = {
                        ...merchant.toObject(),
                        distanceInMeters: distanceInMeters,
                    };
                    nearbyMerchants.push(data);
                }

            });

            if (nearbyMerchants.length == 0) {

                return generateApiResponse(
                    res, StatusCodes.OK, false, "No nearby merchants found",
                    { merchants: nearbyMerchants },
                );
            }

            return generateApiResponse(
                res, StatusCodes.OK, true, "Merchants fetched successfully",
                { merchants: nearbyMerchants },
            );

        } else {

            return generateApiResponse(
                res, StatusCodes.OK, true, "Merchants fetched successfully",
                { merchants: [] },
            );
        }


    }),
}