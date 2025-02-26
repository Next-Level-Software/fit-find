import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const merchantSchema = new mongoose.Schema(
    {
        businessName: { type: String },
        businessNameAr: { type: String },
        image: { type: String },
        email: { type: String },
        phone: { type: String },
        password: { type: String },
        workingHours: [
            {
                day: { type: String },
                isClosed: { type: Boolean },
                openAt: { type: String },
                closedAt: { type: String },
            },
        ],
        type: { type: String, enum: ["gym", "academy"] },
        images: [{ type: String }],
        status: { type: String, enum: ["approved", "declined"], default: "approved" },
        declinedReason: { type: String },
        documents: [{ type: String }],
        classes: [{ type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Class.model }],
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Merchant.model, merchantSchema);