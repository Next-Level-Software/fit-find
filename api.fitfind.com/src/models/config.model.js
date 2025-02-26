import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const configSchema = new mongoose.Schema(
    {
        keyName: { type: String },
        keyValue: { type: String },
        keyText: { type: String },
        keyType: { type: String, enum: ["all", "vendor", "mobile", "admin"] },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Config.model, configSchema);