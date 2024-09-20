let precioUnitario = document.querySelector("#precioUnitario");
let productoNombre = document.querySelector("#productoNombre");
let clienteNombre = document.querySelector("#clienteNombre");

document.querySelector("#productoId").addEventListener("keyup", async(e) =>{
    const crearProducto = await fetch(`http://localhost:5000/productos/${e.key}`);
    let response = await crearProducto.json();
    precioUnitario.setAttribute("value", response.producto.precio_unitario);
    productoNombre.setAttribute("value", response.producto.nombre);
})

document.querySelector("#clienteId").addEventListener("keyup", async(e) =>{
    const crearCliente = await fetch(`http://localhost:5000/clientes/${e.key}`);
    let response = await crearCliente.json();
    clienteNombre.setAttribute("value", response.cliente.nombre);
})

document.querySelector("#cantidad").addEventListener("keyup", () => {
    let cantidad = document.querySelector("#cantidad").value;
    let total = document.querySelector("#total");
    let calculo = Number(cantidad) * Number(precioUnitario.value);
    console.log(precioUnitario.value, cantidad)
    total.setAttribute("value", calculo);
})

// Crear factura
document.querySelector("#crearFactura").addEventListener("submit", async (e) => {
    e.preventDefault();
    const clienteId = document.querySelector("#clienteId").value;
    const fecha = document.querySelector("#fecha").value;
    const productoId = Number(document.querySelector("#productoId").value);
    let cantidad = Number(document.querySelector("#cantidad").value);

    const crearFactura = await fetch("http://localhost:5000/facturas", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            clienteId,
            fecha,
        })
    });
    let facturaResponse = await crearFactura.json();

    let ultimaFacturaId = await fetch("http://localhost:5000/facturas");
    let ultimaFacturaJson = await ultimaFacturaId.json();
    let facturaId = ultimaFacturaJson.facturas.at(-1).id;

    const crearDetalle = await fetch("http://localhost:5000/detalle-facturas", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            facturaId,
            productoId,
            cantidad,
        })
    });
    let detalleResponse = await crearDetalle.json();
    console.log(facturaResponse, detalleResponse);
})


