import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "../../services/asynchandler.js";
import { generateApiResponse } from "../../services/utilities.service.js";
import { User } from "../../startup/models.js";
import { tokenCreator } from "../../services/token.service.js";
import { sendOTP, verifyOTP } from "../../../utils/otpService.js";

export const userController = {

    /**
     * Register User
     */
    registerUser: asyncHandler(async (req, res) => {
        const { name, email, password, phone } = req.body;

        const findUser = await User.findOne({ email });

        if (findUser) {
            return generateApiResponse(
                res,
                StatusCodes.CONFLICT,
                false,
                "Email already in use!"
            );
        }

        const createdUser = await User.create({
            name,
            email,
            phone,
            password,
            userType: "merchant",
        });

        const token = tokenCreator(createdUser.toObject());
        return generateApiResponse(
            res,
            StatusCodes.CREATED,
            true,
            "User has been registered",
            { token }
        );
    }),

    /**
     * Login User
     */
    loginUser: asyncHandler(async (req, res) => {
        const { email, password } = req.body;

        const findUser = await User.findOne({ email });

        if (!findUser) {
            return generateApiResponse(
                res,
                StatusCodes.UNAUTHORIZED,
                false,
                "User does not exist!"
            );
        }

        const isMatched = await findUser.isPasswordCorrect(password);

        if (!isMatched) {
            return generateApiResponse(
                res,
                StatusCodes.UNAUTHORIZED,
                false,
                "Password is incorrect!"
            );
        }

        if (findUser.userType !== "merchant") {
            return generateApiResponse(
                res, StatusCodes.UNAUTHORIZED, false,
                "This account is associated with customer!",
            );
        }

        const token = tokenCreator(findUser.toObject());
        return generateApiResponse(
            res,
            StatusCodes.CREATED,
            true,
            "User logged in successfully!",
            { token }
        );
    }),

    /**
     * Forgot Password - Send OTP
     */
    forgotPassword: asyncHandler(async (req, res) => {
        const { email } = req.body;

        const user = await User.findOne({ email });

        if (!user) {
            return generateApiResponse(
                res,
                StatusCodes.NOT_FOUND,
                false,
                "User not found!"
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

            const user = await User.findOne({ email });

            if (!user) {
                return generateApiResponse(
                    res,
                    StatusCodes.NOT_FOUND,
                    false,
                    "User not found!"
                );
            }

            // Update password securely
            user.password = newPassword;
            await user.save();

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
