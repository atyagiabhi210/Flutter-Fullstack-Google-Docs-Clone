const mongoose = require("mongoose");

// schema is the blue print of how our data will be strored
const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  profilePic: {
    type: String,
    required: true,
  },
});

const User= mongoose.model("User", userSchema);

// this line makes the User model available to other files
module.exports= User;