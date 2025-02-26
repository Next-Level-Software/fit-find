import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const cartSchema = new mongoose.Schema(
    {
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
        user: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.User.model },
        items: [
            {
                product: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Product.model },
                quantity: { type: Number, default: 0 },
            },
        ],
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Cart.model, cartSchema);