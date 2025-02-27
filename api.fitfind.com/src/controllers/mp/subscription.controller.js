import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "../../services/asynchandler.js";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Subscription } from "../../startup/models.js";
// import { Subscription } from "../../startup/models.js";

/**
 * Subscription Controller
 */
export const subscriptionController = {
  /**
   * Create a new subscription
   */
  createSubscription: asyncHandler(async (req, res) => {
    const {
      subscriptionPlan,
      merchant,
      duration,
      price,
      startDate,
      expiryDate,
    } = req.body;

    const newSubscription = await Subscription.create({
      subscriptionPlan,
      merchant,
      duration,
      price,
      startDate,
      expiryDate,
    });

    return generateApiResponse(
      res,
      StatusCodes.CREATED,
      true,
      "Subscription created successfully!",
      { subscription: newSubscription }
    );
  }),

  /**
   * Get a subscription by ID
   */
  getSubscription: asyncHandler(async (req, res) => {
    const { id } = req.params;

    const subscription = await Subscription.findById(id).populate(
      "subscriptionPlan merchant"
    );

    if (!subscription) {
      return generateApiResponse(
        res,
        StatusCodes.NOT_FOUND,
        false,
        "Subscription not found!"
      );
    }

    return generateApiResponse(
      res,
      StatusCodes.OK,
      true,
      "Subscription details retrieved successfully!",
      { subscription }
    );
  }),

  /**
   * Update a subscription
   */
  updateSubscription: asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { subscriptionPlan, duration, price, startDate, expiryDate } =
      req.body;

    const updatedSubscription = await Subscription.findByIdAndUpdate(
      id,
      { subscriptionPlan, duration, price, startDate, expiryDate },
      { new: true }
    );

    if (!updatedSubscription) {
      return generateApiResponse(
        res,
        StatusCodes.NOT_FOUND,
        false,
        "Subscription not found!"
      );
    }

    return generateApiResponse(
      res,
      StatusCodes.OK,
      true,
      "Subscription updated successfully!",
      { subscription: updatedSubscription }
    );
  }),

  /**
   * Delete a subscription
   */
  deleteSubscription: asyncHandler(async (req, res) => {
    const { id } = req.params;

    const deletedSubscription = await Subscription.findByIdAndDelete(id);

    if (!deletedSubscription) {
      return generateApiResponse(
        res,
        StatusCodes.NOT_FOUND,
        false,
        "Subscription not found!"
      );
    }

    return generateApiResponse(
      res,
      StatusCodes.OK,
      true,
      "Subscription deleted successfully!"
    );
  }),

  /**
   * Get all subscriptions for a merchant
   */
  getMerchantSubscriptions: asyncHandler(async (req, res) => {
    const { merchantId } = req.params;

    const subscriptions = await Subscription.find({
      merchant: merchantId,
    }).populate("subscriptionPlan");

    if (!subscriptions.length) {
      return generateApiResponse(
        res,
        StatusCodes.NOT_FOUND,
        false,
        "No subscriptions found for this merchant!"
      );
    }

    return generateApiResponse(
      res,
      StatusCodes.OK,
      true,
      "Merchant subscriptions retrieved successfully!",
      { subscriptions }
    );
  }),
};
