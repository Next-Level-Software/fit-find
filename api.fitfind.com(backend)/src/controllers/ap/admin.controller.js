import { StatusCodes } from "http-status-codes";
import { Admin,  User } from '../../startup/models.js';
import { badWordsCheck, generateApiResponse, generateStartEndDateStatement, randomStringGenerator } from "../../services/utilities.service.js";
import { compareEncryptedPassword, encryptPassword } from "../../services/password.service.js";
import { tokenCreator } from "../../services/token.service.js";
import moment from 'moment';
import { sendEmailForResetCode } from '../../services/email.service.js';
import { paginationFiltrationData } from "../../services/pagination.service.js";
import { fileRemover, uploadASingleFile } from "../../services/file.service.js";


export const adminController = {
    async createAdmin(req, res) {
        try {
            const {
                name,
                email,
                password,
                profilePhoto,
                accessTabs,
            } = req.body;

            const admin = await Admin.create({
                name,
                email,
                password,
                profilePhoto,
                accessTabs,
            });

            return generateApiResponse(
                res, StatusCodes.CREATED, true,
                "Admin created successfully!",
                { admin },
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while creating admin!",
                { error }
            );
        }
    },

    async updateAdmin(req, res, next) {
        try {
            const {
                _id,
                name,
                email,
                profilePhoto,
                accessTabs,
            } = req.body;

            const admin = await Admin.findByIdAndUpdate(_id, {
                name,
                email,
                profilePhoto,
                accessTabs,
            }, {
                new: true,
            });

            return generateApiResponse(
                res, StatusCodes.OK, true,
                'Admin updated successfully!',
                { admin }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while updating admin!",
                { error }
            )
        }
    },

    async deleteAdmin(req, res, next) {
        try {
            const _id = req.params.id;

            const deletedAdmin = await Admin.findByIdAndDelete(_id);

            if (!deletedAdmin) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Admin data not found!",
                );
            }

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Admin data deleted successfully!",
                { admin: deletedAdmin }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while deleting admin!",
                { error }
            )
        }
    },

    async loginAdmin(req, res, next) {
        try {
            const {
                email,
                password,
            } = req.body;

            const foundAdmin = await Admin.findOne({ email });

            const userPassword = foundAdmin ? foundAdmin.password : "";

            const isPasswordValid = await compareEncryptedPassword(password, userPassword);

            if (!isPasswordValid || !foundAdmin) {
                return generateApiResponse(
                    res, StatusCodes.UNAUTHORIZED, false,
                    "Incorrect email or password!",
                );
            }

            const token = tokenCreator(foundAdmin?.toObject());

            return generateApiResponse(
                res, StatusCodes.ACCEPTED, true,
                "Admin logged in successfully!",
                { token }
            );

        } catch (error) {
            return generateApiResponse(
                res, StatusCodes.INTERNAL_SERVER_ERROR, false,
                "Error occurred while logging in admin!",
                { error }
            )
        }
    },

    /**
 * Forgot Password
 */

    async forgotPassword(req, res, next) {
        try {
            const {
                email,
            } = req.body;

            const findAdmin = await Admin.findOne({ email });

            if (!findAdmin) {
                return generateApiResponse(
                    res, StatusCodes.UNAUTHORIZED, false,
                    "No admin found against this email",
                );
            }

            await ResetCode.deleteMany({ email });

            const name = findAdmin?.name;

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
                "Error occurred while forgot password for admin!",
                { error }
            )
        }
    },

    async verifyCode(req, res, next) {
        try {
            const { email, code } = req.body;

            const findAdmin = await Admin.findOne({ email });

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

            const token = tokenCreator(findAdmin?.toObject());
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

            const foundAdmin = await Admin.findById(_id, 'password');
            if (!foundAdmin) {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Admin not found!",
                );
            }

            const verifyPassword = await compareEncryptedPassword(oldPassword, foundAdmin?.password);
            if (!verifyPassword) {
                return generateApiResponse(
                    res, StatusCodes.CONFLICT, false,
                    "Old Password is incorrect!",
                );
            }

            const encryptedPassword = await encryptPassword(newPassword);
            await Admin.findByIdAndUpdate(_id, { password: encryptedPassword });
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

            const adminsCount = await Admin.countDocuments({ _id: _id });
            if (!adminsCount) {
                return generateApiResponse(
                    res, StatusCodes.CONFLICT, false,
                    "Admin not found!",
                );
            }

            const encryptedPassword = await encryptPassword(password);
            await Admin.findByIdAndUpdate(_id, { password: encryptedPassword });
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
            const adminId = req.user._id;
            const foundAdmin = await Admin.findById(adminId);

            if (foundAdmin) {
                const token = tokenCreator(foundAdmin?.toObject());
                return generateApiResponse(
                    res, StatusCodes.OK, true,
                    "My Token refreshed successfully!",
                    { token },
                );

            } else {
                return generateApiResponse(
                    res, StatusCodes.NOT_FOUND, false,
                    "Admin not found!",
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
            const foundAdmin = await Admin.findById(_id);

            if (foundAdmin) {
                return generateApiResponse(
                    res, StatusCodes.OK, true,
                    "My Profile fetched successfully!",
                    { admin: foundAdmin },
                );
            } else {
                return generateApiResponse(
                    res, StatusCodes.BAD_REQUEST, false,
                    "Admin not found!"
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
                const isEmailUsedByAdmin = await Admin.countDocuments({ _id: { $ne: _id }, email: email });
                const isEmailUsedByUser = await User.countDocuments({ email: email });
                if (isEmailUsedByAdmin || isEmailUsedByUser) {
                    return generateApiResponse(
                        res, StatusCodes.CONFLICT, false,
                        "Email already used by another account!",
                    );
                }
            }
            const file = req.file;
            const foundAdmin = await Admin.findById(_id, 'profilePhoto');

            let profilePhoto = foundAdmin?.profilePhoto;
            if (file)
                profilePhoto = await uploadASingleFile(file);

            const updatedAdmin = await Admin.findByIdAndUpdate(
                _id,
                {
                    email,
                    name,
                    profilePhoto,
                    accessTabs,
                },
                { new: true },
            );

            if (profilePhoto != foundAdmin?.profilePhoto) { fileRemover(foundAdmin?.profilePhoto) };

            const token = tokenCreator(updatedAdmin?.toObject());
            if (updatedAdmin) {
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

            const foundAdmin = await Admin.findOne({ email: email });
            if (!foundAdmin) {
                return generateApiResponse(
                    res, StatusCodes.CONFLICT, false,
                    "No Admin found against this email!",
                );
            }

            const resetCode = randomStringGenerator(6, 'numeric');
            await sendResetCodeEmail(foundAdmin?.email, resetCode);

            const token = tokenCreator(foundAdmin?.toObject());
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
            const filteredData = await paginationFiltrationData(Admin, req.query, 'admins', searchAttributes, whereStatement);

            return generateApiResponse(
                res, StatusCodes.OK, true,
                "Admins by filter fetched successfully!",
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
            var totalAdmins,
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
                    totalAdmins,
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
                    Admin.countDocuments(),
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
                    totalAdmins,
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
