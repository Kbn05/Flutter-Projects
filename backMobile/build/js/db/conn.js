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
exports.Conn = void 0;
const mongoose_1 = __importDefault(require("mongoose"));
const dotenv_1 = __importDefault(require("dotenv"));
const path_1 = __importDefault(require("path"));
function Conn() {
    var _a, _b, _c;
    return __awaiter(this, void 0, void 0, function* () {
        try {
            dotenv_1.default.config({ path: path_1.default.join(__dirname, '../.env') });
            const URI = (_a = process.env.URI) !== null && _a !== void 0 ? _a : 'mongodb://127.0.0.1:27017/parcialMovil';
            const options = {
                useNewUrlParser: true,
                useUnifiedTopology: true,
                user: (_b = process.env.USER) !== null && _b !== void 0 ? _b : '',
                pass: (_c = process.env.PASS) !== null && _c !== void 0 ? _c : '',
            };
            mongoose_1.default.set('strictQuery', true);
            const conn = yield mongoose_1.default.connect(URI, options).then(() => console.log('Database connected'));
            return conn;
        }
        catch (err) {
            console.log(err);
        }
    });
}
exports.Conn = Conn;
;
//# sourceMappingURL=conn.js.map