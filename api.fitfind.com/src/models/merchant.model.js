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
    image: { type: String },
    email: { type: String },
    phone: { type: String },
    password: { type: String },
    workingHours: [
      {
        day: { type: String },
        isClosed: { type: Boolean },
        openAt: { type: String },
        closedAt: { type: String },
      },
    ],
    type: { type: String, enum: ["gym", "academy"] },
    images: [{ type: String }],
    status: {
      type: String,
      enum: ["approved", "declined"],
      default: "approved",
    },
    declinedReason: { type: String },
    documents: [{ type: String }],
    classes: [
      { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Class.model },
    ],
  },
  { timestamps: true }
);

merchantSchema.pre("save", async function (next) {
  if (this.isModified("password")) {
    this.password = await encryptPassword(this.password);
  }

  if (this.isModified("phone") && this.phone && this.phone.trim()) {
    if (!this.phone.startsWith("+")) {
      this.phone = `+${this.phone}`;
    }
  }

  next();
});

merchantSchema.methods.isPasswordCorrect = async function (password) {
  return await compareEncryptedPassword(password, this.password);
};

export default mongoose.model(ModelNames.Merchant.model, merchantSchema);
