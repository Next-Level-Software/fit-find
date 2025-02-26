import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const resetCodeSchema = new mongoose.Schema(
    {
        code: { type: String },
        email: { type: String },
        expireAt: { type: Date },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.ResetCode.model, resetCodeSchema);