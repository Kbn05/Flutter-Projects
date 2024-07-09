"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
class Users {
    constructor() {
        this.router = (0, express_1.Router)();
        this.routes();
    }
    routes() {
        this.router.get("/", (req, res) => {
            res.send("Hello World from Users!");
        });
        this.router.get("/:id", (req, res) => {
            const { id } = req.params;
            res.send(`Hello World from Users ${id}!`);
        });
    }
}
exports.default = Users;
//# sourceMappingURL=users.js.map