import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const brandSchema = new mongoose.Schema(
    {
        image: { type: String },
        name: { type: String },
        nameAr: { type: String },
        isEnabled: { type: Boolean, default: false },
        merchant: {
            type: mongoose.Schema.Types.ObjectId,
            ref: ModelNames.Merchant.model,
        }
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Brand.model, brandSchema);