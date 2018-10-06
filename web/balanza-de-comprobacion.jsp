<%-- 
    Document   : balanza-de-comprobacion
    Created on : 09-10-2018, 08:48:36 AM
    Author     : tepokev
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="controlador.Controlador"%>
<%@page import="modelo.Mayor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Balanza de Comprobacion</title>
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
                <h1 class="text-sm-center font-weight-bold">Balanza de Comprobacion</h1>
            </div>

        </div>

        <div class="container">
            <div class="row">
                <%@include file="aside.jsp" %>
                <div class="col-lg-9">
                    <table class="table">
                        <%
                            Controlador ctr = new Controlador();
                            ArrayList<Mayor> m = ctr.mayorizarCuentas(4);
                            float tCargo = 0,tAbono = 0, tSD = 0, tSA = 0;
                        %>
                        <thead>
                            <tr>
                                <th>Codigo</th><th>Nombre</th><th>Cargo</th><th>Abono</th><th>SD</th><th>SA</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for(Mayor may : m){
                                    may.generarSaldos();
                                    tCargo += may.getCargo();
                                    tAbono += may.getAbono();
                                    tSD += may.getSaldoD();
                                    tSA += may.getSaldoA();
                            %>
                            <tr>
                                <td> <%= may.getCuenta().getCodigo()%> </td><td> <%= may.getCuenta().getNombre()%> </td><td> <%= may.getCargo()%> </td><td> <%= may.getAbono()%> </td><td> <%= may.getSaldoD()%> </td><td> <%= may.getSaldoA()%> </td>
                            </tr>    
                            <%
                                }
                            %>
                            <tr>
                                <th></th><th>Total</th><th><%= tCargo%></th><th><%= tAbono%></th><th><%= tSD%></th><th><%=  tSA%></th>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <footer style="min-height: 170px" class="text-white bg-info">
            <div class="container">

            </div>
        </footer>
    </body>
</html>