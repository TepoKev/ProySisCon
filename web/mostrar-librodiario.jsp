<%-- 
    Document   : mostrar-librodiario
    Created on : 08-03-2018, 03:14:13 PM
    Author     : tepokev
--%>

<%@page import="modelo.CargoAbono"%>
<%@page import="modelo.Partida"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controlador.Controlador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta charset="UTF-8">
        <title>Libro Diario</title>
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
                <h1 class="text-sm-center text-muted font-weight-bold">Libro Diario</h1>
            </div>

        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">

                    <div class="list-group">
                        <a class="list-group-item list-group-item-action active" href="#">Libro Diario</a>
                        <a class="list-group-item list-group-item-action " href="registrar-catalogo.jsp">Registrar Catalogo</a>
                        <a class="list-group-item list-group-item-action" href="registrar-partidas.html">Registrar Partidas</a>
                        <a class="list-group-item list-group-item-action" href="#">Libro Mayor</a>
                        <a class="list-group-item list-group-item-action" href="#">Balanza de Comprobación</a>
                        <a class="list-group-item list-group-item-action" href="#">Estado de Resultados</a>
                        <a class="list-group-item list-group-item-action" href="#">Balance General</a>
                        <a class="list-group-item list-group-item-action" href="#">Cierre Contable</a>
                    </div>
                </div>
                <div class="col-lg-9">
                    <%
                        Controlador ctr = new Controlador();
                        ArrayList<Partida> partida = (ArrayList<Partida>) ctr.recuperarPartidas();
                        ArrayList<CargoAbono> cargoabono = new ArrayList<CargoAbono>();
                        float tCargo = 0, tAbono = 0;
                        for (Partida p : partida) {
                    %>
                    <div class="row">
                        <div class="col-sm-4">
                            <p>Fecha: <%= p.getFecha().toString()%></p>
                        </div>
                        <div class="col-sm-4">
                            <p>Partida N&deg; <%= p.getContador()%></p>
                        </div>
                    </div>  

                    <div class="col-lg-9">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Codigo</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Cargo</th>
                                    <th scope="col">Abono</th></tr>
                            </thead>
                            <tbody>
                                <%  
                                    for (CargoAbono c : ctr.ordenarCA(p.getCargosAbonos())) {

                                %>
                                <tr>
                                    <th scope="row"><%= c.getCuenta().getCodigo()%></th>
                                    <td><%= c.getCuenta().getNombre()%></td>
                                        <%if (c.getOperacion().equals("c")) {
                                                tCargo += c.getMonto();
                                        %>
                                    <td><%= c.getMonto()%></td>
                                    <td>0.0</td>
                                    <%} else {
                                        tAbono += c.getMonto();
                                    %>
                                    <td>0.0</td>
                                    <td><%= c.getMonto()%></td><%}%>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-lg-9">
                        <p class="text-muted"><%= p.getDescripcion()%></p>
                    </div>
                    <%
                        }
                    %>
                    <div class="row">
                        <div class="col-sm-3">

                        </div>
                        <%
                            if (tCargo == tAbono) {
                        %>
                        <div class="col-sm-3">
                            <p style="color:green">Total Cargo <%= tCargo%></p>
                        </div>
                        <div class="col-sm-6">
                            <p style="color:green">Total Abono <%= tAbono%></p>
                        </div>
                        <%
                        } else {
                        %>
                        <div class="col-sm-3">
                            <p style="color:red">Total Cargo <%= tCargo%></p>
                        </div>
                        <div class="col-sm-6">
                            <p style="color:red">Total Abono <%= tAbono%></p>
                        </div>
                        <%
                            }
                        %>

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