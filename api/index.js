const express = require("express");
const dotenv = require("dotenv");
const winston = require("winston");
const morgan = require("morgan");
const clientes = require("./routes/clientes");
const cors = require("cors");
dotenv.config();
const app = express();
const port = process.env.PORT || 5000;

const corsOptions = {
    origin: "http://localhost:3000",
};

app.use(cors(corsOptions));
app.use(express.json());

const errorFilter = winston.format((info, opts) => {
    return info.level === 'error' ? info : false;
});

const infoFilter = winston.format((info, opts) => {
    return info.level === 'info' ? info : false;
});

const {printf, combine, timestamp, json, errors} = winston.format;
const logger = winston.createLogger({
    level: "http",
    format: combine(
        timestamp({
            format: "YYYY-MM-DD hh:mm:ss A",
        }),
        printf((info) => `[${info.timestamp}] ${info.level}: ${info.message}`),
        json(),
        errors({stack: true}),
    ),
    transports: [
        new winston.transports.File({
            filename: "combined.log",
        }),
        new winston.transports.File({
            filename: "app-error.log",
            level: "error",
            format: combine(errorFilter(), timestamp(), json())
        }),
        new winston.transports.File({
            filename: "app-info.log",
            level: "info",
            format: combine(infoFilter(), timestamp(), json())
        }),
    ],
    exceptionHandlers: [
        new winston.transports.File({ filename: "exceptions.log"}),
    ],
    rejectionHandlers: [
        new winston.transports.File({ filename: "rejections.log"}),
    ],
})

const morganMiddleware = morgan(
    ":method :url :status :res[content-length] - :response-time ms",
    {
        stream: {
            write: (message) => logger.http(message.trim()),
        }
    }
);

app.use(morganMiddleware);

app.use("/clientes", clientes);
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

app.listen(port, () => {
    console.log(`Conexion exitosa en el puerto ${port}`);
})
