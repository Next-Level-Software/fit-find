import mongoose from "mongoose";
import { ModelNames } from "../constants.js";

const resetCodeSchema = new mongoose.Schema(
  {
    code: { type: String, required: true },
    email: { type: String, required: true },
    expireAt: { type: Date, required: true },
  },
  { timestamps: true }
);

export default mongoose.model(ModelNames.ResetCode.model, resetCodeSchema);
