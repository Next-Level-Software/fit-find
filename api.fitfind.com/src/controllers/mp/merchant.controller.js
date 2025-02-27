import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "../../services/asynchandler.js";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Merchant } from "../../startup/models.js";
import { tokenCreator } from "../../services/token.service.js";
import { sendOTP, verifyOTP } from "../../../utils/otpService.js";

export const merchantController = {
  /**
   * Register Merchant
   */
  registerMerchant: asyncHandler(async (req, res) => {
    const { name, email, password, phone } = req.body;

    const findMerchant = await Merchant.findOne({ email });

    if (findMerchant) {
      return generateApiResponse(
        res,
        StatusCodes.CONFLICT,
        false,
        "Email alreayd in use!"
      );
    }

    const createdMerchant = await Merchant.create({
      name,
      email,
      phone,
      password,
    });

    const token = tokenCreator(createdMerchant.toObject());
    return generateApiResponse(
      res,
      StatusCodes.CREATED,
      true,
      "Merchant has been registered",
      { token }
    );
  }),

  /**
   * Login Merchant
   */
  loginMerchant: asyncHandler(async (req, res) => {
    const { email, password } = req.body;

    const findMerchant = await Merchant.findOne({ email });

    if (!findMerchant) {
      return generateApiResponse(
        res,
        StatusCodes.UNAUTHORIZED,
        false,
        "Merchant does not exist!"
      );
    }

    const isMatched = await findMerchant.isPasswordCorrect(password);

    if (!isMatched) {
      return generateApiResponse(
        res,
        StatusCodes.UNAUTHORIZED,
        false,
        "Password is incorrect!"
      );
    }

    const token = tokenCreator(findMerchant.toObject());
    return generateApiResponse(
      res,
      StatusCodes.CREATED,
      true,
      "Merchant logged in successfully!",
      { token }
    );
  }),

  /**
   * Forgot Password - Send OTP
   */
  forgotPassword: asyncHandler(async (req, res) => {
    const { email } = req.body;

    const merchant = await Merchant.findOne({ email });

    if (!merchant) {
      return generateApiResponse(
        res,
        StatusCodes.NOT_FOUND,
        false,
        "Merchant not found!"
      );
    }

    await sendOTP(email);

    return generateApiResponse(
      res,
      StatusCodes.OK,
      true,
      "OTP has been sent to your email."
    );
  }),

  resetPassword: asyncHandler(async (req, res) => {
    try {
      const { email, otp, newPassword } = req.body;

      const isOtpValid = await verifyOTP(email, otp);
      if (!isOtpValid) {
        return generateApiResponse(
          res,
          StatusCodes.BAD_REQUEST,
          false,
          "Invalid OTP!"
        );
      }

      const merchant = await Merchant.findOne({ email });

      if (!merchant) {
        return generateApiResponse(
          res,
          StatusCodes.NOT_FOUND,
          false,
          "Merchant not found!"
        );
      }

      // Update password securely
      merchant.password = newPassword;
      await merchant.save();

      return generateApiResponse(
        res,
        StatusCodes.OK,
        true,
        "Password reset successful!"
      );
    } catch (error) {
      return generateApiResponse(
        res,
        StatusCodes.INTERNAL_SERVER_ERROR,
        false,
        "Error occurred while resetting password",
        error
      );
    }
  }),
};
