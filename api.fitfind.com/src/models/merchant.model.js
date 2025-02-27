import mongoose from "mongoose";
import { ModelNames } from "../constants.js";
import {
  compareEncryptedPassword,
  encryptPassword,
} from "../services/password.service.js";

const merchantSchema = new mongoose.Schema(
  {
    businessName: { type: String },
    businessNameAr: { type: String },

    coverImage: { type: String },
    gymLocation: {
      latitude: { type: Number },
      longitude: { type: Number },
      address: { type: String },
    },
    academyLocation: {
      latitude: { type: Number },
      longitude: { type: Number },
      address: { type: String },
    },
    workingHours: [
      {
        day: { type: String },
        isClosed: { type: Boolean },
        openAt: { type: String },
        closedAt: { type: String },
      },
    ],
    type: [{ type: String, enum: ["gym", "academy", "marketplace"] }],

    images: [{ type: String }],
    isAvailable: { type: Boolean, default: true },

    status: {
      type: String,
      enum: ["pending", "approved", "declined"],
      default: 'pending'
    },
    declinedReason: { type: String },

    documents: [{ type: String }],
    classes: [
      { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Class.model },
    ],
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: ModelNames.User.model
    },
  },
  { timestamps: true }
);

export default mongoose.model(ModelNames.Merchant.model, merchantSchema);
