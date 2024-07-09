import express, {Application} from 'express';
import helmet from 'helmet';
import cors from 'cors';
import morgan from 'morgan';
import {config} from 'dotenv';
import path from 'path';
import Signup from './routes/signup';
import Login from './routes/login';
import Products from './routes/products';

export default class App {
    App: Application;

    constructor() {
        this.App = express();
        this.settings();
        this.middlewares();
        this.routes();
    }

    settings() {
        config({path: path.join(__dirname, '../.env')});
        this.App.use(express.static(path.join(__dirname, '../../assets/img')));
        console.log(path.join(__dirname, '../../assets'));
        this.App.use(express.json());
        this.App.use(express.urlencoded({extended: true}));
        this.App.use(morgan('dev'));
        this.App.use(helmet());
    }

    middlewares() {
        this.App.use(cors());
    }

    routes() {
        this.App.get('/', (req, res) => {
            res.send('Hello World');
        });
        this.App.use('/signup', new Signup().router);
        this.App.use('/login', new Login().router);
        this.App.use('/products', new Products().router);
    }

    async listen() {
        const PORT = process.env.PORT ?? 3000
        const HOST = process.env.HOST ?? 'localhost'
        await this.App.listen(PORT, () => {
            console.log(`Server running at http://${HOST}:${PORT}`)
        })
    }
}

const app = new App();
app.listen();