<%-- 
    Document   : configuracion.jsp
    Created on : 12-21-2018, 05:26:37 PM
    Author     : Student
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="controlador.Controlador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Configuración</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="fonts/font-awesome.css">
        <link rel="stylesheet" href="fonts/fonts.css">
        <link rel="stylesheet" href="css/custom-tree.css">
        <script src="js/tether.min.js"></script>
        <script src="js/jquery-3.1.1.js"></script>
        <script src="js/bootstrap.js"></script>
    </head>
    <body>
        <div class="bg-danger text-white" style="margin-bottom: 50px;">

            <div style="background-color: rgba(255,255,255,.2);">
                <div class="container">
                    <%@include file="nav.jsp" %>
                </div>
            </div>

            <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
                <h1 class="text-sm-center font-weight-bold">Configuración</h1>
            </div>

        </div>
        <div class="container">
            <div class="row">
                <%@include file="aside.jsp" %>
                <div class="col-lg-9">
                    <form>
                        <h2>Periodo de operación</h2>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Fecha inicial</label>
                            <div class="col-sm-4">
                                <input type="date" class="form-control" name="FECHA_INICIAL" id="FECHA_INICIAL" placeholder="Fecha inicial">
                            </div>
                            <div class="col-md-3 font-weight-bold">FECHA_INICIAL</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Fecha final</label>
                            <div class="col-sm-4">
                                <input type="date" class="form-control" name="FECHA_FINAL" id="FECHA_FINAL" placeholder="Fecha final">
                            </div>
                            <div class="col-md-3 font-weight-bold">FECHA_FINAL</div>
                        </div>
                        <hr>
                        <h2>Cuentas de estado de resultados</h2>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Ventas</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="ventas" id="ventas" placeholder="Ventas">
                            </div>
                            <div class="col-md-3 font-weight-bold">VENTAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Rebajas y devoluciones sobre ventas</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="REB_Y_DEV_S_VENTAS" id="REB_Y_DEV_S_VENTAS" placeholder="Rebajas y devoluciones sobre ventas">
                            </div>
                            <div class="col-md-3 font-weight-bold">REB_Y_DEV_S_VENTAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Ventas netas</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="VENTAS_NETAS" id="VENTAS_NETAS" placeholder="Ventas netas">
                            </div>
                            <div class="col-md-3 font-weight-bold">VENTAS_NETAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Compras</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="COMPRAS" id="COMPRAS" placeholder="Compras">
                            </div>
                            <div class="col-md-3 font-weight-bold">COMPRAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Gastos sobre compras</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="GASTOS_S_COMPRAS" id="GASTOS_S_COMPRAS" placeholder="Gastos sobre compras">
                            </div>
                            <div class="col-md-3 font-weight-bold">GASTOS_S_COMPRAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Rebajas y devoluciones sobre compras</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="REB_Y_DEV_S_COMPRAS" id="REB_Y_DEV_S_COMPRAS" placeholder="Rebajas y devoluciones sobre compras">
                            </div>
                            <div class="col-md-3 font-weight-bold">REB_Y_DEV_S_COMPRAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Inventario</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="INVENTARIO" id="INVENTARIO" placeholder="Inventario">
                            </div>
                            <div class="col-md-3 font-weight-bold">INVENTARIO</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Gastos de administración</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="GASTOS_DE_ADMON" id="GASTOS_DE_ADMON" placeholder="Gastos de administración">
                            </div>
                            <div class="col-md-3 font-weight-bold">GASTOS_DE_ADMON</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Gastos de venta</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="GASTOS_DE_VENTA" id="GASTOS_DE_VENTA" placeholder="Gastos de venta">
                            </div>
                            <div class="col-md-3 font-weight-bold">GASTOS_DE_VENTA</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Gastos financieros</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="GASTOS_FINANCIEROS" id="GASTOS_FINANCIEROS" placeholder="Gastos financieros">
                            </div>
                            <div class="col-md-3 font-weight-bold">GASTOS_FINANCIEROS</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Otros gastos</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="OTROS_GASTOS" id="OTROS_GASTOS" placeholder="Otros gastos">
                            </div>
                            <div class="col-md-3 font-weight-bold">OTROS_GASTOS</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Otros ingresos</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="OTROS_INGRESOS" id="OTROS_INGRESOS" placeholder="Otros ingresos">
                            </div>
                            <div class="col-md-3 font-weight-bold">OTROS_INGRESOS</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Reserva legal</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="RESERVA_LEGAL" id="RESERVA_LEGAL" placeholder="Reserva legal">
                            </div>
                            <div class="col-md-3 font-weight-bold">RESERVA_LEGAL</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Impuesto sobre la renta</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="IMPUESTO_S_LA_RENTA" id="IMPUESTO_S_LA_RENTA" placeholder="Impuesto sobre la renta">
                            </div>
                            <div class="col-md-3 font-weight-bold">IMPUESTO_S_LA_RENTA</div>
                        </div>
                        <div class="form-group row">
                            <label for="ventas" class="col-sm-3 col-form-label">Utilidad del ejercicio</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="UTILIDAD_DEL_EJERCICIO" id="UTILIDAD_DEL_EJERCICIO" placeholder="Utilidad del ejercicio">
                            </div>
                            <div class="col-md-3 font-weight-bold">UTILIDAD_DEL_EJERCICIO</div>
                        </div>
                        
                    </form>
                </div>
            </div>
        </div>

        <footer class="badge-danger text-white mt-3" style="min-height: 170px">
            <div class="container">
            </div>
        </footer>
    </body>
</html>