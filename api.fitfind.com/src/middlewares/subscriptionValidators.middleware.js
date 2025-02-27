import { StatusCodes } from "http-status-codes";
import { validationResult, body, param, query } from "express-validator";
import { generateApiResponse } from "../services/utilities.service.js";

/**
 * Validation functions for subscription attributes
 */
const subscriptionValidators = {
  subscriptionPlan: (attr) =>
    body(attr)
      .trim()
      .notEmpty()
      .withMessage("Subscription plan ID is required.")
      .bail()
      .isMongoId()
      .withMessage("Invalid subscription plan ID."),

  merchant: (attr) =>
    body(attr)
      .trim()
      .notEmpty()
      .withMessage("Merchant ID is required.")
      .bail()
      .isMongoId()
      .withMessage("Invalid merchant ID."),

  duration: (attr) =>
    body(attr)
      .trim()
      .notEmpty()
      .withMessage("Duration is required.")
      .bail()
      .isIn(["1 month", "3 months", "6 months", "12 months"])
      .withMessage(
        "Invalid duration. Allowed values: '1 month', '3 months', '6 months', '12 months'."
      ),

  price: (attr) =>
    body(attr)
      .notEmpty()
      .withMessage("Price is required.")
      .bail()
      .isNumeric()
      .withMessage("Price must be a numeric value."),

  startDate: (attr) =>
    body(attr)
      .notEmpty()
      .withMessage("Start date is required.")
      .bail()
      .isISO8601()
      .withMessage("Start date must be in ISO8601 format (YYYY-MM-DD)."),

  expiryDate: (attr) =>
    body(attr)
      .notEmpty()
      .withMessage("Expiry date is required.")
      .bail()
      .isISO8601()
      .withMessage("Expiry date must be in ISO8601 format (YYYY-MM-DD)."),

  paymentDetail: (attr) =>
    body(attr)
      .optional()
      .trim()
      .isString()
      .withMessage("Payment detail must be a string."),
};

/**
 * Validate API attributes for subscription routes
 * @param {string[]} attributes - Attributes to validate
 * @param {'body'|'param'|'query'} type - Validation type (body, param, or query)
 * @returns {Array} Array of validation rules
 */
export const validateSubscriptionAttributes = (attributes, type = "body") => {
  return attributes.map((attr) =>
    subscriptionValidators[attr]
      ? subscriptionValidators[attr](attr)
      : body(attr).notEmpty().withMessage(`${attr} is required.`)
  );
};

/**
 * Middleware for checking validation errors in API requests
 */
export const checkSubscriptionValidation = async (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const validationErrors = errors.array().map((err) => err.msg);
    return generateApiResponse(
      res,
      StatusCodes.BAD_REQUEST,
      false,
      validationErrors[0],
      { error: validationErrors }
    );
  }
  next();
};
