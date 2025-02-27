import express from 'express';
import { validateApiAttributes, checkApiValidation } from '../../middlewares/validators.middleware.js';
import { categoryController } from '../../controllers/ma/category.controller.js';
var router = express.Router();

router.get(
    '/get-all', 
    categoryController.getAllCategories,
);
router.get(
    '/get-by-filter', 
    categoryController.getCategoriesByFilter,
);

export default router;