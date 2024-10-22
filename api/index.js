const express = require("express");
const dotenv = require("dotenv");
const morgan = require("morgan");
const cors = require("cors");
const app = express();
const port = process.env.PORT || 5000;

dotenv.config();

const corsOptions = {
    origin: "http://localhost:3000",
};

app.use(cors(corsOptions))

// routes
const clientes = require("./routes/clientes");
const categorias = require("./routes/categorias");
const productos = require("./routes/productos");
const facturas = require("./routes/facturas");
const detalleFacturas = require("./routes/detalle-facturas");

const morganMiddleware = morgan(
    ":method :url :status :res[content-length] - :response-time ms",
);

// Middleware
app.use(morganMiddleware);
app.use("/clientes", clientes);
app.use("/categorias", categorias);
app.use("/productos", productos);
app.use("/facturas", facturas);
app.use("/detalle-facturas", detalleFacturas);
app.use(express.json());

app.listen(port, () => {
    console.log(`Conexion exitosa en el puerto ${port}`);
})
