import mongoose from 'mongoose';
import dotenv from 'dotenv';
import path from 'path';

export async function Conn() {
    try{
        dotenv.config({path: path.join(__dirname, '../.env')});
        const URI = process.env.URI ?? 'mongodb://127.0.0.1:27017/parcialMovil';
        const options = {
            useNewUrlParser: true,
            useUnifiedTopology: true,
            user: process.env.USER ?? '',
            pass: process.env.PASS ?? '',
        };
        mongoose.set('strictQuery', true);
        const conn = await mongoose.connect(URI, options).then(() => console.log('Database connected'));
        return conn;
    } catch (err) {
        console.log(err);
    }
};