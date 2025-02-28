import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const reviewSchema = new mongoose.Schema(
    {
        rating: { type: Number, required: true },
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        feedback: { type: String },

        type: { type: String, enum: ["gym", "academy", "product"] },
        replyAt: { type: Date },
        replyMessage: { type: String },
        isReplied: { type: Boolean, default: false },
        flag: { type: Boolean, default: false },
        isDeleted: { type: Boolean, default: false },
        deleteReason: { type: String },

        product: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Product.model },
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Review.model, reviewSchema);