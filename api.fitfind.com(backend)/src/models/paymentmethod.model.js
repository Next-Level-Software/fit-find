import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const paymentMethodSchema = new mongoose.Schema(
    {
        isEnabled: { type: Boolean, default: true },
        name: { type: String },
        nameAr: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.PaymentMethod.model, paymentMethodSchema);