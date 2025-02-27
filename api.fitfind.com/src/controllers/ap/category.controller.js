import { StatusCodes } from "http-status-codes";
import { Category } from '../../startup/models.js';
import { generateApiResponse, generateStartEndDateStatement, randomStringGenerator } from "../../services/utilities.service.js";
import { paginationFiltrationData } from "../../services/pagination.service.js";
import { fileRemover, removeFile, uploadASingleFile } from "../../services/file.service.js";


export const categoryController = {
    async createCategory(req, res) {
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

            const category = await Category.create({
                image,
                name,
                nameAr,
                merchant,
                isEnabled: true,
            });

            return generateApiResponse(
                res, StatusCodes.CREATED, true,
                "Category created successfully!",
                { category },
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while creating category!",
                { error }
            );
        }
    },

    async updateCategory(req, res, next) {
        try {
            const {
                _id,
                name,
                nameAr,
                merchant,
            } = req.body;

            const foundCategory = await Category.findById(_id);
            if (!foundCategory) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Category not found!",
                );
            }

            const file = req.file;

            let image = foundCategory?.image;
            if (file)
                image = await uploadASingleFile(file);

            const category = await Category.findByIdAndUpdate(_id, {
                name,
                nameAr,
                merchant,
                image,
            }, {
                new: true,
            });

            if (image != foundCategory?.image) { await removeFile(foundAdmin?.image) };

            return generateApiResponse(
                res, StatusCodes.OK, true,
                'Category updated successfully!',
                { category }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while updating category!",
                { error }
            )
        }
    },

    async getCategory(req, res, next) {
        try {
            const _id = req.params.id;

            const category = await Category.findById(_id);

            if (!category) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Category data not found!",
                );
            }

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Category data deleted successfully!",
                { category }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while deleting category!",
                { error }
            )
        }
    },

    async deleteCategory(req, res, next) {
        try {
            const _id = req.params.id;

            const deletedCategory = await Category.findByIdAndDelete(_id);

            if (!deletedCategory) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Category data not found!",
                );
            }

            if (deletedCategory?.image) { await removeFile(deletedCategory?.image) };

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Category data deleted successfully!",
                { category: deletedCategory }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while deleting category!",
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
            const filteredData = await paginationFiltrationData(Category, req.query, 'categories', searchAttributes, whereStatement);

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Categories by filter fetched successfully!",
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