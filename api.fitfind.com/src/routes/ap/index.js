import express from 'express';
import adminRoutes from './admin.route.js';
import brandRoutes from './brand.route.js';
import categoryRoutes from './category.route.js';
import productRoutes from './product.route.js';

const router = express.Router();

router.use('/admin', adminRoutes);
router.use('/brand', brandRoutes);
router.use('/category', categoryRoutes);
router.use('/product', productRoutes);


export default router;
