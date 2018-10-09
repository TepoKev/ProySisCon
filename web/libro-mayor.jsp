<%-- 
    Document   : libro-mayor
    Created on : 09-09-2018, 05:27:25 PM
    Author     : tepokev
--%>
<%@page import="controlador.Controlador" %>
<%@page import="modelo.Mayor" %>
<%@page import="java.util.ArrayList" %>
<%@page import="modelo.CargoAbono" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Libro Mayor</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/jstree.css">
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
                    <nav class="navbar navbar-expand-lg navbar-dark">
                        <a class="navbar-brand" href="#">Proy-SisCon</a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mr-auto">
                                <li class="nav-item active">
                                    <a class="nav-link" href="index.jsp">Inicio <span class="sr-only">(current)</span></a>
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
                            <span class="navbar-text text-white">Sistema Contable</span>
                        </div>
                    </nav>
                </div>
            </div>
            <div class="container" style="padding-top: 60px;padding-bottom: 60px;">
                <h1 class="text-sm-center font-weight-bold">Libro  Mayor</h1>
            </div>
        </div>

        <main class="container">
            <%
                Controlador ctr = new Controlador();
                ArrayList<Mayor> lista = ctr.mayorizarCuentas(4);
                ArrayList<CargoAbono> trans;
                for (Mayor item : lista) {
                    if (item.getTransacciones().size() > 0) {
                        item.generarSaldos();
            %>
            <div class="row">
                <div class="col-lg-12 py-3">
                    <div class="container">
                        <h3 class="text-sm-center"><%=item.getCuenta().getNombre()%></h3>
                    </div>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Concepto</th>
                                <th>Debe</th>
                                <th>Haber</th>
                                <th>Saldo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (CargoAbono ca : item.getTransacciones()) {
                            %>
                            <tr>
                                <th><%=ca.getCuenta().getCodigo()%></th>
                                <td><%=ca.getPartida().getDescripcion()%></td>
                                <td><%=("c".equalsIgnoreCase(ca.getOperacion())) ? ca.getMonto() : 0%></td>
                                <td><%=("a".equalsIgnoreCase(ca.getOperacion())) ? ca.getMonto() : 0%></td>
                                <td><%=ca.getMonto()%></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td></td>
                                <th scope="row">Totales</th>
                                <td><%=item.getCargo()%></td>
                                <td><%=item.getAbono()%></td>
                                <td><%= (item.getSaldoD() != 0) ? item.getSaldoD() : item.getSaldoA()%></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
            <%
                    }
                }
            %>
        </main>
        <footer class="badge-info text-white mt-3" style="min-height: 170px">
            <div class="container">
            </div>
        </footer>
    </body>
</html>
