import express from 'express';
import { validateApiAttributes, checkApiValidation } from '../../middlewares/validators.middleware.js';
import { adminController } from '../../controllers/ap/admin.controller.js';
import { singleUploadRoute } from '../../services/file.service.js';
var router = express.Router();

router.post(
    '/create',
    validateApiAttributes(['name', 'email', 'password'], 'body', ['name', 'password', 'email']),
    checkApiValidation,
    adminController.createAdmin,
);
router.patch(
    '/update',
    validateApiAttributes(['_id'], 'body'),
    checkApiValidation,
    adminController.updateAdmin,
);
router.delete(
    '/delete/:id',
    adminController.deleteAdmin,
)

router.post(
    '/login',
    validateApiAttributes(['email', 'password'], 'body'),
    checkApiValidation,
    adminController.loginAdmin,
);

router.post(
    '/forgot-password',
    validateApiAttributes(['email']),
    checkApiValidation,
    adminController.forgotPassword,
);
router.post(
    '/verify',
    validateApiAttributes(['email', 'code']),
    checkApiValidation,
    adminController.verifyCode,
);
router.patch(
    "/update-password",
    validateApiAttributes(['_id', 'password'], 'body', ['password']),
    checkApiValidation,
    adminController.updatePassword,
);
router.patch(
    "/change-password",
    validateApiAttributes(['oldPassword', 'newPassword'], 'body', ['newPassword']),
    checkApiValidation,
    adminController.changePassword,
);
router.get(
    "/refresh-token",
    adminController.refreshMyToken,
);
router.get(
    "/get-profile",
    adminController.getMyProfile,
);
router.patch(
    "/update-profile",
    singleUploadRoute,
    adminController.updateMyProfile,
);
router.post(
    "/send-reset-code",
    validateApiAttributes(['email'], 'body', ['email']),
    checkApiValidation,
    adminController.sendResetCode,
);

router.get(
    "/get-by-filter",
    adminController.getByFilter,
);

router.get(
    "/get-dashboard",
    adminController.getDashboard,
);


export default router;
