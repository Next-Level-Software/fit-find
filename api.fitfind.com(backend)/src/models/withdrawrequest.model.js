import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const withdrawRequestSchema = new mongoose.Schema(
    {
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
        amount: { type: Number },
        status: { type: String, enum: ["pending", "paid", "cancelled"], default: "pending" },
        cancelledReason: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.WithdrawRequest.model, withdrawRequestSchema);
