const express = require("express");
const User = require("../models/user_model");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

const authRouter = express.Router();

authRouter.post("/docs/signup", async (req, res) => {
  try {
    // we are destructuring the object
    const { name, email, profilePic } = req.body;

    // email already exists? Do not store the data
    let user = await User.findOne({ email });
    if (!user) {
      user = new User({ name, email, profilePic });
      user = await user.save();
    }

    // create a token
    const token = jwt.sign(
      {
        id: user._id,
      },
      "passwordKey"
    );

    // when key and value name is same you can use shorthand version
    res.json({ user, token });
    // store the data
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ user, token: req.token });
  console.log(req.user); 
});

module.exports = authRouter;
