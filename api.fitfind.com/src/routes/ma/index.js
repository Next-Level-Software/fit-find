import express from 'express';
import brandRoutes from './brand.route.js';
import merchantRoutes from './merchant.route.js';
import productRoutes from './product.route.js';
import userRoutes from './user.route.js';

const router = express.Router();

router.use('/brand', brandRoutes);
router.use('/merchant', merchantRoutes);
router.use('/product', productRoutes);
router.use('/user', userRoutes);

export default router;
