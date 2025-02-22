import dotenv from 'dotenv';
import mongoose from "mongoose";
import { DB_NAME, TEST_DB_NAME } from '../constants.js';

// dotenv.config({ path: './.env' });   //? Live DB
dotenv.config({ path: './.env.dev' });   //? Test DB

const connectDatabase = async () => {
    try {
        const DB_PATH = process.env.MODE == 'development' ?
            `${process.env.MONGODB_URI}/${TEST_DB_NAME}` :
            `${process.env.MONGODB_URI}/${DB_NAME}`;
        // console.log("DB_PATH: ", DB_PATH);
        const connectionInstance = await mongoose.connect(`${DB_PATH}`);
        console.log(
            `======================== \nMongoDB connected...!! \nDB HOST: ${connectionInstance.connection.host}\nDB Name: ${connectionInstance.connection.name}\n========================`
        );
    } catch (error) {
        console.log("MongoDB connection failed: ", error);
        process.exit(1);
    }
}

export default connectDatabase;