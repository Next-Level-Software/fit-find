import express from "express";
import merchantRoutes from "./merchant.route.js";

const router = express.Router();

router.use("/merchant", merchantRoutes);

export default router;
