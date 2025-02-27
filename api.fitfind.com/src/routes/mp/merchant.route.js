import express from "express";
var router = express.Router();
import { merchantController } from "../../controllers/mp/merchant.controller.js";
import {
  validateApiAttributes,
  checkApiValidation,
} from "../../middlewares/validators.middleware.js";



export default router;
