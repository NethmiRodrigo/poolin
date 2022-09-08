import express from "express";
import http from "http";
import { Server } from "socket.io";

const server = http.createServer();

const app = express();
const io = new Server(server);

const PORT = process.env.PORT || 3500;

app.route("/").get((req, res) => {
  res.json("Chat server up and running!");
});

io.on("connection", (socket) => {
  socket.on("joinRoom", (roomId, username) => {
     socket.join(roomId);

    io.to(roomId).emit(username + " joined the ride");
  });

  socket.on("sendMessage", (data) => {
    io.to(data.room).emit("sendMessage", data.message);
  });
});

server.listen(PORT, () => {
  console.log(`Chat server listening on port ${PORT}`);
});