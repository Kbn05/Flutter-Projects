import { Router } from "express";
import jwt from "jsonwebtoken";
import { Conn } from "../db/conn.js";
import Product, { ProductI } from "../types/product";
import favProduct, {FavProductI} from "../types/favProduct.js";
import ProdOffer from "../types/prodOffer.js";
import fs from "fs";
import path from "path";

export default class Products {
  router: Router;
  constructor() {
    this.router = Router();
    this.routes();
  }

  routes() {
    this.router.get("/", (req, res) => {
        const token = req.headers.authorization.split(' ')[1];
        if (!token) return res.status(401).send("Access denied");
        try {
            const validToken = jwt.verify(token, process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
            if (validToken) {
                Conn().then(async () => {
                    const products = await Product.find();
                    const productsWithImages = products.map(product => ({
                      ...product.toObject(),
                      image: `http://10.153.82.39:3000/${product.image}`
                    }));
                    res.send(productsWithImages);
                    // res.send(products);
                }
              );
            }
        } catch (err) {
            if (err instanceof jwt.TokenExpiredError) {
                res.status(401).send("Token expired");
            } else {
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
      } catch (err) {
          if (err instanceof jwt.TokenExpiredError) {
              res.status(401).send("Token expired");
          } else {
              res.status(500).send(err);
          }
      }
  });

    this.router.post("/", (req, res) => {
      const token = req.headers.authorization.split(' ')[1];
      if (!token) return res.status(401).send("Access denied");
      try {
          const validToken = jwt.verify(token, process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
          if (validToken) {
              const filePath = path.join('src', 'db', 'product.json');
              console.log(filePath);
  
              fs.readFile(filePath, 'utf8', (err, data) => {
                  if (err) {
                      console.error('Error al leer el archivo JSON:', err);
                      return res.status(500).send("Internal Server Error");
                  }
  
                  try {
                      const productsData = JSON.parse(data);
                      productsData.forEach(async (productData: any) => {
                          // const { image, name, owner, rate } = productData;
                          // const newProduct = new Product({ image, name, owner, rate });
                          // await newProduct.save();
                          const {price, name, discount, image, rate, description, score} = productData;
                          const newProduct = new ProdOffer({price, name, discount, image, rate, description, score});
                          await newProduct.save();
                      });
  
                      res.send("Products created");
                  } catch (parseError) {
                      console.error('Error al parsear los datos del archivo JSON:', parseError);
                      res.status(500).send("Internal Server Error");
                  }
              });
          }
      } catch (err) {
          if (err instanceof jwt.TokenExpiredError) {
              res.status(401).send("Token expired");
          } else {
              res.status(500).send("Internal Server Error");
          }
      }
  });

  this.router.get("/fav", (req, res) => {
    const token = req.headers.authorization.split(' ')[1];
    if (!token) return res.status(401).send("Access denied");
    try {
      const products = [];
      const validToken = jwt.verify(token, process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
      if (validToken) {
        Conn().then(async () => {
          const favProducts = await favProduct.find({userId: validToken["id"]});
          const productPromises = favProducts.map(async (fav) => {
            const product = await Product.findById(fav.productId);
            return product; 
          });
          const products = await Promise.all(productPromises);
          const productsWithImages = products.map(product => ({
            ...product.toObject(),
            image: `http://10.153.82.39:3000/${product.image}`
          }));
          res.send(productsWithImages);
          // res.send(products);
        });
      } else {  
        res.status(401).send("Unauthorized");
      }
    } catch (err) {
      res.status(500).send("Internal Server Error");
    }
  });

  this.router.post("/fav", (req, res) => {
    const token = req.headers.authorization.split(' ')[1];
    if (!token) return res.status(401).send("Access denied");
    try {
      const validToken = jwt.verify(token, process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
      if (validToken) {
        const { productId } = req.body as FavProductI;
        Conn().then(async () => {
          const product = await favProduct.findOne({userId: validToken["id"], productId: productId});
          if (product) {
            res.status(409).send("Product already in favorites");
          }else{
            const newFavProduct = new favProduct({userId: validToken["id"], productId: productId});
            newFavProduct.save().then(() => res.send("Product added to favorites"));
          }
        });
      } else {
        res.status(401).send("Unauthorized");
      }
    } catch (err) {
      res.status(500).send("Internal Server Error");
    }
  });

  this.router.delete("/fav", (req, res) => {
    const token = req.headers.authorization.split(' ')[1];
    if (!token) return res.status(401).send("Access denied");
    try {
      const validToken = jwt.verify(token, process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
      if (validToken) {
        const { productId } = req.body as FavProductI;
        favProduct.deleteOne({userId: validToken["id"], productId: productId}).then(() => res.send("Product removed from favorites"));
      } else {
        res.status(401).send("Unauthorized");
      }
    } catch (err) {
      res.status(500).send("Internal Server Error");
    }
  });

  this.router.get("/prod", (req, res) => {
    const token = req.headers.authorization.split(' ')[1];
    if (!token) return res.status(401).send("Access denied");
    try {
        const validToken = jwt.verify(token, process.env.SECRET ?? 'de88caa0342d089047adc90825f2ee06f6a33d1f9c28c98505f59022cbfb52dd');
        if (validToken) {
            Conn().then(async () => {
                const products = await ProdOffer.find();
                const productsWithImages = products.map(product => ({
                  ...product.toObject(),
                  image: `${product.image}`
                }));
                res.send(productsWithImages);
                // res.send(products);
            }
          );
        }
    } catch (err) {
        if (err instanceof jwt.TokenExpiredError) {
            res.status(401).send("Token expired");
        } else {
            res.status(500).send("Internal Server Error");
        }
    }
});

}}
