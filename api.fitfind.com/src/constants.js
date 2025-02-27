export const DB_NAME = "fitfind";
export const TEST_DB_NAME = "fitfinddev";

const ModelNames = {
  Activity: { model: "Activity", db: "activities" },
  Address: { model: "Address", db: "addresses" },
  Admin: { model: "Admin", db: "admins" },
  Banner: { model: "Banner", db: "banners" },
  Brand: { model: "Brand", db: "brands" },
  Cart: { model: "Cart", db: "carts" },
  Category: { model: "Category", db: "categories" },
  Class: { model: "Class", db: "classes" },
  ClassBooking: { model: "ClassBooking", db: "classbookings" },
  Config: { model: "Config", db: "configs" },
  FAQ: { model: "Faq", db: "faqs" },
  Merchant: { model: "Merchant", db: "merchants" },
  MerchantSubscription: {
    model: "MerchantSubscription",
    db: "merchantsubscriptions",
  },
  MerchantSubscriptionPlan: {
    model: "MerchantSubscriptionPlan",
    db: "merchantsubscriptionplans",
  },
  Notification: { model: "Notification", db: "notifications" },
  Order: { model: "Order", db: "orders" },
  OrderItems: { model: "OrderItems", db: "orderitems" },
  PaymentMethod: { model: "PaymentMethod", db: "paymentmethods" },
  Product: { model: "Product", db: "products" },
  ResetCode: { model: "ResetCode", db: "resetcode" },
  Review: { model: "Review", db: "reviews" },
  Subscription: { model: "Subscription", db: "subscriptions" },
  SubscriptionPlan: { model: "SubscriptionPlan", db: "subscriptionPlans" },
  Transaction: { model: "Transaction", db: "transactions" },
  User: { model: "User", db: "users" },
  UserLog: { model: "UserLog", db: "userlogs" },
  WithdrawRequest: { model: "WithdrawRequest", db: "withdrawrequests" },
  BankAccount: { model: "BankAccount", db: "bankaccounts" },
  DeliveryRate: { model: "DeliveryRate", db: "deliveryrates" },
  Coupon: { model: "Coupon", db: "coupons" },
};

export { ModelNames };
