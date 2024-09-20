const express = require("express");
const router = express.Router();
const connection = require("../db/connection")

router.route("/")
    .get(async (req, res) => {
        try {
            const [results, fields] = await connection.query(
                'SELECT * FROM `facturas`'
            );
            res.status(200).json({
                facturas: results,
            });
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })
    .post(async (req, res) => {
        try {
            const {clienteId, fecha} = req.body;
            const sql = `INSERT into facturas (cliente_id, fecha) VALUES (?, ?)`;
            await connection.query(sql, [clienteId, fecha]);
            return res.status(202).json({
                message: "Factura created",
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
                `SELECT * FROM facturas WHERE id = ?`, [id]
            );
            res.status(200).json({
                factura: data[0][0]
            })
            res.send(results);
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })
//     .patch(async (req, res) => {
//         try {
//             const {id} = req.params;
//             const {nombre, apellido, empresa, telefono, direccion} = req.body;
//             await connection.query(
//                 `UPDATE facturas SET nombre = ?, apellido = ?, empresa = ?, telefono = ?, direccion= ? WHERE id = ?`, 
//                 [nombre, apellido, empresa, telefono, direccion, id]
//             );
//             res.status(200).json({
//                 message: "Cliente Actualizado"
//             })
//         } catch (err) {
//             res.status(500).json({
//                 message: err,
//             });
//         }
//     })
//     .delete(async (req, res) => {
//         try {
//             const {id} = req.params;
//             await connection.query(
//                 `DELETE FROM facturas WHERE id = ?`, [id]
//             );
//             res.status(200).json({
//                 message: "Cliente Eliminado"
//             })
//         } catch (err) {
//             res.status(500).json({
//                 message: err,
//             });
//         }
//     })

module.exports = router;
