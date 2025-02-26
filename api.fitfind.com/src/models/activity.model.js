import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const activitySchema = new mongoose.Schema(
    {
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        type: {
            type: String,
            enum: ["subscription-purchased", "give-review", "order-place"],
        },
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
        order: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Order.model },
        subscription: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Subscription.model },
        product: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Product.model },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Activity.model, activitySchema);