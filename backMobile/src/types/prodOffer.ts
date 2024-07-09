import {model, Schema, Document} from 'mongoose';

export interface ProdOfferI extends Document {
    price: string;
    name: string;
    discount: number;
    image: string;
    rate: string
    description: string;
    score: string;
}

const prodOfferSchema = new Schema({
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

export default model<ProdOfferI>('ProdOffer', prodOfferSchema);