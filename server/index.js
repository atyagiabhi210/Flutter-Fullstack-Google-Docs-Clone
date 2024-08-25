const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const http = require("http");
require("dotenv").config();
const Document = require("./models/document_model");

const cors = require("cors");
const documentRouter = require("./routes/document");
const PORT = process.env.PORT | 12217;
//12217
// 3001

const app = express();
var server = http.createServer(app);
var io = require("socket.io")(server);

app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(documentRouter);

const DB = process.env.MONGO_URI;

// "mongodb+srv://abhishek:Xn2YZ3T06siWM4Bo@docsclone.fsrzw.mongodb.net/?retryWrites=true&w=majority&appName=DocsClone";

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.log("Error connecting to MongoDB", err);
  });

// async--> await
// .then()
io.on("connection", (socket) => {
  socket.on("join", (documentId) => {
    socket.join(documentId);
    console.log("Connected to socket" + socket.id);
  });

  socket.on("typing", (data) => {
    socket.broadcast.to(data.room).emit("changes", data);
  });

  socket.on("save", (data) => {
    saveData(data);
  });
});
const saveData = async (data) => {
  let document = await Document.findById(data.room);
  document.content = data.delta;
  document = await document.save();
};
server.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected at port ${PORT}`);
});

console.log("Server is running");
console.log(PORT);
