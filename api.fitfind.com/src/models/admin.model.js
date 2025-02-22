import mongoose, { Schema } from "mongoose";
import { ModelNames } from "../constants.js";
import { compareEncryptedPassword, encryptPassword } from '../services/password.service.js';

const adminSchema = new Schema(
    {
        id: { type: String },
        name: { type: String },
        email: { type: String },
        password: { type: String },
        profilePhoto: { type: String },
        isSuperAdmin: { type: Boolean, default: false },
        accessTabs: [{ type: String }],
        is2FAEnabled: { type: Boolean }
    },
    { timestamps: true }
);

adminSchema.pre("save", async function (next) {
    if (this.isModified("password")) {
        this.password = await encryptPassword(this.password);
    }
    next();
});

adminSchema.methods.isPasswordCorrect = async function (password) {
    return await compareEncryptedPassword(password, this.password);
};


export default mongoose.model(ModelNames.Admin.model, adminSchema);