import express from "express";
import { subscriptionController } from "../../controllers/mp/subscription.controller.js";
import {
  checkSubscriptionValidation,
  validateSubscriptionAttributes,
} from "../../middlewares/subscriptionValidators.middleware.js";

const router = express.Router();

router.post(
  "/create",
  validateSubscriptionAttributes([
    "subscriptionPlan",
    "merchant",
    "duration",
    "price",
    "startDate",
    "expiryDate",
  ]),
  checkSubscriptionValidation,
  subscriptionController.createSubscription
);

router.get("/get/:id", subscriptionController.getSubscription);
router.put("/update/:id", subscriptionController.updateSubscription);
router.delete("/delete/:id", subscriptionController.deleteSubscription);
router.get(
  "/merchant/:merchantId",
  subscriptionController.getMerchantSubscriptions
);

export default router;
