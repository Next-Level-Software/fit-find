import { StatusCodes } from "http-status-codes";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Category } from "../../startup/models.js";
import { asyncHandler } from '../../services/asynchandler.js';
import { paginationFiltrationData } from "../../services/pagination.service.js";

export const categoryController = {

    getAllCategories: asyncHandler(async (req, res) => {
        const categories = await Category.find();

        return generateApiResponse(
            res, StatusCodes.OK, true,
            "Categories fetched successfully!",
            { categories },
        );
    }),

    getCategoriesByFilter: asyncHandler(async (req, res) => {

        let whereStatement = {};

        const searchAttributes = ['nameAr', 'name'];
        const filteredData = await paginationFiltrationData(Category, req.query, 'categories', searchAttributes, whereStatement);

        return generateApiResponse(
            res, StatusCodes.OK, true,
            "Categories by filter fetched successfully!",
            { filteredData },
        );
    }),
}