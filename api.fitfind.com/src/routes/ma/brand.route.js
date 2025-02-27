import express from 'express';
import { validateApiAttributes, checkApiValidation } from '../../middlewares/validators.middleware.js';
import { brandController } from '../../controllers/ma/brand.controller.js';
var router = express.Router();

router.get(
    '/get-by-filter', 
    brandController.getBrandsByFilter,
);

export default router;