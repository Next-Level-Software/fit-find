import express from 'express';
import { fileController } from '../controllers/file.js';
import { multerSingleUploadRoute, multerMultipleUploadRoute, fileNameGenerator, singleUploadRoute, multiUploadRoute } from '../services/file.service.js';
import dotenv from 'dotenv';
import httpStatusCodes from 'http-status-codes';
import multer from 'multer';
import aws_sdk from 'aws-sdk';

dotenv.config();

const router = express.Router();

// AWS Configuration
aws_sdk.config.update({
    accessKeyId: process.env.AWS_ACCESS_KEY,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    region: process.env.AWS_REGION,
});
const s3Config = new aws_sdk.S3();
const upload = multer({ storage: multer.memoryStorage() });

// Routes & Functions
router.put("/upload-single", singleUploadRoute, fileController.uploadSingleFile);
router.put("/upload-multiple", multiUploadRoute, fileController.uploadMultipleFiles);
router.delete("/remove-single/:fileName", fileController.removeSingleFile);

export default router;
