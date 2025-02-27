import { StatusCodes } from "http-status-codes";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Brand } from "../../startup/models.js";
import { asyncHandler } from '../../services/asynchandler.js';
import { paginationFiltrationData } from "../../services/pagination.service.js";

export const brandController = {
    getBrandsByFilter: asyncHandler(async (req, res) => {

        let whereStatement = {};

        const searchAttributes = ['nameAr', 'name'];
        const filteredData = await paginationFiltrationData(Brand, req.query, 'brands', searchAttributes, whereStatement);

        return generateApiResponse(
            res, StatusCodes.OK, true,
            "Brands by filter fetched successfully!",
            { filteredData },
        );
    }),
}