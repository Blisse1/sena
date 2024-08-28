const express = require("express");
const app = express();
const port = 3000;

app.engine('.html', require('ejs').__express);
app.use(express.static("public"));
app.set("view engine", "html");
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/clientes", (req, res) => {
    res.render("clientes");
})

app.get("/categorias", (req, res) => {
    res.render("categorias");
})

app.get("/productos", (req, res) => {
    res.render("productos");
})

app.listen(port, () => {
    console.log(`Conexion exitosa en el puerto ${port}`);
})
