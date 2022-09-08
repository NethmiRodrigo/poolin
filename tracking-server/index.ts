import express from "express";
import http from "http";
import { Server } from "socket.io";

const server = http.createServer();

const app = express();
const io = new Server(server);

const PORT = process.env.PORT || 3700;

app.route("/").get((req, res) => {
  res.json("Tracking Server up and running!");
});

io.on("connection", (socket) => {
  // on event change, emit position to all clients
  socket.on("position-change", (data) => {
    console.log(data);
    io.emit("position-change", data);
  });

  socket.on("disconnect", () => {});
});

server.listen(PORT, () => {
  console.log(`Tracking server listening on port ${PORT}`);
});
