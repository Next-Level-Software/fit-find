import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const orderItemsSchema = new mongoose.Schema(
    {
        order: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Order.model },
        product: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Product.model },
        quantity: { type: Number },
        price: { type: Number },
        addons: { type: Array, default: [] },
        subtotal: { type: Number },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.OrderItems.model, orderItemsSchema);