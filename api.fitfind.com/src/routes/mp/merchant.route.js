import express from "express";
var router = express.Router();
import { merchantController } from "../../controllers/mp/merchant.controller.js";
import {
  validateApiAttributes,
  checkApiValidation,
} from "../../middlewares/validators.middleware.js";

router.post(
  "/register",
  validateApiAttributes(["name", "email", "password"], "body"),
  checkApiValidation,
  merchantController.registerMerchant
);
router.post(
  "/login",
  validateApiAttributes(["email", "password"], "body"),
  checkApiValidation,
  merchantController.loginMerchant
);

router.post(
  "/forgot-password",
  validateApiAttributes(["email"], "body"),
  checkApiValidation,
  merchantController.forgotPassword
);

router.post(
  "/reset-password",
  validateApiAttributes(["email", "otp", "newPassword"], "body"),
  checkApiValidation,
  merchantController.resetPassword
);

export default router;
