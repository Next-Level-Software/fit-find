import http from 'http';
import { Server as socketIO } from 'socket.io';

export default (app) => {
    const server = http.createServer(app); // Create HTTP server with Express app
    const io = new socketIO(server, {
        cors: {
            origin: "*",
            methods: ['POST', "GET"],
        }
    });       // Attach Socket.IO to the server

    io.on("connection", (socket) => {
        console.log('A user connected:', socket.id);

        // socket.on('send_message', ({ jobId, ...messageData }) => {
        //     io.emit(`receive_message${jobId}`, messageData);
        // });

  
        socket.on("disconnect", () => {
            console.log("User disconnected:", socket.id);
        });
    });

    return server; // Export the server to be used in app.js
};
