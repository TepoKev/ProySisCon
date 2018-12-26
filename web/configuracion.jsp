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
                    <form class="mb-5">
                        <%
                            String[] params = request.getParameterValues("params{}");
                            String[] values = request.getParameterValues("values");
                            String FECHA_INICIAL = request.getParameter("FECHA_INICIAL"),
                                    FECHA_FINAL = request.getParameter("FECHA_FINAL"),
                                    INVENTARIO_FINAL = request.getParameter("INVENTARIO_FINAL"),
                                    PORC_RESERVA = request.getParameter("PORC_RESERVA"),
                                    PORC_IMPUESTO_S_LA_RENTA = request.getParameter("PORC_IMPUESTO_S_LA_RENTA"),
                                    EXTREMO_DE_APLICACION = request.getParameter("EXTREMO_DE_APLICACION"),
                                    VENTAS = request.getParameter("VENTAS"),
                                    REB_Y_DEV_S_VENTAS = request.getParameter("REB_Y_DEV_S_VENTAS"),
                                    COMPRAS = request.getParameter("COMPRAS"),
                                    GASTOS_S_COMPRAS = request.getParameter("GASTOS_S_COMPRAS"),
                                    REB_Y_DEV_S_COMPRAS = request.getParameter("REB_Y_DEV_S_COMPRAS"),
                                    INVENTARIO = request.getParameter("INVENTARIO"),
                                    GASTOS_DE_ADMON = request.getParameter("GASTOS_DE_ADMON"),
                                    GASTOS_DE_VENTA = request.getParameter("GASTOS_DE_VENTA"),
                                    GASTOS_FINANCIEROS = request.getParameter("GASTOS_FINANCIEROS"),
                                    OTROS_GASTOS = request.getParameter("OTROS_GASTOS"),
                                    OTROS_INGRESOS = request.getParameter("OTROS_INGRESOS"),
                                    RESERVA_LEGAL = request.getParameter("RESERVA_LEGAL"),
                                    IMPUESTO_S_LA_RENTA = request.getParameter("IMPUESTO_S_LA_RENTA"),
                                    UTILIDAD_DEL_EJERCICIO = request.getParameter("UTILIDAD_DEL_EJERCICIO");
                        %>
                        <div class="text-right">
                            <a class="my-3 text-sm-center  btn btn-outline-info" href="configuracion.jsp?default=true">Configuración por defectoo <i class="fa fa-cog"></i></a>
                        </div>
                            <%
                                String paramDefault = request.getParameter("default");
                                boolean predeterminada = "true".equalsIgnoreCase(paramDefault) ? true : false;
                            %>
                        <h2>Periodo de operación</h2>
                        <div class="alert alert-info">
                            Si desea ver el estado de resultados debe ingresar el valor del inventario final, 
                            los periodos de operaicón deben ingresarse para el correcto funcionamiento
                        </div>
                        <div class="form-group row mt-3">
                            <label for="FECHA_INICIAL" class="col-sm-3 col-form-label">Fecha inicial</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {
                                %>
                                <input value="2018-01-01" type="date" class="form-control" name="FECHA_INICIAL" id="FECHA_INICIAL" placeholder="Fecha inicial">
                                <%
                                } else {%>
                                <input type="date" class="form-control" name="FECHA_INICIAL" id="FECHA_INICIAL" placeholder="Fecha inicial">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">FECHA_INICIAL</div>
                        </div>

                        <div class="form-group row">
                            <label for="FECHA_FINAL" class="col-sm-3 col-form-label">Fecha final</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {
                                %>
                                <input value="2018-12-31" type="date" class="form-control" name="FECHA_FINAL" id="FECHA_FINAL" placeholder="Fecha final">
                                <%
                                } else {%>
                                <input type="date" class="form-control" name="FECHA_FINAL" id="FECHA_FINAL" placeholder="Fecha final">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">FECHA_FINAL</div>
                        </div>
                        <div class="form-group row">
                            <label for="INVENTARIO_FINAL" class="col-sm-3 col-form-label">Inventario final</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {
                                %>
                                <input value=""  type="number" step="any" class="form-control" name="INVENTARIO_FINAL" id="INVENTARIO_FINAL" placeholder="Inventario final">
                                <%
                                } else {%>
                                <input type="number" step="any" class="form-control" name="INVENTARIO_FINAL" id="INVENTARIO_FINAL" placeholder="Inventario final">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">INVENTARIO_FINAL</div>
                        </div>
                        <hr>
                        <h2>Porcentaje de reservas e impuestos</h2>
                        <div class="alert alert-info">
                            El formato para estos campos debe ser: <strong>#</strong> , <strong>#(#,#)</strong> , <strong>#(#,#)#(#,#)</strong>
                            <br>
                            Por ejemplo: <strong>7</strong> para indicar que se aplica el 7%, o <strong>25(0,150000)30(150000,9000000000)</strong> para que se aplique el 25% de 0 a 150000  y 30% de 150000 en adelante
                        </div>

                        <div class="form-group row mt-3">
                            <label for="PORC_RESERVA" class="col-sm-3 col-form-label">Reserva Legal</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {
                                %>
                                <input value="7" type="text" class="form-control" name="PORC_RESERVA" id="PORC_RESERVA" placeholder="Reserva">                                
                                <%
                                } else { %> 
                                <input type="text" class="form-control" name="PORC_RESERVA" id="PORC_RESERVA" placeholder="Reserva">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">PORC_RESERVA</div>
                        </div>

                        <div class="form-group row">
                            <label for="PORC_IMPUESTO_S_LA_RENTA" class="col-sm-3 col-form-label">Impuesto sobre la Renta</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {
                                %>
                                <input value="25(0,150000)30(150000,9000000000)" type="text" class="form-control" name="PORC_IMPUESTO_S_LA_RENTA" id="PORC_IMPUESTO_S_LA_RENTA" placeholder="Impuesto sobre la Renta">
                                <%
                                } else { %>
                                <input type="text" class="form-control" name="PORC_IMPUESTO_S_LA_RENTA" id="PORC_IMPUESTO_S_LA_RENTA" placeholder="Impuesto sobre la Renta">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">PORC_IMPUESTO_S_LA_RENTA</div>
                        </div>
                        <div class="form-group row">
                            <label for="PORC_IMPUESTO_S_LA_RENTA" class="col-sm-3 col-form-label">Extremo de inclusion para aplicar el porcentaje: </label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {
                                %>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" checked="" name="EXTREMO_DE_APLICACION" id="inlineRadio1" value="I">
                                    <label class="form-check-label" for="inlineRadio1">>= y <</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="EXTREMO_DE_APLICACION" id="inlineRadio2" value="S">
                                    <label class="form-check-label" for="inlineRadio2">> y <=</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="EXTREMO_DE_APLICACION" id="inlineRadio3" value="A">
                                    <label class="form-check-label" for="inlineRadio3">>= y <=</label>
                                </div>                                
                                <%
                                } else { %>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="EXTREMO_DE_APLICACION" id="inlineRadio1" value="I">
                                    <label class="form-check-label" for="inlineRadio1">>= y <</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="EXTREMO_DE_APLICACION" id="inlineRadio2" value="S">
                                    <label class="form-check-label" for="inlineRadio2">> y <=</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="EXTREMO_DE_APLICACION" id="inlineRadio3" value="A">
                                    <label class="form-check-label" for="inlineRadio3">>= y <=</label>
                                </div>                                     
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">EXTREMO_DE_APLICACION</div>
                        </div>
                        <hr>
                        <h2>Cuentas de estado de resultados</h2>
                        <div class="alert alert-info">
                            Ingrese los códigos de cuenta que se usarán en el estado de resultados
                        </div>
                        <div class="alert alert-info">
                            Si su catálogo tiene separadas las cuentas rebajas y devoluciones sobre compras/ventas, separe los codigos con una <strong>,</strong>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="VENTAS" class="col-sm-3 col-form-label">Ventas</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {
                                %>
                                <input value="5101" type="text" class="form-control" name="VENTAS" id="VENTAS" placeholder="Ventas">
                                <%
                                } else { %>
                                <input type="text" class="form-control" name="VENTAS" id="VENTAS" placeholder="Ventas">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">VENTAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="REB_Y_DEV_S_VENTAS" class="col-sm-3 col-form-label">Rebajas y devoluciones sobre ventas</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {
                                %>
                                <input value="4101" type="text" class="form-control" name="REB_Y_DEV_S_VENTAS" id="REB_Y_DEV_S_VENTAS" placeholder="Rebajas y devoluciones sobre ventas">
                                <% } else {  %>
                                <input type="text" class="form-control" name="REB_Y_DEV_S_VENTAS" id="REB_Y_DEV_S_VENTAS" placeholder="Rebajas y devoluciones sobre ventas">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">REB_Y_DEV_S_VENTAS</div>
                        </div>

                        <div class="form-group row">
                            <label for="COMPRAS" class="col-sm-3 col-form-label">Compras</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="4102" type="text" class="form-control" name="COMPRAS" id="COMPRAS" placeholder="Compras">
                                <%} else {%>
                                <input type="text" class="form-control" name="COMPRAS" id="COMPRAS" placeholder="Compras">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">COMPRAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="GASTOS_S_COMPRAS" class="col-sm-3 col-form-label">Gastos sobre compras</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%> 
                                <input value="4203" type="text" class="form-control" name="GASTOS_S_COMPRAS" id="GASTOS_S_COMPRAS" placeholder="Gastos sobre compras">
                                <%} else {%>
                                <input type="text" class="form-control" name="GASTOS_S_COMPRAS" id="GASTOS_S_COMPRAS" placeholder="Gastos sobre compras">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">GASTOS_S_COMPRAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="REB_Y_DEV_S_COMPRAS" class="col-sm-3 col-form-label">Rebajas y devoluciones sobre compras</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="5105" type="text" class="form-control" name="REB_Y_DEV_S_COMPRAS" id="REB_Y_DEV_S_COMPRAS" placeholder="Rebajas y devoluciones sobre compras">
                                <%} else {%>
                                <input type="text" class="form-control" name="REB_Y_DEV_S_COMPRAS" id="REB_Y_DEV_S_COMPRAS" placeholder="Rebajas y devoluciones sobre compras">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">REB_Y_DEV_S_COMPRAS</div>
                        </div>
                        <div class="form-group row">
                            <label for="INVENTARIO" class="col-sm-3 col-form-label">Inventario</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="1109" type="text" class="form-control" name="INVENTARIO" id="INVENTARIO" placeholder="Inventario">
                                <%} else {
                                %>
                                <input type="text" class="form-control" name="INVENTARIO" id="INVENTARIO" placeholder="Inventario">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">INVENTARIO</div>
                        </div>
                        <div class="form-group row">
                            <label for="GASTOS_DE_ADMON" class="col-sm-3 col-form-label">Gastos de administración</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="4201" type="text" class="form-control" name="GASTOS_DE_ADMON" id="GASTOS_DE_ADMON" placeholder="Gastos de administración">
                                <%} else {%>
                                <input type="text" class="form-control" name="GASTOS_DE_ADMON" id="GASTOS_DE_ADMON" placeholder="Gastos de administración">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">GASTOS_DE_ADMON</div>
                        </div>
                        <div class="form-group row">
                            <label for="GASTOS_DE_VENTA" class="col-sm-3 col-form-label">Gastos de venta</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="4202" type="text" class="form-control" name="GASTOS_DE_VENTA" id="GASTOS_DE_VENTA" placeholder="Gastos de venta">
                                <%} else {%>
                                <input type="text" class="form-control" name="GASTOS_DE_VENTA" id="GASTOS_DE_VENTA" placeholder="Gastos de venta">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">GASTOS_DE_VENTA</div>
                        </div>
                        <div class="form-group row">
                            <label for="GASTOS_FINANCIEROS" class="col-sm-3 col-form-label">Gastos financieros</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="4204" type="text" class="form-control" name="GASTOS_FINANCIEROS" id="GASTOS_FINANCIEROS" placeholder="Gastos financieros">
                                <%} else {%>
                                <input type="text" class="form-control" name="GASTOS_FINANCIEROS" id="GASTOS_FINANCIEROS" placeholder="Gastos financieros">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">GASTOS_FINANCIEROS</div>
                        </div>
                        <div class="form-group row">
                            <label for="OTROS_GASTOS" class="col-sm-3 col-form-label">Otros gastos</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="4205" type="text" class="form-control" name="OTROS_GASTOS" id="OTROS_GASTOS" placeholder="Otros gastos">
                                <%} else {%>
                                <input type="text" class="form-control" name="OTROS_GASTOS" id="OTROS_GASTOS" placeholder="Otros gastos">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">OTROS_GASTOS</div>
                        </div>
                        <div class="form-group row">
                            <label for="OTROS_INGRESOS" class="col-sm-3 col-form-label">Otros ingresos</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="5106" type="text" class="form-control" name="OTROS_INGRESOS" id="OTROS_INGRESOS" placeholder="Otros ingresos">
                                <%} else {%>
                                <input type="text" class="form-control" name="OTROS_INGRESOS" id="OTROS_INGRESOS" placeholder="Otros ingresos">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">OTROS_INGRESOS</div>
                        </div>
                        <div class="form-group row">
                            <label for="RESERVA_LEGAL" class="col-sm-3 col-form-label">Reserva legal</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="" type="text" class="form-control" name="RESERVA_LEGAL" id="RESERVA_LEGAL" placeholder="Reserva legal">
                                <%} else {%>
                                <input type="text" class="form-control" name="RESERVA_LEGAL" id="RESERVA_LEGAL" placeholder="Reserva legal">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">RESERVA_LEGAL</div>
                        </div>
                        <div class="form-group row">
                            <label for="IMPUESTO_S_LA_RENTA" class="col-sm-3 col-form-label">Impuesto sobre la renta</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="" type="text" class="form-control" name="IMPUESTO_S_LA_RENTA" id="IMPUESTO_S_LA_RENTA" placeholder="Impuesto sobre la renta">
                                <%} else {%>
                                <input type="text" class="form-control" name="IMPUESTO_S_LA_RENTA" id="IMPUESTO_S_LA_RENTA" placeholder="Impuesto sobre la renta">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">IMPUESTO_S_LA_RENTA</div>
                        </div>
                        <div class="form-group row">
                            <label for="UTILIDAD_DEL_EJERCICIO" class="col-sm-3 col-form-label">Utilidad del ejercicio</label>
                            <div class="col-sm-4">
                                <%if (predeterminada) {%>
                                <input value="" type="text" class="form-control" name="UTILIDAD_DEL_EJERCICIO" id="UTILIDAD_DEL_EJERCICIO" placeholder="Utilidad del ejercicio">
                                <%} else {%>
                                <input type="text" class="form-control" name="UTILIDAD_DEL_EJERCICIO" id="UTILIDAD_DEL_EJERCICIO" placeholder="Utilidad del ejercicio">
                                <%}%>
                            </div>
                            <div class="col-md-3 font-weight-bold">UTILIDAD_DEL_EJERCICIO</div>
                        </div>
                        <div class="text-center mt-4">
                            <button type="reset" class="btn btn-warning"><i class="fa fa-undo"></i> Limpiar campos</button>
                            <button type="submit" class="btn text-center btn-success"><i class="fa fa-check"></i> Aplicar configuración</button>
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