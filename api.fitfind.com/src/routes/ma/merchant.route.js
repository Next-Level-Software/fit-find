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
router.get(
    '/get-gyms-by-filter',
    merchantController.getGymByFilter,
);
router.get(
    '/get-gym-detail',
    validateApiAttributes(['id'], 'query'),
    checkApiValidation,
    merchantController.getGymDetail,
);
router.patch(
    "/favorite-unfavorite",
    validateApiAttributes(['id', 'isFavorite']),
    checkApiValidation,
    merchantController.favoriteUnfavoriteMerchant,
)

export default router;