const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const jwt = require('jsonwebtoken');

//sign up
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists" });
    }

    const hasedPassword = await bcryptjs.hash(password, 8);
    let user = User({
      email,
      password: hasedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//Sign in
authRouter.post("/api/signin", async (req, res) => {
  try {
    const {email,password} = req.body;
    const user = User.findOne({email});
    if(!user){
        return res
        .status(400)
        .json({msg: "User with this email does not exist"});
    }
    const isMatch = await bcryptjs.compare(password, user.password);
    if(!isMatch){
        return res.status(400)
        .json({msg: "Incorrect Password."});
    }
    const token = jwt.sign({id: user._id}, "passwordKey");
    res.json({token, ...user._doc});

  } catch (e) {
    res.status(500).json({error: e.message});
  }
});

module.exports = authRouter;
