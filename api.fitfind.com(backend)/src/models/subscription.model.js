import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const subscriptionSchema = new mongoose.Schema(
    {
        subscriptionPlan: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.SubscriptionPlan.model },
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
        duration: { type: String },
        startDate: { type: Date },
        expiryDate: { type: Date },
        price: { type: Number },
        paymentDetail: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Subscription.model, subscriptionSchema);