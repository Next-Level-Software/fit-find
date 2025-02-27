import express from "express";
import merchantRoutes from "./merchant.route.js";
import subscriptionRoutes from "./subscription.route.js";

const router = express.Router();

router.use("/merchant", merchantRoutes);
router.use("/subscription", subscriptionRoutes);

export default router;
