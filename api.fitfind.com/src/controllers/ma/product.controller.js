import { StatusCodes } from "http-status-codes";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Product, User } from "../../startup/models.js";
import { asyncHandler } from '../../services/asynchandler.js';
import { paginationFiltrationData } from "../../services/pagination.service.js";

export const productController = {
    getProductsByFilter: asyncHandler(async (req, res) => {

        const { brand, category, minPrice, maxPrice, rating } = req.query;

        let whereStatement = {
            status: 'active',
        };

        if (brand) {
            Object.assign(whereStatement, { brand });
        }

        if (category) {
            Object.assign(whereStatement, { category });
        }

        if (minPrice && maxPrice) {
            Object.assign(whereStatement, { finalPrice: { $gte: parseFloat(minPrice), $lte: parseFloat(maxPrice) } });
        }

        if (rating) {
            Object.assign(whereStatement, { rating: { $gte: parseFloat(rating) } });
        }

        const searchAttributes = [
            'name',
            'nameAr',
            'description',
            'descriptionAr',
        ];
        const populates = [
            { path: "category" },
        ]
        const filteredData = await paginationFiltrationData(Product, req.query, 'products', searchAttributes, whereStatement, populates);

        return generateApiResponse(
            res, StatusCodes.OK, true,
            "Products by filter fetched successfully!",
            { filteredData },
        );
    }),

    getProductDetail: asyncHandler(async (req, res) => {
        const { productId } = req.query;

        const product = await Product.findById(productId)
            .populate('category')
            .populate('brand');

        if (!product) {
            return generateApiResponse(
                res, StatusCodes.NOT_FOUND, false,
                "Product not found!",
            );
        }
        return generateApiResponse(
            res, StatusCodes.OK, true,
            "Product fetched successfully!",
            { product },
        );
    }),

    favoriteUnfavoriteProduct: asyncHandler(async (req, res) => {
        const { _id } = req.user;

        const { id, isFavorite } = req.body;

        const product = await Product.findById(id);

        if (!product) {
            return generateApiResponse(res, StatusCodes.NOT_FOUND, false, "Product not found");
        }

        const user = await User.findById(_id);

        const isFavoriteBoolean = typeof isFavorite === "string" ? isFavorite === "true" : isFavorite;

        if (isFavoriteBoolean) {
            if (user.favoriteProducts.includes(id)) {
                return generateApiResponse(res, StatusCodes.BAD_REQUEST, false, "Product already in favorites");
            }
            user.favoriteProducts.push(id);
            await user.save();
            return generateApiResponse(res, StatusCodes.OK, true, "Product added to favorites successfully");
        } else {
            user.favoriteProducts = user.favoriteProducts.filter((productId) => productId.toString() !== id);
            await user.save();
            return generateApiResponse(res, StatusCodes.OK, true, "Product removed from favorites successfully");
        }
    }),

    getFavoriteProducts: asyncHandler(async (req, res) => {
        const { _id } = req.user;
        const { brand, category, minPrice, maxPrice, rating } = req.query;

        const user = await User.findById(_id);

        let whereStatement = { _id: { $in: user.favoriteProducts } };

        if (brand) {
            Object.assign(whereStatement, { brand });
        }

        if (category) {
            Object.assign(whereStatement, { category });
        }

        if (minPrice && maxPrice) {
            Object.assign(whereStatement, { finalPrice: { $gte: parseFloat(minPrice), $lte: parseFloat(maxPrice) } });
        }

        if (rating) {
            Object.assign(whereStatement, { rating: { $gte: parseFloat(rating) } });
        }

        const searchAttributes = [
            'name',
            'nameAr',
            'description',
            'descriptionAr',
        ];
        const populates = [
            { path: "category" },
        ]
        const filteredData = await paginationFiltrationData(Product, req.query, 'products', searchAttributes, whereStatement, populates);

        return generateApiResponse(
            res, StatusCodes.OK, true,
            "Admins by filter fetched successfully!",
            { filteredData },
        );
    }),
}