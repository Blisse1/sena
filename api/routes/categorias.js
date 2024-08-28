const express = require("express");
const router = express.Router();
const connection = require("../db/connection")

router.route("/")
    .get(async (req, res) => {
        try {
            const [results, fields] = await connection.query(
                'SELECT * FROM `categorias`'
            );
            res.status(200).json({
                categorias: results,
            });
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })
    .post(async (req, res) => {
        try {
            const { nombre } = req.body;
            const sql = `INSERT into categorias ( nombre ) VALUES (?)`;
            await connection.query(sql, [ nombre ]);
            return res.status(202).json({
                message: "Categoria created",
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
                `SELECT * FROM categorias WHERE id = ?`, [id]
            );
            res.status(200).json({
                categeoria: data[0][0]
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
            const { id } = req.params;
            const { nombre } = req.body;
            await connection.query(
                `UPDATE categorias SET nombre = ? WHERE id = ?`, 
                [nombre, id]
            );
            res.status(200).json({
                message: "Categeoria Actualizada"
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
                `DELETE FROM categorias WHERE id = ?`, 
                [id]
            );
            res.status(200).json({
                message: "Categoria Eliminada"
            })
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })

module.exports = router;
