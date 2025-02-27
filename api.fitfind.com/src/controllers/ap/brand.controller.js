import { StatusCodes } from "http-status-codes";
import { Brand } from '../../startup/models.js';
import { generateApiResponse, generateStartEndDateStatement, randomStringGenerator } from "../../services/utilities.service.js";
import { paginationFiltrationData } from "../../services/pagination.service.js";
import { fileRemover, removeFile, uploadASingleFile } from "../../services/file.service.js";


export const brandController = {
    async createBrand(req, res) {
        try {
            const {
                name,
                nameAr,
                merchant,
            } = req.body;

            const file = req.file;

            let image;
            if (file)
                image = await uploadASingleFile(file);

            const brand = await Brand.create({
                image,
                name,
                nameAr,
                merchant,
                isEnabled: true,
            });

            return generateApiResponse(
                res, StatusCodes.CREATED, true,
                "Brand created successfully!",
                { brand },
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while creating brand!",
                { error }
            );
        }
    },

    async updateBrand(req, res, next) {
        try {
            const {
                _id,
                name,
                nameAr,
                merchant,
            } = req.body;

            const foundBrand = await Brand.findById(_id);
            if (!foundBrand) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Brand not found!",
                );
            }

            const file = req.file;

            let image = foundBrand?.image;
            if (file)
                image = await uploadASingleFile(file);

            const brand = await Brand.findByIdAndUpdate(_id, {
                name,
                nameAr,
                merchant,
                image,
            }, {
                new: true,
            });

            if (image != foundBrand?.image) { await removeFile(foundAdmin?.image) };

            return generateApiResponse(
                res, StatusCodes.OK, true,
                'Brand updated successfully!',
                { brand }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while updating brand!",
                { error }
            )
        }
    },

    async getBrand(req, res, next) {
        try {
            const _id = req.params.id;

            const brand = await Brand.findById(_id);

            if (!brand) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Brand data not found!",
                );
            }

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Brand data deleted successfully!",
                { brand }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while deleting brand!",
                { error }
            )
        }
    },

    async deleteBrand(req, res, next) {
        try {
            const _id = req.params.id;

            const deletedBrand = await Brand.findByIdAndDelete(_id);

            if (!deletedBrand) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Brand data not found!",
                );
            }

            if (deletedBrand?.image) { await removeFile(deletedBrand?.image) };

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Brand data deleted successfully!",
                { brand: deletedBrand }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while deleting brand!",
                { error }
            )
        }
    },

    /**
 * Get by filter
 */
    async getByFilter(req, res, next) {
        try {
            let whereStatement = {};
            Object.assign(whereStatement, generateStartEndDateStatement(req.query));

            const searchAttributes = ['email', 'name'];
            const filteredData = await paginationFiltrationData(Brand, req.query, 'brands', searchAttributes, whereStatement);

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Brands by filter fetched successfully!",
                { filteredData },
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while getting by filter!",
                { error }
            )
        }
    },

}