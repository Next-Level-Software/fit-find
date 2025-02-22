import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const deliveryRateSchema = new mongoose.Schema(
    {
        range: {
            type: String,
            enum: ["base", "2-3 KM", "3-4 KM", "4-5 KM", "5-7 KM", "7-10 KM", "10 KM"],
        },
        price: { type: Number },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.DeliveryRate.model, deliveryRateSchema);