import express from 'express';
import { validateApiAttributes, checkApiValidation } from '../../middlewares/validators.middleware.js';
import { productController } from '../../controllers/ap/product.controller.js';
import { singleUploadRoute } from '../../services/file.service.js';
var router = express.Router();

router.post(
    '/create',
    singleUploadRoute,
    validateApiAttributes(['name']),
    checkApiValidation,
    productController.createProduct,
);
router.patch(
    '/update',
    singleUploadRoute,
    validateApiAttributes(['_id'], 'body'),
    checkApiValidation,
    productController.updateProduct,
);
router.get(
    '/get/:id',
    productController.getProduct,
);
router.delete(
    '/delete/:id',
    productController.deleteProduct,
);
router.get(
    "/get-by-filter",
    productController.getByFilter,
);

export default router;