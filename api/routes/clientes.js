const express = require("express");
const router = express.Router();
const connection = require("../db/connection")

router.route("/")
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
            const sql = `INSERT into clientes (nombre, apellido) VALUES (?, ?)`;
            await connection.query(sql, [nombre, apellido]);
            return res.status(202).json({
                message: "Cliente created",
            }); 
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })

module.exports = router;
