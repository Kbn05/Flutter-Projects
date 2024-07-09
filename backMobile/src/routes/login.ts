import { Router } from "express";
import jwt from "jsonwebtoken";
import User, {UserI} from "../types/user";
import {Conn} from "../db/conn.js";
import bcrypt from "bcryptjs";

export default class Login {
  router: Router;
  constructor() {
    this.router = Router();
    this.routes();
  }

  routes() {
    this.router.post("/", async (req, res) => {
      const { username, password } = req.body as UserI;
      const secret = process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd';
      const connection = await Conn();
      try{
        const user = await User.findOne({ username: username });
        if (!user) return res.status(404).send("Invalid username or password");
        const id = user["id"];
        const isMatch = await user.comparePassword(password.toString());
        if (isMatch) {
          const token = jwt.sign({ username, id, exp: Math.floor(Date.now() / 1000) + (240) }, secret);
        res.send(token)}
        else res.status(404).send("Invalid username or password");
      } catch (error) {
        res.status(500).send
      }
    });

    this.router.post("/longToken", async (req, res) => {
      const token = req.headers.authorization.split(' ')[1];
      if (!token) return res.status(401).send("Access denied");
      const { username, password } = req.body as UserI;
      const secret = process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd';
      const connection = await Conn();
      try{
        const user = await User.findOne({ username: username });
        if (!user) return res.status(404).send("Invalid username or password");
        const id = user["id"];
        const isMatch = await user.comparePassword(password.toString());
        if (isMatch) {
          const token = jwt.sign({ username, id, exp: Math.floor(Date.now() / 1000) + (60*60) }, secret);
        res.send(token)}
        else res.status(404).send("Invalid username or password");
      } catch (error) {
        res.status(500).send
      }
    });

    this.router.post("/validate", async (req, res) => {
      const token = req.headers.authorization.split(' ')[1];
      if (!token) return res.status(401).send("Access denied");
      const secret = process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd';
      try {
        const verify = jwt.verify(token, secret);
        if (verify) {
          const id = verify["id"];
          const username = verify["username"];
          const token = jwt.sign({ username, id, exp: Math.floor(Date.now() / 1000) + (240) }, secret);
          res.send(token);
        }
      } catch (error) {
        res.status(401).send("Invalid token");
      }
    });
  }
}