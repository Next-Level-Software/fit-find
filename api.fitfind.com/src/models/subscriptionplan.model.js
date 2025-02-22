import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const subscriptionPlanSchema = new mongoose.Schema(
    {
        title: { type: String },
        description: { type: String },
        benefits: { type: [String], default: [] },
        price: { type: Number },
        duration: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.SubscriptionPlan.model, subscriptionPlanSchema);