import { StatusCodes } from "http-status-codes";
import { User } from '../../startup/models.js';
import { badWordsCheck, generateApiResponse, generateStartEndDateStatement, isValidEmail, randomStringGenerator } from "../../services/utilities.service.js";
import { compareEncryptedPassword, encryptPassword } from "../../services/password.service.js";
import { tokenCreator } from "../../services/token.service.js";
import moment from 'moment';
import { sendEmailForResetCode, sendEmailOnRegistration } from '../../services/email.service.js';
import { paginationFiltrationData } from "../../services/pagination.service.js";
import { fileRemover, uploadASingleFile } from "../../services/file.service.js";
import { asyncHandler } from '../../services/asynchandler.js';

export const userController = {

    /**
     * Check User
     */
    checkUser: asyncHandler(async (req, res) => {
        const {
            name, email, phone, password
        } = req.body;

        if (password.length < 8) {
            return generateApiResponse(
                res, StatusCodes.BAD_REQUEST, false,
                "Password should be greater than 8 characters!"
            );
        }

        // Validate name for bad words
        if (badWordsCheck(name)) {
            return generateApiResponse(
                res, StatusCodes.BAD_REQUEST, false,
                "Name should not contain bad words"
            );
        }

        if (email)
            if (!isValidEmail(email)) {
                return generateApiResponse(
                    res, StatusCodes.BAD_REQUEST, false,
                    "Email must be a valid email!"
                );
            }

        // Check if phone number or email already exists
        const existingUser = await User.findOne({
            $or: [{ phone }, { email }]
        });

        if (existingUser) {
            const message = existingUser.phone === phone
                ? "Phone number already in use by other account!"
                : "Email already in use by other account!";

            return generateApiResponse(
                res, StatusCodes.CONFLICT, false, message
            );
        }

        // If all validations pass
        return generateApiResponse(
            res, StatusCodes.ACCEPTED, true,
            "User can register account!"
        );
    }),

    /**
     * Register User
     */
    registerUser: asyncHandler(async (req, res) => {
        const {
            name,
            email,
            phone,
            password,
        } = req.body;

        if (password.length < 8) {
            return generateApiResponse(
                res, StatusCodes.BAD_REQUEST, false,
                "Password should be greater than 8 characters!"
            );
        }

        // Validate name for bad words
        if (badWordsCheck(name)) {
            return generateApiResponse(
                res, StatusCodes.BAD_REQUEST, false,
                "Name should not contain bad words"
            );
        }

        if (!isValidEmail(email)) {
            return generateApiResponse(
                res, StatusCodes.BAD_REQUEST, false,
                "Email must be a valid email!"
            );
        }

        // Check if phone number or email already exists
        const existingUser = await User.findOne({
            $or: [{ phone }, { email }]
        });

        if (existingUser) {
            const message = existingUser.email === email
                ? "Email already in use by other account!"
                : "Phone number already in use by other account!";

            return generateApiResponse(
                res, StatusCodes.CONFLICT, false, message
            );
        }

        const createdUser = await User.create({
            name,
            email,
            phone,
            password,
        });

        if (email)
            await sendEmailOnRegistration(email);

        const token = tokenCreator(createdUser.toObject());
        return generateApiResponse(
            res, StatusCodes.CREATED, true,
            "User registered successfully!",
            { token }
        );

    }),

    /**
     * Login User
     */
    loginUser: asyncHandler(async (req, res) => {
        const {
            email,
            password,
        } = req.body;

        const foundUser = await User.findOne({ email });

        const userPassword = foundUser ? foundUser.password : "";

        const isPasswordValid = await compareEncryptedPassword(password, userPassword);

        if (!isPasswordValid || !foundUser) {
            return generateApiResponse(
                res, StatusCodes.UNAUTHORIZED, false,
                "Incorrect email or password!",
            );
        }

        const token = tokenCreator(foundUser?.toObject());

        return generateApiResponse(
            res, StatusCodes.ACCEPTED, true,
            "User logged in successfully!",
            { token }
        );
    }),

    /**
 * Forgot Password
 */

    async forgotPassword(req, res, next) {
        try {
            const {
                email,
            } = req.body;

            const findUser = await User.findOne({ email });

            if (!findUser) {
                return generateApiResponse(
                    res, StatusCodes.UNAUTHORIZED, false,
                    "No user found against this email",
                );
            }

            await ResetCode.deleteMany({ email });

            const name = findUser?.name;

            const code = randomStringGenerator(6, 'numeric');

            const expireAt = moment().add(5, 'minutes');

            await sendEmailForResetCode(email, code, name);

            await ResetCode.create({
                email,
                code,
                expireAt,
            });



            return generateApiResponse(
                res, StatusCodes.ACCEPTED, true,
                "Reset code has been sent to your email!",
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while forgot password for user!",
                { error }
            )
        }
    },

    async verifyCode(req, res, next) {
        try {
            const { email, code } = req.body;

            const findUser = await User.findOne({ email });

            const findResetCode = await ResetCode.findOne({ email });
            if (!findResetCode) {
                return generateApiResponse(
                    res, StatusCodes.NOT_ACCEPTABLE, false,
                    "Reset code has been expired!",
                );
            }

            const isCodeVerified = findResetCode?.code == code;
            if (!isCodeVerified) {
                return generateApiResponse(
                    res, StatusCodes.NOT_ACCEPTABLE, false,
                    "Invalid reset code!",
                );
            }

            await ResetCode.deleteOne({ email });

            const token = tokenCreator(findUser?.toObject());
            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Reset Code verified successfully!",
                { token }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while verifying code!",
                { error }
            )
        }
    },

    /**
    * Change password
    */
    async changePassword(req, res) {
        try {
            const { _id } = req.user;

            const {
                oldPassword,
                newPassword,
            } = req.body;

            const foundUser = await User.findById(_id, 'password');
            if (!foundUser) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "User not found!",
                );
            }

            const verifyPassword = await compareEncryptedPassword(oldPassword, foundUser?.password);
            if (!verifyPassword) {
                return generateApiResponse(
                    res, StatusCodes.CONFLICT, false,
                    "Old Password is incorrect!",
                );
            }

            const encryptedPassword = await encryptPassword(newPassword);
            await User.findByIdAndUpdate(_id, { password: encryptedPassword });
            return generateApiResponse(
                res, StatusCodes.OK, false,
                "Password has been changed!",
            );
        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred in changing Password!",
                { error },
            );
        }
    },

    /**
    * Update password
    */
    async updatePassword(req, res) {
        try {
            const {
                _id,
                password,
            } = req.body;

            const usersCount = await User.countDocuments({ _id: _id });
            if (!usersCount) {
                return generateApiResponse(
                    res, StatusCodes.CONFLICT, false,
                    "User not found!",
                );
            }

            const encryptedPassword = await encryptPassword(password);
            await User.findByIdAndUpdate(_id, { password: encryptedPassword });
            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Password updated successfully!",
            );
        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred in updating Password!",
                { error }
            );
        }
    },



    /**
    * Refresh my token
    */
    async refreshMyToken(req, res) {
        try {
            const userId = req.user._id;
            const foundUser = await User.findById(userId);

            if (foundUser) {
                const token = tokenCreator(foundUser?.toObject());
                return generateApiResponse(
                    res, StatusCodes.OK, true,
                    "My Token refreshed successfully!",
                    { token },
                );

            } else {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "User not found!",
                );
            }
        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred in refreshing my Token!",
                { error }
            );
        }
    },


    /**
    * Get my profile
    */
    async getMyProfile(req, res) {
        try {
            const { _id } = req.user;
            const foundUser = await User.findById(_id);

            if (foundUser) {
                return generateApiResponse(
                    res, StatusCodes.OK, true,
                    "My Profile fetched successfully!",
                    { user: foundUser },
                );
            } else {
                return generateApiResponse(
                    res, StatusCodes.BAD_REQUEST, false,
                    "User not found!"
                );
            }
        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred in getting My Profile!",
                { error },
            );
        }
    },



    /**
     * Update my profile
     */
    async updateMyProfile(req, res) {
        try {
            const { _id } = req.user;
            const {
                email,
                name,
                accessTabs,
                is2FAEnabled,
            } = req.body;

            if (name) {
                const isBadWord = badWordsCheck(name);
                if (isBadWord) {
                    return generateApiResponse(
                        res, StatusCodes.NOT_ACCEPTABLE, false,
                        "Name contains inappropriate language.",
                    );
                }
            }

            if (email) {
                const isEmailUsedByUser = await User.countDocuments({ _id: { $ne: _id }, email: email });
                if (isEmailUsedByUser) {
                    return generateApiResponse(
                        res, StatusCodes.CONFLICT, false,
                        "Email already used by another account!",
                    );
                }
            }
            const file = req.file;
            const foundUser = await User.findById(_id, 'profilePhoto');

            let profilePhoto = foundUser?.profilePhoto;
            if (file)
                profilePhoto = await uploadASingleFile(file);

            const updatedUser = await User.findByIdAndUpdate(
                _id,
                {
                    email,
                    name,
                    profilePhoto,
                    accessTabs,
                },
                { new: true },
            );

            if (profilePhoto != foundUser?.profilePhoto) { fileRemover(foundUser?.profilePhoto) };

            const token = tokenCreator(updatedUser?.toObject());
            if (updatedUser) {
                return generateApiResponse(
                    res, StatusCodes.OK, true,
                    "Profile updated successfully!",
                    { token },
                );
            } else {
                return generateApiResponse(
                    res, StatusCodes.CONFLICT, false,
                    "No Profile data updated!",
                );
            }
        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred in updating My Profile!",
                { error },
            );
        }
    },



    /**
     * Send reset code
     */
    async sendResetCode(req, res) {
        try {
            const {
                email,
            } = req.body;

            const foundUser = await User.findOne({ email: email });
            if (!foundUser) {
                return generateApiResponse(
                    res, StatusCodes.CONFLICT, false,
                    "No User found against this email!",
                );
            }

            const resetCode = randomStringGenerator(6, 'numeric');
            await sendResetCodeEmail(foundUser?.email, resetCode);

            const token = tokenCreator(foundUser?.toObject());
            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Reset code sent successfully!",
                { code: resetCode, token: token },
            );
        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred in sending reset code!",
                { error },
            );
        }
    },

    /**
     * Get by filter
     */
    async getByFilter(req, res, next) {
        try {
            let whereStatement = {};
            Object.assign(whereStatement, generateStartEndDateStatement(req.query));

            const searchAttributes = ['email', 'name'];
            const filteredData = await paginationFiltrationData(User, req.query, 'users', searchAttributes, whereStatement);

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Users by filter fetched successfully!",
                { filteredData },
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while getting by filter!",
                { error }
            )
        }
    },

    /**
     * Get dashboard data
     */
    async getDashboard(req, res, next) {
        try {
            const {
                type,
            } = req.query;
            const today = moment().startOf('day');
            const tomorrow = moment(today).add(1, 'days');
            const startOfWeek = moment(today).startOf('week');
            const startOfMonth = moment(today).startOf('month');
            const startOfYear = moment(today).startOf('year');
            var status = "paid";
            var totalUsers,
                totalUsers,
                totalBuyers,
                totalSellers,
                totalInvestors,
                totalRevenue,
                totalVisitors,
                totalBusinesses,
                verifiedBusinesses,
                unverifiedBusinesses,

                yearlyData,
                monthlyData,
                weeklyData,
                dailyData;
            let dashboardData = {};
            if (!type) {
                [
                    totalUsers,
                    totalUsers,
                    totalBuyers,
                    totalSellers,
                    totalInvestors,
                    totalVisitors,
                    totalBusinesses,
                    verifiedBusinesses,
                    unverifiedBusinesses,
                    totalRevenue,
                    yearlyData,

                ] = await Promise.all([
                    User.countDocuments(),
                    User.countDocuments(),
                    User.countDocuments({ type: 'buyer' }),
                    User.countDocuments({ type: 'seller' }),
                    User.countDocuments({ type: 'investor' }),
                    Business.aggregate([
                        { $group: { _id: null, totalViews: { $sum: "$views" } } }
                    ]),
                    Business.countDocuments(),
                    Business.countDocuments({ isVerified: true }),
                    Business.countDocuments({ isVerified: false }),
                    Payment.aggregate([
                        { $match: { status: 'paid' } },  // Filter only 'paid' payments
                        { $group: { _id: null, totalAmount: { $sum: "$amount" } } }  // Sum the 'amount' field
                    ]),
                    // Yearly data with all months
                    Payment.aggregate([
                        {
                            $match: {
                                createdAt: { $gte: startOfYear.toDate() },
                                status: status
                            }
                        },
                        {
                            $group: {
                                _id: { month: { $month: "$createdAt" } },
                                total: { $sum: "$amount" }
                            }
                        },
                        { $sort: { "_id.month": 1 } }
                    ]),
                ]);
                const totalVisitorsCount = totalVisitors.length > 0 ? totalVisitors[0].totalViews : 0;
                const revenueAmount = totalRevenue.length > 0 ? totalRevenue[0].totalAmount : 0;

                dashboardData.businessStats = {
                    totalInvestors,
                    totalBusinesses,
                    verifiedBusinesses,
                    unverifiedBusinesses,
                    totalVisitors: totalVisitorsCount,
                };
                dashboardData.userStats = {
                    totalUsers,
                    totalUsers,
                    totalBuyers,
                    totalSellers,
                };
                dashboardData.revenueStats = {
                    revenueAmount,
                    yearlyData: formatYearlyData(yearlyData),

                };
            } if (type == 'monthly') {
                [
                    totalRevenue,

                    monthlyData
                ] = await Promise.all([
                    Payment.aggregate([
                        { $match: { status: 'paid' } },  // Filter only 'paid' payments
                        { $group: { _id: null, totalAmount: { $sum: "$amount" } } }  // Sum the 'amount' field
                    ]),
                    // Monthly data with all days
                    Payment.aggregate([
                        {
                            $match: {
                                createdAt: { $gte: startOfMonth.toDate() },
                                status: status
                            }
                        },
                        {
                            $group: {
                                _id: { day: { $dayOfMonth: "$createdAt" }, weekday: { $dayOfWeek: "$createdAt" } },
                                total: { $sum: "$amount" }
                            }
                        },
                        { $sort: { "_id.day": 1 } }
                    ]),
                ]);
                const revenueAmount = totalRevenue.length > 0 ? totalRevenue[0].totalAmount : 0;
                dashboardData.revenueStats = {
                    revenueAmount,
                    monthlyData: formatMonthlyData(monthlyData)

                };


            } if (type == 'weekly') {
                [
                    totalRevenue,

                    weeklyData
                ] = await Promise.all([
                    Payment.aggregate([
                        { $match: { status: 'paid' } },  // Filter only 'paid' payments
                        { $group: { _id: null, totalAmount: { $sum: "$amount" } } }  // Sum the 'amount' field
                    ]),
                    // Weekly data with all days of the week
                    Payment.aggregate([
                        {
                            $match: {
                                createdAt: { $gte: startOfWeek.toDate() },
                                status: status
                            }
                        },
                        {
                            $group: {
                                _id: { day: { $dayOfWeek: "$createdAt" } },
                                total: { $sum: "$amount" }
                            }
                        },
                        { $sort: { "_id.day": 1 } }
                    ]),
                ]);
                const revenueAmount = totalRevenue.length > 0 ? totalRevenue[0].totalAmount : 0;
                dashboardData.revenueStats = {
                    revenueAmount,
                    weeklyData: formatWeeklyData(weeklyData)
                };
            } if (type == 'daily') {
                [
                    totalRevenue,

                    dailyData
                ] = await Promise.all([
                    Payment.aggregate([
                        { $match: { status: 'paid' } },  // Filter only 'paid' payments
                        { $group: { _id: null, totalAmount: { $sum: "$amount" } } }  // Sum the 'amount' field
                    ]),
                    // Daily data with hours
                    Payment.aggregate([
                        {
                            $match: {
                                createdAt: { $gte: today.toDate(), $lt: tomorrow.toDate() },
                                status: status
                            }
                        },
                        {
                            $group: {
                                _id: { hour: { $hour: "$createdAt" } },
                                total: { $sum: "$amount" }
                            }
                        },
                        { $sort: { "_id.hour": 1 } }
                    ]),
                ]);
                const revenueAmount = totalRevenue.length > 0 ? totalRevenue[0].totalAmount : 0;
                dashboardData.revenueStats = {
                    revenueAmount,
                    dailyData: formatDailyData(dailyData)
                };
            }
            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Dashboard data fetched successfully!",
                {
                    dashboardData

                }
            );
        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while getting dashboard data!",
                { error }
            );
        }
    }
}



function formatYearlyData(data) {
    const months = moment.months(); // Array of month names
    const formattedData = months.map((month, index) => ({
        month,
        total: 0
    }));

    data.forEach(item => {
        formattedData[item._id.month - 1].total = item.total;
    });

    return formattedData;
}

function formatMonthlyData(data) {
    const formattedData = Array(moment().daysInMonth())
        .fill(null)
        .map((_, index) => ({
            date: moment().startOf('month').add(index, 'days').format('YYYY-MM-DD'), // Full date
            total: 0
        }));

    data.forEach(item => {
        formattedData[item._id.day - 1].total = item.total;
    });

    return formattedData;
}

function formatWeeklyData(data) {
    const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    const formattedData = daysOfWeek.map(day => ({
        day,
        total: 0
    }));

    data.forEach(item => {
        formattedData[item._id.day - 1].total = item.total;
    });

    return formattedData;
}

function formatDailyData(data) {
    const formattedData = Array(24).fill(0).map((_, index) => ({
        time: moment().startOf('day').add(index, 'hours').format('hh:00 A'), // Time in AM/PM format
        total: 0
    }));

    data.forEach(item => {
        formattedData[item._id.hour].total = item.total;
    });

    return formattedData;
}
