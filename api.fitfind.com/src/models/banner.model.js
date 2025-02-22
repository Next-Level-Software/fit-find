import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const bannerSchema = new mongoose.Schema(
    {
        image: { type: String },
        title: { type: String },
        link: { type: String },
        status: { type: String, enum: ["approved", "declined"] },
        declinedReason: { type: String },
        views: { type: Number, default: 0 },
        clicks: { type: Number, default: 0 },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Banner.model, bannerSchema);