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
            const {nombre, apellido, empresa, telefono, direccion} = req.body;
            const sql = `INSERT into clientes (nombre, apellido, empresa, telefono, direccion) VALUES (?, ?, ?, ?, ?)`;
            await connection.query(sql, [nombre, apellido, empresa, telefono, direccion]);
            return res.status(202).json({
                message: "Cliente created",
            }); 
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })

router.route("/:id")
    .get(async (req, res) => {
        try {
            const {id} = req.params;
            const data = await connection.query(
                `SELECT * FROM clientes WHERE id = ?`, [id]
            );
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
    .patch(async (req, res) => {
        try {
            const {id} = req.params;
            const {nombre, apellido, empresa, telefono, direccion} = req.body;
            await connection.query(
                `UPDATE clientes SET nombre = ?, apellido = ?, empresa = ?, telefono = ?, direccion= ? WHERE id = ?`, 
                [nombre, apellido, empresa, telefono, direccion, id]
            );
            res.status(200).json({
                message: "Cliente Actualizado"
            })
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })
    .delete(async (req, res) => {
        try {
            const {id} = req.params;
            await connection.query(
                `DELETE FROM clientes WHERE id = ?`, [id]
            );
            res.status(200).json({
                message: "Cliente Eliminado"
            })
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })

module.exports = router;
