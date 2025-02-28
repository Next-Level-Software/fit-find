import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "../../services/asynchandler.js";
import { generateApiResponse } from "../../services/utilities.service.js";
import { Merchant, User } from "../../startup/models.js";
import { tokenCreator } from "../../services/token.service.js";

export const merchantController = {
    register: asyncHandler(async (req, res) => {

        const { _id: user, role } = req.user;

        const {
            type,
            gymDetail,
            academyDetail,
            documents,
        } = req.body;

        const findMerchant = await Merchant.findOne({
            user: user,
        });

        if (findMerchant) {
            return generateApiResponse(
                res, StatusCodes.BAD_REQUEST, false,
                "Merchant already registered",
            );
        }

        const createdMerchant = await Merchant.create({
            type,
            gymDetail,
            academyDetail,
            documents,
            user: user,
        });

        const findUser = await User.findById(user);
        findUser.merchant = createdMerchant._id;
        await findUser.save();

        return generateApiResponse(
            res, StatusCodes.CREATED, true,
            "Merchant registered successfully",
            {}
        );
    }),
};
