import connectDatabase from "../database/database.js";

import Activity from "../models/activity.model.js";
import Address from "../models/address.model.js";
import Admin from "../models/admin.model.js";
import Banner from "../models/banner.model.js";
import Brand from "../models/brand.model.js";
import Cart from "../models/cart.model.js";
import Category from "../models/category.model.js";
import Class from "../models/class.model.js";
import ClassBooking from "../models/classbooking.model.js";
import Config from "../models/config.model.js";
import FAQ from "../models/faq.model.js";
import Merchant from "../models/merchant.model.js";
import MerchantSubscription from "../models/merchantsubscription.model.js";
import MerchantSubscriptionPlan from "../models/merchantsubscriptionplan.model.js";
import Notification from "../models/notification.model.js";
import Order from "../models/order.model.js";
import OrderItem from "../models/orderitem.model.js";
import PaymentMethod from "../models/paymentmethod.model.js";
import Product from "../models/product.model.js";
import ResetCode from "../models/resetcode.model.js";
import Review from "../models/review.model.js";
import Subscription from "../models/subscription.model.js";
import SubscriptionPlan from "../models/subscriptionplan.model.js";
import Transaction from "../models/transaction.model.js";
import User from "../models/user.model.js";
import UserLog from "../models/userlog.model.js";
import WithdrawRequest from "../models/withdrawrequest.model.js";
import BankAccount from "../models/bankaccount.model.js";
import DeliveryRate from "../models/deliveryrate.model.js";

// Connect to the database
connectDatabase();

export {
    Activity,
    Address,
    Admin,
    Banner,
    Brand,
    Cart,
    Category,
    Class,
    ClassBooking,
    Config,
    FAQ,
    Merchant,
    MerchantSubscription,
    MerchantSubscriptionPlan,
    Notification,
    Order,
    OrderItem,
    PaymentMethod,
    Product,
    ResetCode,
    Review,
    Subscription,
    SubscriptionPlan,
    Transaction,
    User,
    UserLog,
    WithdrawRequest,
    BankAccount,
    DeliveryRate,
};
