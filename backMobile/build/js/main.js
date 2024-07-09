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
const express_1 = __importDefault(require("express"));
const helmet_1 = __importDefault(require("helmet"));
const cors_1 = __importDefault(require("cors"));
const morgan_1 = __importDefault(require("morgan"));
const dotenv_1 = require("dotenv");
const path_1 = __importDefault(require("path"));
const signup_1 = __importDefault(require("./routes/signup"));
const login_1 = __importDefault(require("./routes/login"));
const products_1 = __importDefault(require("./routes/products"));
class App {
    constructor() {
        this.App = (0, express_1.default)();
        this.settings();
        this.middlewares();
        this.routes();
    }
    settings() {
        (0, dotenv_1.config)({ path: path_1.default.join(__dirname, '../.env') });
        this.App.use(express_1.default.static(path_1.default.join(__dirname, '../../assets/img')));
        console.log(path_1.default.join(__dirname, '../../assets'));
        this.App.use(express_1.default.json());
        this.App.use(express_1.default.urlencoded({ extended: true }));
        this.App.use((0, morgan_1.default)('dev'));
        this.App.use((0, helmet_1.default)());
    }
    middlewares() {
        this.App.use((0, cors_1.default)());
    }
    routes() {
        this.App.get('/', (req, res) => {
            res.send('Hello World');
        });
        this.App.use('/signup', new signup_1.default().router);
        this.App.use('/login', new login_1.default().router);
        this.App.use('/products', new products_1.default().router);
    }
    listen() {
        var _a, _b;
        return __awaiter(this, void 0, void 0, function* () {
            const PORT = (_a = process.env.PORT) !== null && _a !== void 0 ? _a : 3000;
            const HOST = (_b = process.env.HOST) !== null && _b !== void 0 ? _b : 'localhost';
            yield this.App.listen(PORT, () => {
                console.log(`Server running at http://${HOST}:${PORT}`);
            });
        });
    }
}
exports.default = App;
const app = new App();
app.listen();
//# sourceMappingURL=main.js.map