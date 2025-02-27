export function generateEmailTemplate(verificationCode) {
  return `
    <table width="100%" cellspacing="0" cellpadding="0" border="0" style="font-family: Arial, sans-serif; background-color: #f9f9f9;">
      <tr>
        <td align="center">
          <table width="600" cellspacing="0" cellpadding="20" border="0" style="background-color: #ffffff; border: 1px solid #ddd; border-radius: 8px;">
            <tr>
              <td align="center">
                <h2 style="color: #4CAF50; margin: 0;">Verification Code</h2>
              </td>
            </tr>
            <tr>
              <td>
                <p style="font-size: 16px; color: #333;">Dear User,</p>
                <p style="font-size: 16px; color: #333;">Your verification code is:</p>
              </td>
            </tr>
            <tr>
              <td align="center">
                <span style="display: inline-block; font-size: 24px; font-weight: bold; color: #4CAF50; padding: 10px 20px; border: 1px solid #4CAF50; border-radius: 5px; background-color: #e8f5e9;">
                  ${verificationCode}
                </span>
              </td>
            </tr>
            <tr>
              <td>
                <p style="font-size: 16px; color: #333;">Please use this code to verify your email address. The code will expire in 10 minutes.</p>
                <p style="font-size: 16px; color: #333;">If you did not request this, please ignore this email.</p>
              </td>
            </tr>
            <tr>
              <td align="center" style="font-size: 14px; color: #999;">
                <p>Thank you,<br>Your Company Team</p>
                <p style="font-size: 12px; color: #aaa;">This is an automated message. Please do not reply to this email.</p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  `;
}
