//import packages
const express = require("express");
const mongoose = require("mongoose");

//importing from other files
const authRouter = require("./routes/auth");

//installization
const app = express();
const Dburl =
  "mongodb+srv://duipangre:AdPjREq8b6ifsOFt@cluster0.qda52wh.mongodb.net/?retryWrites=true&w=majority";

//middleware
app.use(express.json());
app.use(authRouter);

//database connection
mongoose
  .connect(Dburl)
  .then(() => {
    console.log("Database connected");
  })
  .catch((e) => {
    console.log(e);
  });

//creating an endpoint, 3000 is port number
app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
