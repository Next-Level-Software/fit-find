import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const reviewSchema = new mongoose.Schema(
    {
        rating: { type: Number, required: true },
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        product: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Product.model },
        feedback: { type: String },
        type: { type: String, enum: ["service", "product"] },
        product: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Product.model },
        replyAt: { type: Date },
        replyMessage: { type: String },
        isReplied: { type: Boolean, default: false },
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
        flag: { type: Boolean, default: false },
        isDeleted: { type: Boolean, default: false },
        deleteReason: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Review.model, reviewSchema);