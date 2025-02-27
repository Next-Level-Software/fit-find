import express from "express";

import merchantRoutes from "./merchant.route.js";
import userRoutes from "./user.route.js";
import subscriptionRoutes from "./subscription.route.js";

const router = express.Router();

router.use("/merchant", merchantRoutes);
router.use("/user", userRoutes);
router.use("/subscription", subscriptionRoutes);

export default router;
