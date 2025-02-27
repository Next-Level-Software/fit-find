import { StatusCodes } from "http-status-codes";
import { Product } from '../../startup/models.js';
import { generateApiResponse, generateStartEndDateStatement, randomStringGenerator } from "../../services/utilities.service.js";
import { paginationFiltrationData } from "../../services/pagination.service.js";
import { fileRemover, removeFile, uploadASingleFile, uploadMultipleFiles } from "../../services/file.service.js";

export const productController = {

    async createProduct(req, res) {
        try {
            const {
                name,
                nameAr,
                description,
                descriptionAr,
                brand,
                category,
                merchant,
                stock,
                basePrice,
                discount,
                discountType,
                finalPrice,
            } = req.body;

            const files = req.files;

            let images;
            if (files)
                images = await uploadMultipleFiles(files);

            const product = await Product.create({
                name,
                nameAr,
                description,
                descriptionAr,
                brand,
                category,
                merchant,
                stock,
                basePrice,
                discount,
                discountType,
                finalPrice,
                images,
            });

            return generateApiResponse(
                res, StatusCodes.CREATED, true,
                "Product created successfully!",
                { product },
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while creating product!",
                { error }
            );
        }
    },

    async updateProduct(req, res, next) {
        try {
            const {
                _id,
                name,
                nameAr,
                description,
                descriptionAr,
                brand,
                category,
                merchant,
                stock,
                basePrice,
                discount,
                discountType,
                finalPrice,
            } = req.body;

            const foundProduct = await Product.findById(_id);
            if (!foundProduct) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Product not found!",
                );
            }

            const files = req.files;

            let images = foundProduct?.images;
            if (files)
                images = await uploadMultipleFiles(files);

            const product = await Product.findByIdAndUpdate(_id, {
                name,
                nameAr,
                description,
                descriptionAr,
                brand,
                category,
                merchant,
                stock,
                basePrice,
                discount,
                discountType,
                finalPrice,
                images,
            }, {
                new: true,
            });

            if (images != foundProduct?.images) { await removeFile(foundAdmin?.images) };

            return generateApiResponse(
                res, StatusCodes.OK, true,
                'Product updated successfully!',
                { product }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while updating product!",
                { error }
            )
        }
    },

    async getProduct(req, res, next) {
        try {
            const _id = req.params.id;

            const product = await Product.findById(_id);

            if (!product) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Product data not found!",
                );
            }

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Product data deleted successfully!",
                { product }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while deleting product!",
                { error }
            )
        }
    },

    async deleteProduct(req, res, next) {
        try {
            const _id = req.params.id;

            const deletedProduct = await Product.findByIdAndDelete(_id);

            if (!deletedProduct) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Product data not found!",
                );
            }

            if (deletedProduct?.image) { await removeFile(deletedProduct?.image) };

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Product data deleted successfully!",
                { product: deletedProduct }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while deleting product!",
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
            const filteredData = await paginationFiltrationData(Product, req.query, 'products', searchAttributes, whereStatement);

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Products by filter fetched successfully!",
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