const express = require("express");
const router = express.Router();
const connection = require("../db/connection")

router.route("/")
    .get(async (req, res) => {
        try {
            const [results, fields] = await connection.query(
                'SELECT * FROM `detalle_facturas`'
            );
            res.status(200).json({
                detalleFactura: results,
            });
        } catch (err) {
            res.status(500).json({
                message: err,
            });
        }
    })
    .post(async (req, res) => {
        try {
            const {facturaId, productoId, cantidad} = req.body;
            const sql = `INSERT into detalle_facturas (factura_id, producto_id, cantidad) VALUES (?, ?, ?)`;
            await connection.query(sql, [facturaId, productoId, cantidad]);
            return res.status(202).json({
                message: "Detalle-factura created",
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
                `SELECT * FROM detalle_facturas WHERE id = ?`, [id]
            );
            res.status(200).json({
                detalleFactura: data[0][0]
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
//                 `UPDATE detalle-factura SET nombre = ?, apellido = ?, empresa = ?, telefono = ?, direccion= ? WHERE id = ?`, 
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
//                 `DELETE FROM detalle-factura WHERE id = ?`, [id]
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
