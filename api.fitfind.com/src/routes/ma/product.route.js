import express from 'express';
import { validateApiAttributes, checkApiValidation } from '../../middlewares/validators.middleware.js';
import { productController } from '../../controllers/ma/product.controller.js';
var router = express.Router();

router.get(
    '/get-by-filter',
    productController.getProductsByFilter,
);
router.get(
    '/get-detail',
    productController.getProductDetail,
);

export default router;