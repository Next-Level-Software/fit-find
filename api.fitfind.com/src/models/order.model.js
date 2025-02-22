import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const orderSchema = new mongoose.Schema(
    {
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
        uniqueId: { type: String },
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        totalAmount: { type: Number },
        status: { type: String, enum: ["ongoing", "completed", "cancelled"], default: "ongoing" },
        cancelledReason: { type: String },
        deliveryType: { type: String, enum: ["picked", "delivered"] },
        paymentStatus: { type: String, enum: ["pending", "completed", "failed", "refunded"], default: "pending" },
        orderItems: [{ type: mongoose.Schema.Types.ObjectId, ref: ModelNames.OrderItems.model }],
        location: {
            location: { type: String },
            latitude: { type: Number },
            longitude: { type: Number },
        },
        coupon: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Coupon.model },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Order.model, orderSchema);
