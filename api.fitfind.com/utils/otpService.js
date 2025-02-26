import otpGenerator from "otp-generator";
import { ResetCode } from "../src/startup/models.js";

export const sendOTP = async (email) => {
  const otp = otpGenerator.generate(6, {
    upperCaseAlphabets: false,
    specialChars: false,
  });

  await ResetCode.create({
    email,
    code: otp,
    expireAt: new Date(Date.now() + 5 * 60000),
  });

  console.log(`OTP for ${email}: ${otp}`);

  return otp;
};

export const verifyOTP = async (email, otp) => {
  const storedOtp = await ResetCode.findOne({ email, code: otp });

  if (!storedOtp || storedOtp.expireAt < new Date()) {
    return false;
  }

  await ResetCode.deleteOne({ email, code: otp });
  return true;
};
