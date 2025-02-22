import { generateErrorApiResponse } from "./utilities.service.js";

const asyncHandler = (fn) => async (req, res, next) => {
    try {
        return await fn(req, res, next);
    } catch (error) {
        return generateErrorApiResponse(res, { error });
    }
};

export { asyncHandler };
