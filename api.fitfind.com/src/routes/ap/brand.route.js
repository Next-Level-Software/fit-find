import express from 'express';
import { validateApiAttributes, checkApiValidation } from '../../middlewares/validators.middleware.js';
import { brandController } from '../../controllers/ap/brand.controller.js';
import { singleUploadRoute } from '../../services/file.service.js';
var router = express.Router();

router.post(
    '/create',
    singleUploadRoute,
    validateApiAttributes(['name']),
    checkApiValidation,
    brandController.createBrand,
);
router.patch(
    '/update',
    singleUploadRoute,
    validateApiAttributes(['_id'], 'body'),
    checkApiValidation,
    brandController.updateBrand,
);
router.get(
    '/get/:id',
    brandController.getBrand,
);
router.delete(
    '/delete/:id',
    brandController.deleteBrand,
);
router.get(
    "/get-by-filter",
    brandController.getByFilter,
);

export default router;