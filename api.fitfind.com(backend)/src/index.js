import connectDatabase from './database/database.js';
import { app } from './app.js';
import initializeSocket from './startup/socket.js';


const startServer = async () => {
    try {
        await connectDatabase();
        const server = initializeSocket(app);
        const PORT = process.env.PORT || 8000;
        server.listen(PORT, () => {
            console.log(`Server is running on port ${PORT}`);
        });
    } catch (err) {
        console.error('MongoDB connection failed:', err);
        process.exit(1);
    }
};

startServer();
