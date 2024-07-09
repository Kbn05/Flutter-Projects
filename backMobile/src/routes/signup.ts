import { Router } from "express";
import User, { UserI } from "../types/user";
import { Conn } from "../db/conn.js";

export default class Signup {
  router: Router;
  constructor() {
    this.router = Router();
    this.routes();
  }

  routes() {
    this.router.post("/", async (req, res) => {
      const { username, password } = req.body as UserI;
      const connection = await Conn();
      try {
        const user = await User.findOne({ username: username });
        if (user) return res.status(409).send("User already exists");
        const newUser = new User({ username, password });
        await newUser.save();
        res.send("User created");
      } catch (error) {
        res.status(500).send(error);
      }
    });
  }
}