import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const notificationSchema = new mongoose.Schema(
    {
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        isRead: { type: Boolean, default: false },
        type: {
            type: String,
            enum: [
                "new-order",
                "subscription",
                "booking",
                "banner-approved",
                "banner-rejected",
                "withdraw-approved",
                "withdraw-reject",
            ]
        },
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
        userType: { type: String, enum: ["merchant", "user"] },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Notification.model, notificationSchema);