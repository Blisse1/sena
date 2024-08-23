const express = require("express");
const app = express();
const port = 3000;

app.use(express.static("public"));
app.use(express.json());

app.get("/", (req, res) => {
   res.send("hello world"); 
})

app.get("/clientes", (req, res) => {
   res.send("hello world");
})

app.listen(port, () => {
    console.log(`Conexion exitosa en el puerto ${port}`);
})
