import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const userLogSchema = new mongoose.Schema(
    {
        loginType: { type: String },
        createdAt: { type: Date, default: Date.now },
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        ipAddress: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.UserLog.model, userLogSchema);