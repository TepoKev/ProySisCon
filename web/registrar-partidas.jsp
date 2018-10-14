<%-- 
    Document   : registrar-partidas
    Created on : 08-14-2018, 10:21:41 AM
    Author     : student
--%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Registro de Partidas</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="fonts/font-awesome.css">
        <link rel="stylesheet" href="fonts/fonts.css">
        <link rel="stylesheet" href="css/style.css">
        <script src="js/jquery-3.1.1.js"></script>
        <script src="js/tether.min.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/partida.js"></script>
        <script>

        </script>
    </head>
    <body style="margin-bottom: 200px">


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
                <h1 class="text-sm-center font-weight-bold">Partidas</h1>
            </div>

        </div>
        <div class="container">

            <div class="row">

                <%@include file="aside.jsp" %>
                <div class="col-lg-9">

                    <h1 class="bg-danger p-3 h1 font-weight-bold text-white">Registrar Partidas</h1>
                    <hr style="border-color: rgba(0,0,0,.2);">
                    <div class="spacer"></div>
                    <div id="sticky-scroll-box" class="sticky-scroll-box bg-light">

                        <div class="row">
                            <div class="col-md-8">
                                <form action="ajax-busqueda-cuentas.jsp" id="form-buscar-cuenta">
                                    <div class="input-group">
                                        <input type="text" class="form-control" autocomplete="off" name="ajax-busqueda" placeholder="Código o nombre de cuenta">
                                        <span class="input-group-btn">
                                            <button class="btn btn-primary" type="submit">Aceptar <i class="fa fa-arrow-right"></i></button>
                                        </span>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn px-2 py-2 text-white btn-secondary btn-sm font-weight-bold" onclick="nueva_partida();"><i class="fa fa-plus"></i> Partida</button>
                                        </span>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="row">
                            <div  class="col-md-8" id="resultado-busqueda" style="position: absolute;z-index: 999;">

                            </div>
                        </div>		 
                    </div>



                    <div class="row">
                        <div class="col-md-12">
                            <form class="mt-3 text-sm-left"  action="ServletPartida" method="post" name="form-partidas" id="form-partidas">
                                <div class="spacer-col-headers"></div>
                                <div class="form-group row sticky-col-headers">
                                    <label class="col-sm-3 col-form-label">Cuenta</label>
                                    <label class="col-sm-3 col-form-label">Fecha</label>
                                    <label class="col-sm-3 col-form-label">Debe</label>
                                    <label class="col-sm-3 col-form-label">Haber</label>
                                </div>

                                <div id="partidas" class="mb-3">

                                </div>
                                <div>
                                    <button class="btn btn-primary font-weight-bold" type="submit">Registrar Partidas <i class="fa fa-arrow-right"></i></button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>




            </div>

        </div>
        <div class="modal fade bd-example-modal-lg" id="modal-partidas" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="modal-contenido-partidas">
                    <div class="modal-header"></div>
                    <div class="modal-body"></div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>
        <footer style="min-height: 170px">
            <div class="container">

            </div>
        </footer>
    </body>
</html>
