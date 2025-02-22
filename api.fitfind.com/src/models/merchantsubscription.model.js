import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const merchantSubscriptionSchema = new mongoose.Schema(
    {
        merchantSubscriptionPlan: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.MerchantSubscriptionPlan.model },
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        duration: { type: String },
        startDate: { type: Date },
        expiryDate: { type: Date },
        price: { type: Number },
        paymentDetail: { type: String },
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.MerchantSubscription.model, merchantSubscriptionSchema);
