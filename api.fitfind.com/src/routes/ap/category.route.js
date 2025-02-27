import express from 'express';
import { validateApiAttributes, checkApiValidation } from '../../middlewares/validators.middleware.js';
import { categoryController } from '../../controllers/ap/category.controller.js';
import { singleUploadRoute } from '../../services/file.service.js';
var router = express.Router();

router.post(
    '/create',
    singleUploadRoute,
    validateApiAttributes(['name']),
    checkApiValidation,
    categoryController.createCategory,
);
router.patch(
    '/update',
    singleUploadRoute,
    validateApiAttributes(['_id'], 'body'),
    checkApiValidation,
    categoryController.updateCategory,
);
router.get(
    '/get/:id',
    categoryController.getCategory,
);
router.delete(
    '/delete/:id',
    categoryController.deleteCategory,
);
router.get(
    "/get-by-filter",
    categoryController.getByFilter,
);

export default router;