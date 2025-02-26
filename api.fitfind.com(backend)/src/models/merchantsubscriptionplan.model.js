import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const merchantSubscriptionPlanSchema = new mongoose.Schema(
    {
        price: { type: Number },
        duration: { type: String, enum: ["monthly", "yearly"] },
        title: { type: String },
        benefits: { type: [String] },
        image: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.MerchantSubscriptionPlan.model, merchantSubscriptionPlanSchema);