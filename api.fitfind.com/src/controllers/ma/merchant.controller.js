import { StatusCodes } from "http-status-codes";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Config, Merchant, Review, User } from "../../startup/models.js";
import { asyncHandler } from '../../services/asynchandler.js';
import geodist from "geodist";
import { paginationFiltrationData } from '../../services/pagination.service.js';

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
        const findConfig = await Config.findOne({ where: { type: "geo-fencing-radius" } });
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
                { "gymDetail.name": { $regex: search, $options: "i" } },
                { "gymDetail.nameAr": { $regex: search, $options: "i" } },
                { "academyDetail.name": { $regex: search, $options: "i" } },
                { "academyDetail.nameAr": { $regex: search, $options: "i" } },
                { "gymDetail.description": { $regex: search, $options: "i" } },
                { "gymDetail.descriptionAr": { $regex: search, $options: "i" } },
                { "academyDetail.description": { $regex: search, $options: "i" } },
                { "academyDetail.descriptionAr": { $regex: search, $options: "i" } },
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

                const locations = [];

                // Check gym location if available
                if (merchant.gymDetail && merchant.gymDetail.location) {
                    locations.push({
                        type: "gym",
                        latitude: merchant.gymDetail.location.latitude,
                        longitude: merchant.gymDetail.location.longitude,
                    });
                }

                // Check academy location if available
                if (merchant.academyDetail && merchant.academyDetail.location) {
                    locations.push({
                        type: "academy",
                        latitude: merchant.academyDetail.location.latitude,
                        longitude: merchant.academyDetail.location.longitude,
                    });
                }

                console.log(locations.length);

                // Calculate distances
                locations.forEach((loc) => {
                    const dist = geodist({ lat, lng }, { lat: loc.latitude, lng: loc.longitude }, { unit: "km" });

                    if (dist <= searchInKm && dist < minDistance) {
                        minDistance = dist;
                        nearestLocation = { ...loc, distanceInKm: dist };
                    }
                });

                return nearestLocation ? { ...merchant.toObject(), nearestLocation } : null;
            })
        );

        // Filter out merchants that are null (not within search radius)
        const filteredMerchants = nearbyMerchants.filter(Boolean);

        return generateApiResponse(
            res,
            StatusCodes.OK,
            filteredMerchants.length > 0,
            "Merchants fetched successfully",
            { merchants: filteredMerchants }
        );
    }),

    getGymByFilter: asyncHandler(async (req, res) => {
        const { minPrice, maxPrice, rating } = req.query;

        let whereStatement = {
            type: { $in: 'gym' },
            isAvailable: true,
            status: 'approved',
        };

        if (minPrice || maxPrice) {
            whereStatement["gymDetail.price"] = {};
            if (minPrice) whereStatement["gymDetail.price"].$gte = parseFloat(minPrice);
            if (maxPrice) whereStatement["gymDetail.price"].$lte = parseFloat(maxPrice);
        }

        if (rating) {
            whereStatement["gymDetail.rating"] = { $gte: parseFloat(rating) };
        }

        const searchAttributes = ['businessName', 'businessNameAr', 'description', 'descriptionAr'];
        const attributes = "-documents -academyDetail -createdAt -updatedAt";
        const populates = [
            // { path: "user" },
        ]
        const filteredData = await paginationFiltrationData(Merchant, req.query, 'merchants', searchAttributes, whereStatement, populates, attributes);

        return generateApiResponse(
            res, StatusCodes.OK, true,
            "Merchants by filter fetched successfully!",
            { filteredData },
        );
    }),

    getGymDetail: asyncHandler(async (req, res) => {
        const { id } = req.query;

        const merchant = await Merchant.findById(id)
            .select("-documents -academyDetail -createdAt -updatedAt");

        if (!merchant) {
            return generateApiResponse(res, StatusCodes.NOT_FOUND, false, "Merchant not found");
        }

        const reviews = await Review.find({
            merchant: id,
            type: "gym",
            isDeleted: false,
        })
            .populate("user", "firstName lastName profileImage")
            .limit(10)
            .sort({ createdAt: -1 });

        return generateApiResponse(
            res, StatusCodes.OK, true,
            "Merchant fetched successfully",
            { merchant, reviews },
        );
    }),

    favoriteUnfavoriteMerchant: asyncHandler(async (req, res) => {
        const { _id } = req.user;

        const { id, isFavorite } = req.body;

        const merchant = await Merchant.findById(id);

        if (!merchant) {
            return generateApiResponse(res, StatusCodes.NOT_FOUND, false, "Merchant not found");
        }

        const user = await User.findById(_id);

        const isFavoriteBoolean = typeof isFavorite === "string" ? isFavorite === "true" : isFavorite;

        if (isFavoriteBoolean) {
            if (user.favoriteMerchants.includes(id)) {
                return generateApiResponse(res, StatusCodes.BAD_REQUEST, false, "Merchant already in favorites");
            }
            user.favoriteMerchants.push(id);
            await user.save();
            return generateApiResponse(res, StatusCodes.OK, true, "Merchant added to favorites successfully");
        } else {
            user.favoriteMerchants = user.favoriteMerchants.filter((merchantId) => merchantId.toString() !== id);
            await user.save();
            return generateApiResponse(res, StatusCodes.OK, true, "Merchant removed from favorites successfully");
        }
    }),
}