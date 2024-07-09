"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const favProductSchema = new mongoose_1.Schema({
    userId: {
        type: String,
        required: true
    },
    productId: {
        type: String,
        required: true
    }
});
exports.default = (0, mongoose_1.model)('FavProduct', favProductSchema);
//# sourceMappingURL=favProduct.js.map