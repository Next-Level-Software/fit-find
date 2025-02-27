import express from "express";
var router = express.Router();
import { merchantController } from "../../controllers/mp/merchant.controller.js";
import {
  validateApiAttributes,
  checkApiValidation,
} from "../../middlewares/validators.middleware.js";

router.post(
  "/register",
  validateApiAttributes(["businessName", "type"]),
  checkApiValidation,
  merchantController.register,
);

export default router;
