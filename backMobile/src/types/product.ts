import {model, Schema, Document} from 'mongoose';

export interface ProductI extends Document {
    image: string;
    name: string;
    owner: string;
    rate: number;
}

const productSchema = new Schema({
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

export default model<ProductI>('Product', productSchema);