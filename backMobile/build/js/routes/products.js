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
const conn_js_1 = require("../db/conn.js");
const product_1 = __importDefault(require("../types/product"));
const favProduct_js_1 = __importDefault(require("../types/favProduct.js"));
const prodOffer_js_1 = __importDefault(require("../types/prodOffer.js"));
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
class Products {
    constructor() {
        this.router = (0, express_1.Router)();
        this.routes();
    }
    routes() {
        this.router.get("/", (req, res) => {
            var _a;
            const token = req.headers.authorization.split(' ')[1];
            if (!token)
                return res.status(401).send("Access denied");
            try {
                const validToken = jsonwebtoken_1.default.verify(token, (_a = process.env.SECRET) !== null && _a !== void 0 ? _a : 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
                if (validToken) {
                    (0, conn_js_1.Conn)().then(() => __awaiter(this, void 0, void 0, function* () {
                        const products = yield product_1.default.find();
                        const productsWithImages = products.map(product => (Object.assign(Object.assign({}, product.toObject()), { image: `http://10.153.82.39:3000/${product.image}` })));
                        res.send(productsWithImages);
                        // res.send(products);
                    }));
                }
            }
            catch (err) {
                if (err instanceof jsonwebtoken_1.default.TokenExpiredError) {
                    res.status(401).send("Token expired");
                }
                else {
                    res.status(500).send("Internal Server Error");
                }
            }
        });
        this.router.get("/img/:id", (req, res) => {
            // const token = req.headers.authorization.split(' ')[1];
            // if (!token) return res.status(401).send("Access denied");
            const { id } = req.params;
            try {
                // const validToken = jwt.verify(token, process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
                // if (validToken) {
                res.sendFile(`./assets/img/${id}.jpg`, { root: '.' });
                // }
            }
            catch (err) {
                if (err instanceof jsonwebtoken_1.default.TokenExpiredError) {
                    res.status(401).send("Token expired");
                }
                else {
                    res.status(500).send(err);
                }
            }
        });
        this.router.post("/", (req, res) => {
            var _a;
            const token = req.headers.authorization.split(' ')[1];
            if (!token)
                return res.status(401).send("Access denied");
            try {
                const validToken = jsonwebtoken_1.default.verify(token, (_a = process.env.SECRET) !== null && _a !== void 0 ? _a : 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
                if (validToken) {
                    const filePath = path_1.default.join('src', 'db', 'product.json');
                    console.log(filePath);
                    fs_1.default.readFile(filePath, 'utf8', (err, data) => {
                        if (err) {
                            console.error('Error al leer el archivo JSON:', err);
                            return res.status(500).send("Internal Server Error");
                        }
                        try {
                            const productsData = JSON.parse(data);
                            productsData.forEach((productData) => __awaiter(this, void 0, void 0, function* () {
                                // const { image, name, owner, rate } = productData;
                                // const newProduct = new Product({ image, name, owner, rate });
                                // await newProduct.save();
                                const { price, name, discount, image, rate, description, score } = productData;
                                const newProduct = new prodOffer_js_1.default({ price, name, discount, image, rate, description, score });
                                yield newProduct.save();
                            }));
                            res.send("Products created");
                        }
                        catch (parseError) {
                            console.error('Error al parsear los datos del archivo JSON:', parseError);
                            res.status(500).send("Internal Server Error");
                        }
                    });
                }
            }
            catch (err) {
                if (err instanceof jsonwebtoken_1.default.TokenExpiredError) {
                    res.status(401).send("Token expired");
                }
                else {
                    res.status(500).send("Internal Server Error");
                }
            }
        });
        this.router.get("/fav", (req, res) => {
            var _a;
            const token = req.headers.authorization.split(' ')[1];
            if (!token)
                return res.status(401).send("Access denied");
            try {
                const products = [];
                const validToken = jsonwebtoken_1.default.verify(token, (_a = process.env.SECRET) !== null && _a !== void 0 ? _a : 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
                if (validToken) {
                    (0, conn_js_1.Conn)().then(() => __awaiter(this, void 0, void 0, function* () {
                        const favProducts = yield favProduct_js_1.default.find({ userId: validToken["id"] });
                        const productPromises = favProducts.map((fav) => __awaiter(this, void 0, void 0, function* () {
                            const product = yield product_1.default.findById(fav.productId);
                            return product;
                        }));
                        const products = yield Promise.all(productPromises);
                        const productsWithImages = products.map(product => (Object.assign(Object.assign({}, product.toObject()), { image: `http://10.153.82.39:3000/${product.image}` })));
                        res.send(productsWithImages);
                        // res.send(products);
                    }));
                }
                else {
                    res.status(401).send("Unauthorized");
                }
            }
            catch (err) {
                res.status(500).send("Internal Server Error");
            }
        });
        this.router.post("/fav", (req, res) => {
            var _a;
            const token = req.headers.authorization.split(' ')[1];
            if (!token)
                return res.status(401).send("Access denied");
            try {
                const validToken = jsonwebtoken_1.default.verify(token, (_a = process.env.SECRET) !== null && _a !== void 0 ? _a : 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
                if (validToken) {
                    const { productId } = req.body;
                    (0, conn_js_1.Conn)().then(() => __awaiter(this, void 0, void 0, function* () {
                        const product = yield favProduct_js_1.default.findOne({ userId: validToken["id"], productId: productId });
                        if (product) {
                            res.status(409).send("Product already in favorites");
                        }
                        else {
                            const newFavProduct = new favProduct_js_1.default({ userId: validToken["id"], productId: productId });
                            newFavProduct.save().then(() => res.send("Product added to favorites"));
                        }
                    }));
                }
                else {
                    res.status(401).send("Unauthorized");
                }
            }
            catch (err) {
                res.status(500).send("Internal Server Error");
            }
        });
        this.router.delete("/fav", (req, res) => {
            var _a;
            const token = req.headers.authorization.split(' ')[1];
            if (!token)
                return res.status(401).send("Access denied");
            try {
                const validToken = jsonwebtoken_1.default.verify(token, (_a = process.env.SECRET) !== null && _a !== void 0 ? _a : 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
                if (validToken) {
                    const { productId } = req.body;
                    favProduct_js_1.default.deleteOne({ userId: validToken["id"], productId: productId }).then(() => res.send("Product removed from favorites"));
                }
                else {
                    res.status(401).send("Unauthorized");
                }
            }
            catch (err) {
                res.status(500).send("Internal Server Error");
            }
        });
        this.router.get("/prod", (req, res) => {
            var _a;
            const token = req.headers.authorization.split(' ')[1];
            if (!token)
                return res.status(401).send("Access denied");
            try {
                const validToken = jsonwebtoken_1.default.verify(token, (_a = process.env.SECRET) !== null && _a !== void 0 ? _a : 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
                if (validToken) {
                    (0, conn_js_1.Conn)().then(() => __awaiter(this, void 0, void 0, function* () {
                        const products = yield prodOffer_js_1.default.find();
                        const productsWithImages = products.map(product => (Object.assign(Object.assign({}, product.toObject()), { image: `${product.image}` })));
                        res.send(productsWithImages);
                        // res.send(products);
                    }));
                }
            }
            catch (err) {
                if (err instanceof jsonwebtoken_1.default.TokenExpiredError) {
                    res.status(401).send("Token expired");
                }
                else {
                    res.status(500).send("Internal Server Error");
                }
            }
        });
    }
}
exports.default = Products;
//# sourceMappingURL=products.js.map