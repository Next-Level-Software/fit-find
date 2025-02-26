import express from 'express';
import { validateApiAttributes, checkApiValidation } from '../../middlewares/validators.middleware.js';
import { userController } from '../../controllers/ma/user.controller.js';
import { singleUploadRoute } from '../../services/file.service.js';
var router = express.Router();


// router.post(
//     '/check-user',
//     validateApiAttributes(['email', 'password'], 'body'),
//     checkApiValidation,
//     userController.checkUser,
// );
router.post(
    '/register',
    validateApiAttributes(['email', 'password'], 'body'),
    checkApiValidation,
    userController.registerUser,
);
router.post(
    '/login',
    validateApiAttributes(['email', 'password'], 'body'),
    checkApiValidation,
    userController.loginUser,
);

router.post(
    '/forgot-password',
    validateApiAttributes(['email']),
    checkApiValidation,
    userController.forgotPassword,
);
router.post(
    '/verify',
    validateApiAttributes(['email', 'code']),
    checkApiValidation,
    userController.verifyCode,
);
router.patch(
    "/update-password",
    validateApiAttributes(['_id', 'password'], 'body', ['password']),
    checkApiValidation,
    userController.updatePassword,
);
router.patch(
    "/change-password",
    validateApiAttributes(['oldPassword', 'newPassword'], 'body', ['newPassword']),
    checkApiValidation,
    userController.changePassword,
);
router.get(
    "/refresh-token",
    userController.refreshMyToken,
);
router.get(
    "/get-profile",
    userController.getMyProfile,
);
router.patch(
    "/update-profile",
    singleUploadRoute,
    userController.updateMyProfile,
);
router.post(
    "/send-reset-code",
    validateApiAttributes(['email'], 'body', ['email']),
    checkApiValidation,
    userController.sendResetCode,
);

router.get(
    "/get-by-filter",
    userController.getByFilter,
);

router.get(
    "/get-dashboard",
    userController.getDashboard,
);


export default router;
