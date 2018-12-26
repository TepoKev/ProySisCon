<%-- 
    Document   : registrar-catalogo
    Created on : 12-27-2017, 01:51:11 PM
    Author     : kedut
--%>
<%@page import="javafx.scene.input.KeyCode"%>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Cuenta"%>
<%@page import="controlador.Controlador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta charset="utf-8">
        <title>Registro de cátalogo de cuentas</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="fonts/font-awesome.css">
        <link rel="stylesheet" href="fonts/fonts.css">
        <link rel="stylesheet" href="css/custom-tree.css">
        <link rel="stylesheet" href="css/style.css">
        <script src="js/tether.min.js"></script>
        <script src="js/jquery-3.1.1.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/custom-tree.js"></script>
    </head>
    <body>
        <div class="bg-danger text-white" style="margin-bottom: 50px;">

            <div style="background-color: rgba(255,255,255,.2);">
                <div class="container">
                    <%@include file="nav.jsp" %>
                </div>
            </div>

            <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
                <h1 class="text-center font-weight-bold">Cuentas</h1>
            </div>

        </div>
        <div class="container">

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="h1 font-weight-bold text-muted">Registro de catálogo de cuentas</h1>
                    <div class="row">
                        <div class="col-md-7">
                            <div class="mt-3 alert alert-info">El código de cada cuenta será generado de la forma: #, ##, ####, ######, dependiendo del nivel de la cuenta</div>
                            <hr style="border-color: rgba(0,0,0,.2);">

                            <div id="arbol-cuentas">
                                <ul class="tree-root" data-genCodigo="false">

                                    <%
                                        Controlador ctr = new Controlador();
                                        ArrayList<Cuenta> cts = (ArrayList<Cuenta>) ctr.recuperarCuentaPrimerN();
                                        for (Cuenta cu : cts) {
                                            recursivo(cu, out);
                                        }
                                    %><%!
                                        public void recursivo(Cuenta t, JspWriter out) {
                                            try {
                                                if (t != null) {
                                                    out.print("<li>"
                                                            + "<a href=\"#\""
                                                            + " data-id=\"" + t.getId() + "\""
                                                            + " data-codigo=\""
                                                            + t.getCodigo() + "\" data-descripcion=\""
                                                            + t.getDescripcion() + "\" data-saldo=\""
                                                            + t.getTipo() + "\"><i class=\"fa fa-folder text-info mr-1\"></i>"
                                                            + t.getNombre() + "</a>");
                                                    if (t.getCuentasHijas().size() > 0) {
                                                        out.print("<ul data-opened=true>");
                                                        for (Object aux : t.getCuentasHijas()) {
                                                            recursivo((Cuenta) aux, out);
                                                        }
                                                        out.print("</ul>");
                                                    }
                                                    out.print("</li>");
                                                }
                                            } catch (Exception e) {
                                            }

                                        }
                                    %>

                                </ul>
                            </div>
                            <hr>
                            <form class="mt-3 text-sm-left" accept-charset="utf8" action="ServletCuenta" method="post" name="form-catalogo" id="form-catalogo">
                                <div class="text-right">
                                    <button class="btn btn-primary font-weight-bold" type="submit"><i class="fa fa-check"></i> Registrar catálogo</button>
                                </div>
                            </form>
                        </div>
                        <div id="sticky-scroll-box" class="col-md-5">
                            <div class="spacer"></div>
                            <div class="sticky-scroll-box bg-light  pt-0 pb-3 px-2">

                                <form action="#" name="form-cuenta" id="form-cuenta">
                                    <div>
                                        <h3 class="h3 text-center text-white bg-info py-2 font-weight-bold">Cuenta</h3>

                                        <div class="text-center">
                                            <div class="btn-group my-3" role='group' >
                                                <button type="button" class="btn px-2 py-2 btn-success btn-sm font-weight-bold" onclick="createNode()"><i class="fa fa-plus"></i> Crear <i class="fa fa-arrow-right"></i></button>
                                                <button type="button" class="btn px-2 py-2 btn-info btn-sm font-weight-bold" onclick="createSiblingNode()"><i class="fa fa-plus"></i> Crear <i class="fa fa-arrow-down"></i></button>
                                                <button type="button" class="btn px-2 py-2 btn-danger btn-sm font-weight-bold" onclick="deleteNode();"><i class="fa fa-trash"></i> Eliminar</button>
                                                <button type="button" class="btn px-2 py-2 btn-secondary btn-sm font-weight-bold" onclick="deselect();"><i class="fa fa-mouse-pointer"></i> Deseleccionar</button>
                                            </div>    
                                        </div>
                                        <input type="text" id="nombre-cuenta" name="nombre-cuenta" class="form-control mb-3" placeholder="Nombre de la cuenta">
                                        <input type="text" id="codigo-cuenta" name="codigo-cuenta" class="form-control mb-3" placeholder="Codigo de cuenta">
                                        <textarea id="descripcion-cuenta" name="descripcion-cuenta" class="form-control mb-3" placeholder="Descripcion de la cuenta"></textarea>
                                        <div id="tipo-saldo" class="form-group">
                                            <div>Saldo de la cuenta</div>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="saldo" id="saldo-deudor" value="+" checked> Deudor
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="saldo" id="saldo-acreedor" value="-"> Acreedor
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="saldo" id="saldo-de-cierre" value="0"> De cierre
                                                </label>
                                            </div>
                                        </div>

                                    </div>
                                    <hr class="divider">
                                    <div class="text-center">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-mouse-pointer"></i> Cerrar</button>
                                            <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Aceptar</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="bg-info" style="min-height: 170px;margin-top:7rem;">
            <div class="container">

            </div>
        </footer>
    </body>
</html>