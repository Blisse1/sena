const express = require("express");
const mysql = require("mysql2/promise");
const app = express();
const port = 3000;

app.use(express.static("public"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const connection = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "123",
    database: "sena",
});

app.route("/clientes")
    .get(async (req, res) => {
        try {
            const [results, fields] = await connection.query(
                'SELECT * FROM `clientes`'
            );
            res.status(200).json({
                clientes: results,
            });
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })
    .post(async (req, res) => {
        try {
            const {nombre, apellido} = req.body;
            console.log(nombre, apellido);
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })

app.route("/cliente/:id")
    .get(async (req, res) => {
        try {
            const {id} = req.params;
            const data = await connection.query(
                `SELECT * FROM clientes WHERE id = ?`, [id]
            );
            console.log(data.length)
            res.status(200).json({
                cliente: data[0][0]
            })
            res.send(results);
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })

app.get("/", (req, res) => {
   res.send("hello world"); 
})

app.listen(port, () => {
    console.log(`Conexion exitosa en el puerto ${port}`);
})
