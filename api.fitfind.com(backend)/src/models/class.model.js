import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const classSchema = new mongoose.Schema(
    {
        price: { type: Number },
        coverPhoto: { type: String },
        title: { type: String },
        description: { type: String },
        schedule: { type: String },
        capacity: { type: Number },
        images: { type: [String] },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Class.model, classSchema);