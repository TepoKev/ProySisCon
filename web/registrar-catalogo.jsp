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
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta charset="UTF-8">
        <title>Registro de cátalogo de cuentas</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/jstree.css">
        <link rel="stylesheet" href="fonts/font-awesome.css">
        <link rel="stylesheet" href="fonts/fonts.css">
        <link rel="stylesheet" href="css/custom-tree.css">
        <script src="js/tether.min.js"></script>
        <script src="js/jquery-3.1.1.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/custom-tree.js"></script>
    </head>
    <body>
        <div class="bg-success text-warning" style="margin-bottom: 50px;
             background-image: url(images/background-1.jpg);background-size: cover;">

            <div style="background-color: rgba(255,255,255,.8);">
                <div class="container">
                    <nav class="navbar navbar-toggleable-md navbar-light">
                        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <a class="navbar-brand" href="#">Proy-SisCon</a>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav mr-auto">
                                <li class="nav-item active">
                                    <a class="nav-link" href="#">Inicio <span class="sr-only">(current)</span></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Caracteristicas</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Acerca de</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link disabled" href="#">Ayuda</a>
                                </li>
                            </ul>
                            <span class="navbar-text">Sistema Contable</span>
                        </div>
                    </nav>
                </div>
            </div>

            <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
                <h1 class="text-sm-center text-muted font-weight-bold">Cuentas</h1>
            </div>

        </div>
        <div class="container">

            <div class="row">

                <div class="col-lg-3">

                    <div class="list-group">
                        <a class="list-group-item list-group-item-action active" href="#">Registrar Catalogo</a>
                        <a class="list-group-item list-group-item-action" href="registrar-partidas.html">Registrar Partidas</a>
                        <a class="list-group-item list-group-item-action" href="mostrar-librodiario.jsp">Libro Diario</a>
                        <a class="list-group-item list-group-item-action" href="#">Libro Mayor</a>
                        <a class="list-group-item list-group-item-action" href="#">Balanza de Comprobación</a>
                        <a class="list-group-item list-group-item-action" href="#">Estado de Resultados</a>
                        <a class="list-group-item list-group-item-action" href="#">Balance General</a>
                        <a class="list-group-item list-group-item-action" href="#">Cierre Contable</a>
                    </div>
                </div>
                <div class="col-lg-9">

                    <h1 class="h1 font-weight-bold text-muted">Registro de catálogo de cuentas</h1>
                    <hr style="border-color: rgba(0,0,0,.2);">
                    <div class="row">
                        <div class="mt-3 col-md-6 mb-3">
                            <div class="btn-group">
                                <button type="button" class="btn px-2 py-2 btn-success btn-sm font-weight-bold" onclick="createNode()"><i class="fa fa-plus"></i> Crear</button>
                                <button type="button" class="btn px-2 py-2 btn-danger btn-sm font-weight-bold" onclick="deleteNode();"><i class="fa fa-remove"></i> Eliminar</button>
                                <button type="button" class="btn px-2 py-2 btn-secondary btn-sm font-weight-bold" onclick="deselect();"><i class="fa fa-mouse-pointer"></i>Deseleccionar</button>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-6">
                            <div id="arbol-cuentas">
                                <ul class="tree-root" data-genCodigo="false">
                                    <%
                                        Controlador ctr = new Controlador();
                                        ArrayList<Cuenta> cts = (ArrayList<Cuenta>) ctr.recuperarCuentaPrimerN();
                                        for (Cuenta cu : cts) {
                                            recursivo(cu, out);
                                        }
                                    %>
                                    <%!
                                        public void recursivo(Cuenta t, JspWriter out) {
                                            try {
                                                if (t != null) {
                                                    out.print("<li><a href=\"#\""
                                                            + " data-id=\"" + t.getId() + "\""
                                                            + " data-codigo=\""
                                                            + t.getCodigo() + "\" data-descripcion=\""
                                                            + t.getDescripcion() + "\" data-saldo=\""
                                                            + t.getTipo() + "\"><i class=\"fa fa-folder text-info mr-1\"></i>"
                                                            + t.getNombre() + "</a>");
                                                    if (t.getCuentas().size() > 0) {
                                                        out.print("<ul data-opened=true>");
                                                        for (Object aux : t.getCuentas()) {
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
                            <p class="mt-2">
                                El código de cada cuenta será generado de la forma: #, ##, ####, ######, dependiendo del nivel de la cuenta
                            </p>
                            <form class="mt-3 text-sm-left"  action="ServletCuenta" method="post" name="form-catalogo" id="form-catalogo">
                                <button class="btn btn-primary font-weight-bold" type="submit">Registrar catálogo <i class="fa fa-arrow-right"></i></button>
                            </form>
                        </div>
                        <div class="col-md-6 py-3">

                            <form action="#" name="form-cuenta" id="form-cuenta">
                                <div>
                                    <h3 class="h3 text-sm-center">Cuenta</h3>
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
                                    </div>
                                </div>
                                <hr class="divider">
                                <div>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-close"></i> Cerrar</button>
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Aceptar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer style="min-height: 170px">
            <div class="container">

            </div>
        </footer>
    </body>
</html>