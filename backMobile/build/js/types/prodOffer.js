"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const prodOfferSchema = new mongoose_1.Schema({
    price: {
        type: String,
        required: true
    },
    name: {
        type: String,
        required: true
    },
    discount: {
        type: Number,
        required: true
    },
    image: {
        type: String,
        required: true
    },
    rate: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    score: {
        type: String,
        required: true
    }
});
exports.default = (0, mongoose_1.model)('ProdOffer', prodOfferSchema);
//# sourceMappingURL=prodOffer.js.map