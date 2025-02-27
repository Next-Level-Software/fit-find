import express from 'express';
import { validateApiAttributes, checkApiValidation } from '../../middlewares/validators.middleware.js';
import { merchantController } from '../../controllers/ma/merchant.controller.js';
var router = express.Router();

router.post(
    '/get-nearby-merchants',
    validateApiAttributes(['lat', 'lng']),
    checkApiValidation,
    merchantController.getNearbyMerchants,
);

export default router;