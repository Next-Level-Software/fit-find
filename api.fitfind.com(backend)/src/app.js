import express from 'express';
import cors from 'cors';
import routes from "./startup/routes.js";
import { tokenChecker } from './middlewares/token.middleware.js';

const app = express();

app.use(
    cors({
        origin: process.env.CORS_ORIGIN,
        credentials: true,
    })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));
app.use(tokenChecker);
(async () => {
 
})();

//? routes
routes(app);

// routes declaration

export { app };
