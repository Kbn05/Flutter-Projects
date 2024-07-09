import {model, Schema, Document} from 'mongoose';

export interface FavProductI extends Document {
    userId: string,
    productId: string
}

const favProductSchema = new Schema({
    userId: {
        type: String,
        required: true
    },
    productId: {
        type: String,
        required: true
    }
});

export default model<FavProductI>('FavProduct', favProductSchema);