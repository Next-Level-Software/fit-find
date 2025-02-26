import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const productSchema = new mongoose.Schema(
    {
        images: [{ type: String }],
        name: { type: String },
        nameAr: { type: String },
        description: { type: String },
        descriptionAr: { type: String },
        rating: { type: Number, default: 0 },
        ratingCount: { type: Number, default: 0 },
        category: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Category.model },
        stock: { type: Number, default: 0 },
        basePrice: { type: Number },
        discount: { type: Number, default: 0 },
        discountType: { type: String, enum: ["fixed", "percentage"] },
        finalPrice: { type: Number },
        status: { type: String, enum: ["active", "inactive"], default: "active" },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.Product.model, productSchema);