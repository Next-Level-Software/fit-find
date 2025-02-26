import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const addressSchema = new mongoose.Schema(
    {
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        name: { type: String },
        location: { type: String },
        area: { type: String },
        blockNumber: { type: String },
        postalCode: { type: String },
        latitude: { type: Number },
        longitude: { type: Number },
        isDefault: { type: Boolean, default: false },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Address.model, addressSchema);
