"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const productSchema = new mongoose_1.Schema({
    image: {
        type: String,
        required: true
    },
    name: {
        type: String,
        required: true
    },
    owner: {
        type: String,
        required: true
    },
    rate: {
        type: Number,
        required: true
    }
});
exports.default = (0, mongoose_1.model)('Product', productSchema);
//# sourceMappingURL=product.js.map