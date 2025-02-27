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
        purchasedClasses: [{ type: Schema.Types.Mixed }]
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

export default mongoose.model(ModelNames.User.model, userSchema);
