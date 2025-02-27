import express from "express";
var router = express.Router();
import { userController } from "../../controllers/mp/user.controller.js";
import {
    validateApiAttributes,
    checkApiValidation,
} from "../../middlewares/validators.middleware.js";

router.post(
    "/register",
    validateApiAttributes(["name", "email", "password"], "body"),
    checkApiValidation,
    userController.registerUser
);
router.post(
    "/login",
    validateApiAttributes(["email", "password"], "body"),
    checkApiValidation,
    userController.loginUser
);

router.post(
    "/forgot-password",
    validateApiAttributes(["email"], "body"),
    checkApiValidation,
    userController.forgotPassword
);

router.post(
    "/reset-password",
    validateApiAttributes(["email", "otp", "newPassword"], "body"),
    checkApiValidation,
    userController.resetPassword
);

export default router;
