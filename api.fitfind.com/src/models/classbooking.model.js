import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const classBookingSchema = new mongoose.Schema(
    {
        class: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Class.model },
        price: { type: Number },
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.ClassBooking.model, classBookingSchema);