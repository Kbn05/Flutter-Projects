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
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const user_1 = __importDefault(require("../types/user"));
const conn_js_1 = require("../db/conn.js");
class Login {
    constructor() {
        this.router = (0, express_1.Router)();
        this.routes();
    }
    routes() {
        this.router.post("/", (req, res) => __awaiter(this, void 0, void 0, function* () {
            var _a;
            const { username, password } = req.body;
            const secret = (_a = process.env.SECRET) !== null && _a !== void 0 ? _a : 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd';
            const connection = yield (0, conn_js_1.Conn)();
            try {
                const user = yield user_1.default.findOne({ username: username });
                if (!user)
                    return res.status(404).send("Invalid username or password");
                const id = user["id"];
                const isMatch = yield user.comparePassword(password.toString());
                if (isMatch) {
                    const token = jsonwebtoken_1.default.sign({ username, id, exp: Math.floor(Date.now() / 1000) + (240) }, secret);
                    res.send(token);
                }
                else
                    res.status(404).send("Invalid username or password");
            }
            catch (error) {
                res.status(500).send;
            }
        }));
        this.router.post("/longToken", (req, res) => __awaiter(this, void 0, void 0, function* () {
            var _b;
            const token = req.headers.authorization.split(' ')[1];
            if (!token)
                return res.status(401).send("Access denied");
            const { username, password } = req.body;
            const secret = (_b = process.env.SECRET) !== null && _b !== void 0 ? _b : 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd';
            const connection = yield (0, conn_js_1.Conn)();
            try {
                const user = yield user_1.default.findOne({ username: username });
                if (!user)
                    return res.status(404).send("Invalid username or password");
                const id = user["id"];
                const isMatch = yield user.comparePassword(password.toString());
                if (isMatch) {
                    const token = jsonwebtoken_1.default.sign({ username, id, exp: Math.floor(Date.now() / 1000) + (60 * 60) }, secret);
                    res.send(token);
                }
                else
                    res.status(404).send("Invalid username or password");
            }
            catch (error) {
                res.status(500).send;
            }
        }));
        this.router.post("/validate", (req, res) => __awaiter(this, void 0, void 0, function* () {
            var _c;
            const token = req.headers.authorization.split(' ')[1];
            if (!token)
                return res.status(401).send("Access denied");
            const secret = (_c = process.env.SECRET) !== null && _c !== void 0 ? _c : 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd';
            try {
                const verify = jsonwebtoken_1.default.verify(token, secret);
                if (verify) {
                    const id = verify["id"];
                    const username = verify["username"];
                    const token = jsonwebtoken_1.default.sign({ username, id, exp: Math.floor(Date.now() / 1000) + (240) }, secret);
                    res.send(token);
                }
            }
            catch (error) {
                res.status(401).send("Invalid token");
            }
        }));
    }
}
exports.default = Login;
//# sourceMappingURL=login.js.map