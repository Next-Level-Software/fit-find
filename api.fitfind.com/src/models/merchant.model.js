import mongoose from "mongoose";
import { ModelNames } from "../constants.js";

const gymSchema = new mongoose.Schema({
  name: { type: String },
  nameAr: { type: String },
  description: { type: String },
  descriptionAr: { type: String },

  price: { type: Number },

  location: {
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

  coverImage: { type: String },
  images: [{ type: String }],
});

const academySchema = new mongoose.Schema({
  name: { type: String },
  nameAr: { type: String },
  description: { type: String },
  descriptionAr: { type: String },

  price: { type: Number },

  location: {
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

  coverImage: { type: String },
  images: [{ type: String }],
  classes: [
    { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Class.model },
  ],

});

const merchantSchema = new mongoose.Schema(
  {
    type: [{ type: String, enum: ["gym", "academy", "marketplace"] }],
    isAvailable: { type: Boolean, default: true },

    status: {
      type: String,
      enum: ["pending", "approved", "declined"],
      default: 'pending'
    },
    declinedReason: { type: String },

    documents: [{ type: String }],

    gymDetail: gymSchema,
    academyDetail: academySchema,
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: ModelNames.User.model
    },
  },
  { timestamps: true }
);

export default mongoose.model(ModelNames.Merchant.model, merchantSchema);
