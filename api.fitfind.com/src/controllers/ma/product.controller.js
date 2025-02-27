import { StatusCodes } from "http-status-codes";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Product } from "../../startup/models.js";
import { asyncHandler } from '../../services/asynchandler.js';
import { paginationFiltrationData } from "../../services/pagination.service.js";

export const productController = {
    getProductsByFilter: asyncHandler(async (req, res) => {

        const { brand, category } = req.query;

        let whereStatement = {};

        if (brand) {
            Object.assign(whereStatement, { brand });
        }

        if (category) {
            Object.assign(whereStatement, { category });
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
}