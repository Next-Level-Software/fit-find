import { StatusCodes } from "http-status-codes";
import { fileRemover, removeFile, uploadASingleFile, uploadMultipleFiles } from "../services/file.service.js";

export const fileController = {

    /**
     * Upload single file
     */
    async uploadSingleFile(req, res) {
        try {
            const file = req.file;
            if (!file) {
                return res.status(StatusCodes.BAD_GATEWAY).json({
                    statusCode: StatusCodes.BAD_GATEWAY,
                    isSuccess: false,
                    message: "File not received!",
                });
            }

            const uploadedFileName = await uploadASingleFile(file);
            if (uploadedFileName) {
                return res.status(StatusCodes.OK).json({
                    statusCode: StatusCodes.OK,
                    isSuccess: true,
                    message: "Single File uploaded successfully!",
                    fileName: uploadedFileName,
                });
            } else {
                return res.status(StatusCodes.CONFLICT).json({
                    statusCode: StatusCodes.CONFLICT,
                    isSuccess: false,
                    message: "Something went wrong while managing single File!",
                });
            }

        } catch (error) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
                statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
                isSuccess: false,
                message: "Error occurred in uploading single File!",
                error,
            });
        }
    },

    /**
     * Upload multiple files
     */
    async uploadMultipleFiles(req, res) {
        try {
            const files = req.files;

            if (!files.length) {
                return res.status(StatusCodes.BAD_GATEWAY).json({
                    statusCode: StatusCodes.BAD_GATEWAY,
                    isSuccess: false,
                    message: "Files not received!",
                });
            }

            const uploadedFileNames = await uploadMultipleFiles(files);
            if (uploadedFileNames) {
                return res.status(StatusCodes.OK).json({
                    statusCode: StatusCodes.OK,
                    isSuccess: true,
                    message: "Multiple Files uploaded successfully!",
                    fileNames: uploadedFileNames,
                });
            } else {
                return res.status(StatusCodes.CONFLICT).json({
                    statusCode: StatusCodes.CONFLICT,
                    isSuccess: false,
                    message: "Something went wrong while managing multiple Files!",
                });
            }

        } catch (error) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
                statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
                isSuccess: false,
                message: "Error occurred in uploading multiple Files!",
                error,
            });
        }
    },

    /**
     * Remove single file
     */
    async removeSingleFile(req, res) {
        try {
            const { fileName } = req.params;

            await removeFile(fileName);

            return res.status(StatusCodes.OK).json({
                statusCode: StatusCodes.OK,
                isSuccess: true,
                message: "Single File removed successfully!",
            });
        } catch (error) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
                statusCode: StatusCodes.INTERNAL_SERVER_ERROR,
                isSuccess: false,
                message: "Error occurred in removing single File!",
                error,
            });
        }
    },

};
