<%-- 
    Document   : nav
    Created on : 12-21-2018, 06:33:40 PM
    Author     : Student
--%>
<%@page import="modelo.validarPeriodo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="#">Proy-SisCon</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link font-weight-bold" href="index.jsp"><i class="fa fa-home"></i> Inicio <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
	   <a class="nav-link font-weight-bold" href="<% if(!validarPeriodo.val()){%>configuracion.jsp?opc=n<%}else{%>configuracion.jsp<%}%>"><i class="fa fa-cog"></i> Configuración</a>
            </li>
            <li class="nav-item">
                <a class="nav-link font-weight-bold" href="#"><i class="fa fa-info-circle"></i> Acerca de</a>
            </li>
            <li class="nav-item">
                <a class="nav-link font-weight-bold" href="#"><i class="fa fa-question-circle"></i> Ayuda</a>
            </li>
        </ul>
        <span class="navbar-text font-weight-bold text-white">Sistema Contable</span>
    </div>
</nav>
<script>
    $(document).ready(function () {
        $("a").each(function () {
            

            if (window.location.pathname.endsWith($(this).attr("href"))) {
                $(this).addClass("active");
            }
            var children = $(this).find('i');
            console.log(children);
            if ($(children).hasClass('text-danger') && $(this).hasClass('active')) {
                $(children).removeClass('text-danger');
                $(children).addClass('text-white');
            }
        });
    });
</script>