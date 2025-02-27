import mongoose, { Schema } from "mongoose";
import { ModelNames } from "../constants.js";
import { generateUsername } from "../services/utilities.service.js";
import { compareEncryptedPassword, encryptPassword } from "../services/password.service.js";

const userSchema = new Schema(
    {
        id: { type: String },
        name: { type: String },
        username: { type: String },
        phone: { type: String },
        email: { type: String },
        password: { type: String },
        gender: { type: String, enum: ['male', 'female', 'child'] },
        language: { type: String, enum: ['en', 'es', 'fr', 'de', 'zh'] },
        loginType: { type: String, enum: ['email', 'google', 'apple'], default: 'email' },
        dateOfBirth: { type: Date },
        emailVerified: { type: Boolean, default: false },
        profilePhoto: { type: String },
        purchasedClasses: [{ type: Schema.Types.Mixed }],
        userType: { type: String, enum: ['user', 'merchant'], default: 'user' },
        merchant: {
            type: Schema.Types.ObjectId,
            ref: ModelNames.Merchant.model,
        },
    },
    { timestamps: true }
);

userSchema.pre("save", async function (next) {
    if (this.isModified("password")) {
        this.password = await encryptPassword(this.password);
    }

    if (this.isModified("phone") && this.phone && this.phone.trim()) {
        if (!this.phone.startsWith("+")) {
            this.phone = `+${this.phone}`;
        }
    }

    if (this.isNew && !this.username) {
        this.username = generateUsername(this.name);
    }

    next();
});

userSchema.methods.isPasswordCorrect = async function (password) {
    return await compareEncryptedPassword(password, this.password);
};

userSchema.index(
    { createdAt: 1 },
    { expireAfterSeconds: 2592000, partialFilterExpression: { emailVerified: false } }
);

export default mongoose.model(ModelNames.User.model, userSchema);
