import { StatusCodes } from "http-status-codes";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Product } from "../../startup/models.js";
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
}