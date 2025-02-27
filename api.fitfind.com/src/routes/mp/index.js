import express from "express";
import userRoutes from "./user.route.js";
import subscriptionRoutes from "./subscription.route.js";

const router = express.Router();

router.use("/user", userRoutes);
router.use("/subscription", subscriptionRoutes);

export default router;
