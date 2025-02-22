import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const categorySchema = new mongoose.Schema(
    {
        name: { type: String },
        nameAr: { type: String },
        image: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Category.model, categorySchema);