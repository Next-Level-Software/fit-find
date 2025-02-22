import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const faqSchema = new mongoose.Schema(
    {
        question: { type: String },
        answer: { type: String },
        sort: { type: Number },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.FAQ.model, faqSchema);