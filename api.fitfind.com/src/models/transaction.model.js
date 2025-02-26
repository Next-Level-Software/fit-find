import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const transactionSchema = new mongoose.Schema(
    {
        paymentId: { type: String },
        order: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Order.model },
        amount: { type: Number },
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        paymentMethod: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.PaymentMethod.model },
        uniqueId: { type: String },
        status: { type: String, enum: ["pending", "completed", "failed"], default: "pending" },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Transaction.model, transactionSchema);