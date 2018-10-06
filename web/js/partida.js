

var c = -1;
var partida = new Object();
partida.url = new Object();
partida.url.busqueda = 'ajax-busqueda-cuentas.jsp';
partida.url.nueva = 'nueva-partida.jsp';
partida.cuentaSeleccionada = null;
partida.actual = null;

$(document).ready(function () {
  var top = $('.sticky-scroll-box').offset().top;
  $(window).scroll(function (event) {
	var y = $(this).scrollTop();
	var elem = $('.sticky-scroll-box');
	var spacer = $('.spacer');

	if (y >= top) {
	  elem.addClass('fixed');
	  spacer.height(elem.height());
	} else {
	  elem.removeClass('fixed');
	  spacer.height(0);
	}
	elem.width(elem.parent().width());

  });
  inicializar();
  nueva_partida();
});
function inicializar() {
  $('#form-buscar-cuenta input[name=ajax-busqueda]').on('input focus', cambioInput);
  //$('#form-buscar-cuenta input[name=ajax-busqueda]').on('blur', quitar_cuenta);
  $('#form-buscar-cuenta input[name=ajax-busqueda]').on('keydown', cambiar_seleccion);
  $('#form-buscar-cuenta').submit(cambiar_cuenta);
  $('#resultado-busqueda').on('click', 'a', click_cuenta);

  $('#partidas').on('click', 'div[data-type="lista-dh"] a', cuenta_seleccionada);
  $('#partidas').on('click', 'a[data-type="btn-agregar"]', nuevo_cargo_abono);
  $('#partidas').on('click', 'a[data-type="btn-eliminar-partida"]', eliminar_partida);
  $('#partidas').on('click', 'a[data-type="btn-eliminar-ch"]', eliminar_cargo_abono);
  $('#partidas').on('keydown', 'input[name="cargo"], input[name="abono"]', input_keydown);
  $('#partidas').on('blur', 'input[name="cargo"], input[name="abono"]', input_blur);
  $('#form-partidas').on('submit', enviar_partidas);
}
function enviar_partidas(e) {
  var cant = 0;
  var partidas = $('#partidas div[data-type="partida"]');
  var result = false;
  for (var i = 0; i < partidas.length; i++) {
	//partida corrupta o no valida
	result = partida_modificada(partidas[i]);
	if (result === true) {
	  cant++;
	}
  }
  if (cant !== 0) {
	e.preventDefault();
	alert('Las partidas no cuadran o están incorrectas');
	return;
  }

  /*
   * Despues de validar cada elemento del formulario, 
   * el formulario sera convertido en arreglos que el servidor convertira en objetos
   * para poder ser insertados en la base de datos
   * 
   */

  //datos necesarios para cada partida
  var numeroPartidas = new Array();
  var descripciones = new Array();
  var fechas = new Array();

  //datos necesarios para cada cargoAbono
  var numPartidas = new Array();
  var codigosCuentas = new Array();
  var montos = new Array();
  var ops = new Array();
  var i, c;
  var partidas;
  //para el numero de partida
  var nump;

  //sel1 tiene varios usos
  //sel2 es para abonos
  //sel 3 es para los codigos de cuentas
  var sel1, sel2, sel3;
  var val1, val2, val3;
  partidas = $('#partidas div[data-type="partida"]');

  for (i = 0; i < partidas.length; i++) {
	//capturar los datos de la partida actual
	sel1 = $(partidas[i]).find('span[data-type="contador"]');
	nump = $(sel1[0]).text().trim();
	numeroPartidas.push(nump);
	sel1 = $(partidas[i]).find('input[name="fecha"]');
	fechas.push($(sel1[0]).val().trim());
	sel1 = $(partidas[i]).find('textarea[name="descripcion"]');
	descripciones.push($(sel1[0]).val().trim());
	//capturar la lista de cargos/abonos
	sel1 = $(partidas[i]).find('div[data-type="lista-dh"] input[name="cargo"]');
	sel2 = $(partidas[i]).find('div[data-type="lista-dh"] input[name="abono"]');
	sel3 = $(partidas[i]).find('div[data-type="lista-dh"] a[data-codigo]');
	if (sel1.length !== sel2.length || sel1.length !== sel3.length) {
	  alert('Error fatal. Parece que se han eliminado componentes del formulario');
	  e.preventDefault();
	  return;
	}
	for (c = 0; c < sel1.length; c++) {
	  val1 = $(sel1[c]).val();
	  val2 = $(sel2[c]).val();
	  if ((val1.length === 0 && val2.length === 0) || (val1.length > 0 && val2.length > 0))
	  {
		e.preventDefault();
		alert("Un error ha ocurrido. El formulario paso la primera validacion pero tiene datos erroneos. Saliendo");
		return;
	  }

	  if (val1.length > 0) {
		montos.push(val1);
		ops.push('c');
	  } else {
		montos.push(val2);
		ops.push('a');
	  }
	  numPartidas.push(nump);
	  val3 = $(sel3[c]).attr('data-codigo');
	  if (val3 === null || val3 === '') {
		alert('Alguna cuenta no ha sido asignada\nPor favor complete el formulario seleccionando la/las cuentas faltantes');
		e.preventDefault();
		return;

	  }
	  codigosCuentas.push(val3);
	}
  }
  //si hay error: prevenir envio del formulario y mostrar mensaje de error
  e.preventDefault();
  //sino
  var data = {
	'numerospartidas[]': numeroPartidas,
	'descripciones[]': descripciones,
	'fechas[]': fechas,
	'numpartidas[]': numPartidas,
	'codigoscuentas[]': codigosCuentas,
	'montos[]': montos,
	'ops[]': ops
  };
  console.log(data);
  $.post('ServletPartida', data, function (data) {
	$('#modal-contenido-partidas').empty();
	$('#modal-contenido-partidas').append(data);
	$('#modal-partidas').modal('show');
  });


}
function nueva_partida() {
  quitar_cuenta();
  $.post(partida.url.nueva, {'ajax-opcion': 'partida', 'num-partida': c}, cargar_ajax_partida);
}
function cargar_ajax_partida(data) {

  /*
   * 
   * Obtenido de Stack Overflow:
   * https://stackoverflow.com/questions/25702689/a-jquery-scrolltop-with-transition
   */
  $('#partidas').append(data);
  var div = $('#partidas div[data-type="partida"]:last');
  var pos = $(div).offset().top;
  c = parseInt($(div).attr('data-num-partida'));
  $('html, body').animate({scrollTop: pos - 100}, 500); // will take two seconds to scroll to the element
}
function nuevo_cargo_abono(e) {
  e.preventDefault();
  partida.actual = $(e.currentTarget).parent();
  $.post(partida.url.nueva, {'ajax-opcion': 'cargo-abono', 'num-partida': c}, cargar_ajax_cargo_abono);
}
function cargar_ajax_cargo_abono(data) {
  var contenedor;
  if (partida.actual !== null) {
	contenedor = $(partida.actual).find('div[data-type="lista-dh"]');
	$(contenedor).append(data);
  }
}

function eliminar_partida(e) {
  var btn = e.currentTarget;
  e.preventDefault();
  $(btn).parent().remove();
}
function validar_formulario_completo() {
  var valido = true;
  var sel = $('div[data-type="partida"]');
  for (var i = 0; i < sel.length; i++) {
	valido = valido && partida_modificada(sel[i]);
  }
  return valido;
}

function cuenta_seleccionada(e) {
  e.preventDefault();
  var actual = e.currentTarget;
  var codigo = $(actual).attr('data-codigo');
  var input = $('#form-buscar-cuenta input[name=ajax-busqueda]')[0];

  limpiar_busqueda_instantanea();
  if (partida.cuentaSeleccionada === null) {

  } else if (!(codigo === null || typeof codigo === 'undefined' || codigo === '')) {
	$(input).val(codigo);
  }
  partida.cuentaSeleccionada = actual;
  $(input).focus();
  $(input).selectRange();
  $(input).select();
}

function quitar_cuenta(e) {
  limpiar_busqueda_instantanea();
  partida.cuentaSeleccionada = null;
}
function estaVacio(val) {
  if (typeof val === 'undefined' || val === '')
	return true;
  else
	return false;
}
function partida_modificada(partida) {
  var tot_cargos = 0;
  var tot_abonos = 0;
  var i = 0;
  var cargos = $(partida).find('input[name="cargo"]');
  var abonos = $(partida).find('input[name="abono"]');
  var c = 0, a = 0;
  var contenedor;
  var partida_currupta = false;
  if (cargos.length === abonos.length) {
	for (i = 0; i < cargos.length; i++) {
	  contenedor = $(cargos[i]).parent().parent();
	  c = $(cargos[i]).val();
	  a = $(abonos[i]).val();
	  if ((a.length > 0 && c.length > 0) || (a.length === 0 && c.length === 0)) {
		$(cargos[i]).addClass('is-invalid');
		$(abonos[i]).addClass('is-invalid');
		partida_currupta = true;
	  } else {
		$(cargos[i]).removeClass('is-invalid');
		$(abonos[i]).removeClass('is-invalid');
	  }
	  if (estaVacio(c)) {
		c = 0;
	  }

	  if (estaVacio(a)) {
		a = 0;
	  }

	  c = parseFloat(c);
	  a = parseFloat(a);
	  if (isNaN(c) || isNaN(a)) {
		partida_currupta = true;
		break;
	  }
	  tot_abonos = tot_abonos + a;
	  tot_cargos = tot_cargos + c;
	}

	contenedor = $(partida).find('div[data-type="total-partida"]');
	if (partida_currupta === false) {
	  $(contenedor).find('div[data-type="total-cargo"]').text('$ ' + tot_cargos);
	  $(contenedor).find('div[data-type="total-abono"]').text('$ ' + tot_abonos);
	} else {
	  $(contenedor).find('div[data-type="total-cargo"]').text('Datos incorrectos');
	  $(contenedor).find('div[data-type="total-abono"]').text('Datos incorrectos');
	}

	if (tot_cargos !== tot_abonos || partida_currupta === true) {
	  $(contenedor).addClass('alert-danger');
	  $(contenedor).removeClass('alert-success');
	  partida_currupta = true;
	} else {
	  $(contenedor).removeClass('alert-danger');
	  $(contenedor).addClass('alert-success');
	}
	return partida_currupta;
  } else {
	alert("Fatal error: el formulario esta corrupto");
	return true;
  }
}

function eliminar_cargo_abono(e) {
  e.preventDefault();
  var actual = e.currentTarget;
  var partida = $(actual).parent().parent().parent().parent();
  var sel = $(partida).find('div[data-type="lista-dh"] div[data-type="dh"]');
  var i = 0;
  var el;
  for (i = 0; i < sel.length; i++) {
	el = $(sel[i]).find('input[type="checkbox"]');
	if ($(el).is(':checked')) {
	  $(sel[i]).remove();
	}
  }
  partida_modificada(partida);
}

function input_blur(e) {
  var input = e.currentTarget;
  var partida = $(input).parent().parent().parent().parent();
  partida_modificada(partida);
}
function click_cuenta(e) {
  $('#resultado-busqueda a').removeClass('cuenta-seleccionada');
  $(e.currentTarget).addClass('cuenta-seleccionada');
  cambiar_cuenta(e);
}
function cambiar_cuenta(e) {
  e.preventDefault();
  var resultados = $('#resultado-busqueda a');
  var sel = $(resultados).filter('.cuenta-seleccionada');
  if (resultados.length > 0 && partida.cuentaSeleccionada !== null) {

	if (sel.length > 0 && partida.cuentaSeleccionada !== null) {
	  $(partida.cuentaSeleccionada).attr('data-codigo', $(sel).attr('data-codigo'));
	  $(partida.cuentaSeleccionada).text($(sel).text());
	  partida.cuentaSeleccionada = null;
	  $('#form-buscar-cuenta input[name=ajax-busqueda]').val('');
	  limpiar_busqueda_instantanea();
	}
  } else if (resultados.length > 0) {
	var codigo = '';
	if (sel.length > 0) {
	  codigo = $(sel).attr('data-codigo');
	}
	$('#form-buscar-cuenta input[name=ajax-busqueda]').val(codigo);
	limpiar_busqueda_instantanea();
  }
}
function input_keydown(e) {
  var input = e.currentTarget;
  if (e.keyCode === 38) {

  } else if (e.keyCode === 40) {

  }
}
function cambiar_seleccion(e) {
  var index = indice_seleccion();
  var sel = $('#resultado-busqueda a');
  if (sel.length <= 0)
	return;

  switch (e.keyCode) {
	case 27://ESC
	  quitar_cuenta();
	  break;
	case 13:

	  break;
	case 38://flecha arriba
	  if (index < 0) {
		$(sel[0]).addClass('cuenta-seleccionada');
	  } else if ((index - 1) < 0) {
		$(sel[0]).removeClass('cuenta-seleccionada');
		$(sel[sel.length - 1]).addClass('cuenta-seleccionada');
	  } else {
		$(sel[index]).removeClass('cuenta-seleccionada');
		$(sel[index - 1]).addClass('cuenta-seleccionada');
	  }
	  break;
	case 40://flecha abajo
	  if (index < 0) {
		$(sel[0]).addClass('cuenta-seleccionada');
	  } else if ((index + 1) === sel.length) {
		$(sel[index]).removeClass('cuenta-seleccionada');
		$(sel[0]).addClass('cuenta-seleccionada');
	  } else {
		$(sel[index]).removeClass('cuenta-seleccionada');
		$(sel[index + 1]).addClass('cuenta-seleccionada');
	  }
	  break;
  }
}
function indice_seleccion() {
  var i = 0;
  var elems = $('#resultado-busqueda a');
  var className;
  for (i = 0; i < elems.length; i++) {
	if ($(elems[i]).hasClass('cuenta-seleccionada') === true) {
	  return i;
	}
  }
  return -1;
}

function busqueda_instantanea(ajax_busqueda) {
  if (ajax_busqueda) {
	if (ajax_busqueda.length > 0) {
	  $.post('ajax-busqueda-cuentas.jsp', {'ajax-busqueda': ajax_busqueda}, imprimir_resultados);
	} else {
	  limpiar_busqueda_instantanea();
	}
  } else {
	limpiar_busqueda_instantanea();
  }
}
function cambioInput() {
  var ajax_busqueda = $(this).val();
  busqueda_instantanea(ajax_busqueda);
}
function enviarFormusqueda(e) {
  e.preventDefault();
  var ajax_busqueda = $('#form-buscar-cuenta input[name=ajax-busqueda]').val();
  busqueda_instantanea(ajax_busqueda);
}
function limpiar_busqueda_instantanea() {
  $('#resultado-busqueda').empty();
}
function imprimir_resultados(data) {


  limpiar_busqueda_instantanea();
  var contenedor = $('#resultado-busqueda');
  var sel;
  $(contenedor).html(data);
  sel = $(contenedor).find('a');
  if (sel.length > 0) {
	$(sel[0]).addClass('cuenta-seleccionada');
  }
}
//SET CURSOR POSITION
$.fn.setCursorPosition = function (pos) {
  this.each(function (index, elem) {
	if (elem.setSelectionRange) {
	  elem.setSelectionRange(pos, pos);
	} else if (elem.createTextRange) {
	  var range = elem.createTextRange();
	  range.collapse(true);
	  range.moveEnd('character', pos);
	  range.moveStart('character', pos);
	  range.select();
	}
  });
  return this;
};

//SELECT TEXT RANGE
$.fn.selectRange = function (start, end) {
  return this.each(function () {
	if (this.setSelectionRange) {
	  this.focus();
	  this.setSelectionRange(start, end);
	} else if (this.createTextRange) {
	  var range = this.createTextRange();
	  range.collapse(true);
	  range.moveEnd('character', end);
	  range.moveStart('character', start);
	  range.select();
	}
  });
};
