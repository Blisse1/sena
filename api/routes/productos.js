const express = require("express");
const router = express.Router();
const connection = require("../db/connection")

router.route("/")
    .get(async (req, res) => {
        try {
            const [results, fields] = await connection.query(
                'SELECT * FROM `productos`'
            );
            res.status(200).json({
                productos: results,
            });
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })
    .post(async (req, res) => {
        try {
            const {nombre, categoriaId, precioUnitario, stock} = req.body;
            const sql = `INSERT into productos (nombre, categoria_id, precio_unitario, stock) VALUES (?, ?, ?, ?)`;
            await connection.query(sql, [nombre, categoriaId, precioUnitario, stock]);
            return res.status(202).json({
                message: "Producto created",
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
                `SELECT * FROM productos WHERE id = ?`, [id]
            );
            res.status(200).json({
                producto: data[0][0]
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
            const {nombre, categoriaId, precioUnitario, stock} = req.body;
            await connection.query(
                `UPDATE productos SET nombre = ?, categoria_id = ?, precio_unitario = ?, stock = ? WHERE id = ?`, 
                [nombre, categoriaId, precioUnitario, stock, id]
            );
            res.status(200).json({
                message: "Producto Actualizado"
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
                `DELETE FROM productos WHERE id = ?`, [id]
            );
            res.status(200).json({
                message: "Producto Eliminado"
            })
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })

module.exports = router;
