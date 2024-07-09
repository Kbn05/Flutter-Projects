"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const user_1 = __importDefault(require("../types/user"));
const conn_js_1 = require("../db/conn.js");
class Signup {
    constructor() {
        this.router = (0, express_1.Router)();
        this.routes();
    }
    routes() {
        this.router.post("/", (req, res) => __awaiter(this, void 0, void 0, function* () {
            const { username, password } = req.body;
            const connection = yield (0, conn_js_1.Conn)();
            try {
                const user = yield user_1.default.findOne({ username: username });
                if (user)
                    return res.status(409).send("User already exists");
                const newUser = new user_1.default({ username, password });
                yield newUser.save();
                res.send("User created");
            }
            catch (error) {
                res.status(500).send(error);
            }
        }));
    }
}
exports.default = Signup;
//# sourceMappingURL=signup.js.map