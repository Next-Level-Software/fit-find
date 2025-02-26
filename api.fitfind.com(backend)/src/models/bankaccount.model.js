import mongoose from "mongoose";
import { ModelNames } from '../constants.js';

const bankAccountSchema = new mongoose.Schema(
    {
        merchant: { type: mongoose.Schema.Types.ObjectId, ref: ModelNames.Merchant.model },
        iban: { type: String },
        bankName: { type: String },
    },
    { timestamps: true }
);

export default mongoose.model(ModelNames.BankAccount.model, bankAccountSchema);