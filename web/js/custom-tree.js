/*
 * Links:
 * Reemplazar nodos de texto:
 * https://stackoverflow.com/questions/11867269/replace-only-text-inside-a-div-using-jquery
 * 
 **/
var treeCatalog = {
  name: '.tree-root',
  newText: 'nueva cuenta',
  currentNode: null,
  maxLevel: 10
};
var stickyElement = {
  'idElement': '.sticky-scroll-box',
  'idSpace': '.spacer'
};

$(document).ready(function () {
  //convertir la lista anidada en un arbol
  initialize();
  //generar datos (codigo)
  var codGen = $(treeCatalog.name).attr('data-genCodigo');
  //generacion del codigo de cuenta automatico se activa si es igual a 'true' || ''
  if (codGen === '' || typeof codGen === 'undefined' || codGen === 'true') {
	//generar codigo automatico para cada cuenta
	genCodNodo($(treeCatalog.name));
  } else {
	//si las cuentas dentro del catalogo ya tienen codigo
	//simplemente hay que dividirlo
	//ya que actualmente no es permitido editar todos los digitos del codigo de una cuenta
	//solamente los ultimos 2 o los que no modifican el nivel de la cuenta
	dividirCodigo($(treeCatalog.name));
  }
  //observese que no se asignará el evento click de forma no tan usual
  //sino con delegacion de evento
  $(treeCatalog.name).on('click', 'li a', enfocar);

  //limpiar formulario
  limpiarFormulario();

  //asociar un formulario a cada elemento para editar sus atributos
  $('#form-cuenta').on('submit', guardarCuenta);

  $('#form-catalogo').submit(enviarFormulario);

  //funcion del doble click
  $(treeCatalog.name).on('dblclick', 'li a', manejadorDblclick);

  //este panel pegado debe estar activado debido a la cantidad de cuentas que se manejan,
  //estas cuentas normalmente no se logran ver dentro de la pagina. asi que el panel de edicion de cuenta, 
  //lo acompañara dentro de la pagina
  panelPegado();
});
function panelPegado() {
  //hacer pegajoso el formulario de cuenta
  var top = $(stickyElement.idElement).offset().top;

  $(window).scroll(function (event) {

	var y = $(this).scrollTop();
	var elem = $(stickyElement.idElement);
	var spacer = $(stickyElement.idSpace);

	if (y >= top) {
	  elem.addClass('fixed');
	  spacer.height(elem.height());
	} else {
	  elem.removeClass('fixed');
	  spacer.height(0);
	}
	elem.width(elem.parent().width());
  });
}
function limpiarFormulario() {
  $('#nombre-cuenta').val('');
  $('#codigo-cuenta').val('');
  $('#descripcion-cuenta').val('');
  $('#form-cuenta input:radio').prop('checked', false);
  //...
}

function seleccionarElemento(actual) {

  var obj = {
	nombre: $(actual).text(),
	codigo: $(actual).attr("data-codigo"),
	descripcion: $(actual).attr("data-descripcion"),
	saldo: $(actual).attr('data-saldo')
  };
  //cuando no hay ningun elemento seleccionado, seleccionar el actual
  if (treeCatalog.currentNode === null) {
	$(actual).addClass("focus-gained");
	$(actual).focus();
	treeCatalog.currentNode = actual;
  } else {
	//cuando hay un elemento seleccionado:
	//primeramente deseleccionar el actual
	//despues seleccionar el nodo actual
	$(treeCatalog.currentNode).removeClass('focus-gained');
	$(actual).addClass('focus-gained');
	$(actual).focus();
	treeCatalog.currentNode = actual;
  }
  llenarFormulario(obj);
}
function llenarFormulario(obj) {
  limpiarFormulario();
  $('#nombre-cuenta').val(obj.nombre);
  $('#codigo-cuenta').val(obj.codigo);
  /*
   * saldo '+' representa cuentas de saldo deudor
   * saldo '-' representa cuentas de saldo acreedor
   */
  if (obj.saldo === '+') {
	$('#saldo-deudor').prop('checked', true);
  } else if (obj.saldo === '-') {
	$('#saldo-acreedor').prop('checked', true);
  }
  $('#codigo-cuenta').val(obj.codigo);
  $('#descripcion-cuenta').val(obj.descripcion);
  $('#nombre-cuenta').focus();
}
function manejadorDblclick(e) {
  collExp(e.currentTarget, 125);
}
/*
 * esta funcion expande o contrae un elemento <ul>
 * para expandir el <ul> hermano de alink_elem, en milisegundos, la logica es> esta cerrado el elemento?, ok, abralo, sino cierrelo
 * 
 */
function collExp(alink_elem, milisegundos) {

  var next_element = $(alink_elem).next('ul');
  var open = $(next_element).attr('data-opened');

  if (open === null || open === 'false') {
	$(next_element).attr('data-opened', true);
	$(next_element).show(milisegundos);
  } else {
	$(next_element).attr('data-opened', false);
	$(next_element).hide(milisegundos);
  }
}

function enfocar(e) {
  var actual = e.currentTarget;
  e.preventDefault();
  seleccionarElemento(actual);
}
function dividirCodigo(nodo, nivel = 0) {
  if (nodo === null) {
	return;
  }
  var listaNodos = $(nodo).children('li');
  var elem, cod;
  var span;
  for (var i = 0; i < listaNodos.length; i++) {

	elem = $(listaNodos[i]).children('a');

	cod = $(elem).attr('data-codigo');
	span = document.createElement('span');
	span.innerHTML = cod;
	$(span).insertBefore(elem);
	if (nivel === 0 || nivel === 1) {
	  $(elem).attr('data-codigo', cod.substr(nivel, 1));
	} else {
	  //la cantidad de digitos del codigo de cuenta debe ser un numero par
	  if (cod.length % 2 === 0) {
		$(elem).attr('data-codigo', cod.substr(cod.length - 2));
	  } else {
		console.log('ERROR FATAL: Los codigos de cuenta son incorrectos');
		return;
	  }
	}
	dividirCodigo($(listaNodos[i]).find('> ul'), nivel + 1);
}
}

/*
 * Esta funcion genera un codigo de acuerdo al catalogo de cuentas para un nodo y sus nodos hijos
 * Si el nivel es omitido se empiezan a generar los codigos a partir de nodo raiz
 * @returns {void}
 * nodo debe ser un elemento ul
 */
function genCodNodo(nodo, nivel = 0, sobreEscribirCodigo = true) {
  //fin de la recursividad
  if (nodo === null) {
	return;
  }
  var listaNodos = $(nodo).children('li');
  var elem;
  var cod;
  //recorrer los elementos <li>
  for (var i = 0; i < listaNodos.length; i++) {
	elem = $(listaNodos[i]).children('a');
	if (sobreEscribirCodigo === true) {
	  //para los primeros 2 niveles, el codigo generado solo contiene 1 digito
	  if (nivel >= 0 && nivel < 2) {
		cod = convert(i + 1, 1);
	  } else if (nivel >= 2) {
		//el nivel 2 y en adelante tienen un codigo de dos digitos 
		cod = convert(i + 1, 2);
	  } else {
		console.log('Un error fatal ha ocurrido, el nivel del arbol debe ser positivo o nulo, pero nivel=' + nivel);
	  }
	  $(elem).attr('data-codigo', cod);
	}
	//generar codigo recursivamente para cada <ul> hijo del <li>
	genCodNodo($(listaNodos[i]).find('> ul'), nivel + 1);
}
}
function convert(numero, digitos = 2) {
  if (digitos < 2) {
	return numero.toString();
  } else {
	var result = "";
	var base = 10;
	for (var i = 1; i < digitos; i++) {
	  if (numero < Math.pow(base, i)) {
		result = result + "0";
	  }
	}
	return result + numero;
}
}

/*
 Esta funcion convierte un elemento lista 'ul' en un elemento que sera usado como arbol desde este script
 <ul class="tree-root">
 <li>cuenta1</li>
 <li>cuenta2
	<ul>
	<li>subcuenta1</li>
	<li>subcuenta2</li>
	</ul>
 </li>
 </ul>
 Si se llama a la funcion ya habiendo sido creados los <a>, la funcion no hara su trabajo
 ya que solo convierte el "texto" dentro del <li>, ademas los espacios y lineas vacias son eliminadas por la funcion
 <ul class="tree-root">
 <li><a>cuenta1</a></li>
 <li><a>cuenta2</a>
	<ul>
	<li><a>subcuenta1</a></li>
	<li><a>subcuenta2</a></li>
	</ul>
 </li>
 </ul>
 */
function initialize() {
  //seleccionar todos los elemtnso hijos 'li' dentro del 'ul' principal
  var elementos = $(treeCatalog.name + ' li');
  var text = "";
  //filtrar los nodos que tienen texto, que sera el nombre de cuenta
  $(elementos).contents().filter(function () {
	return this.nodeType === 3;//cuando el nodo es un elemento de texto
  }).each(function () {
	var texto = this.textContent;
	//eliminar espacios en blanco
	this.textContent = texto.trim();
	if (this.textContent === '' || this.textContent === null) {
	  return;//para nodos vacios no hacer nada
	}
	//nodo_nuevo sera un elemento <a> (enlace)
	var nodo_nuevo = newElementA(this.textContent);
	$(this).replaceWith(nodo_nuevo);
  });

  //abrir o cerrar los nodos segun el atributo data-opened
  elementos = $(treeCatalog.name + ' li a').each(function () {
	/*
	 * hacer expandible los elementos de una lista con subcuentas
	 * <ul data-opened="true"></ul>
	 * no permitr la expansion de la lista de subcuentas
	 * <ul data-opened="false"></ul>
	 */
	var next = $(this).next('ul');
	var data_abierto = $(next).attr('data-opened');
	//si el data-opened del ul esta en true, es porque desea abrirse o expandirse
	//primero lo ponemos en false, 
	//ahora cuando colExp lea el atributo del elemento, se dara cuenta que esta cerado, 
	//por tanto lo abrira
	if (data_abierto === 'true') {
	  $(next).attr('data-opened', false);
	  collExp(this, 0);
	} else if (data_abierto === 'false') {
	  $(next).attr('data-opened', true);
	  collExp(this, 0);
	}
  });
}

function guardarCuenta(e) {
  e.preventDefault();
  var span;
  var obj = {
	nombre: $('#nombre-cuenta').val(),
	codigo: $('#codigo-cuenta').val(),
	descripcion: $('#descripcion-cuenta').val(),
	saldo: $('#form-cuenta input[name=saldo]:checked').val()
  };

  //validacion de la cuenta
  if(obj.nombre==='' || obj.codigo==='' || obj.saldo==='') {
	alert('Por favor complete los campos:\nel nombre, codigo y saldo, son obligatorios');
	return;
  }
  var elements = $(treeCatalog.currentNode).parent().parent().find('> li > a');
  var codigo, nombre, i;
  var msjs = new Array(), texto = '', valida = true;
  for (i = 0; i < elements.length; i++) {
	// verificar si no hay duplicados de nombre, ni codigo de cuenta
	// pero omitir el nodo actual, pues la comparacion resultara cierta
	
	if ( treeCatalog.currentNode !== elements[i] )  {
	  if (obj.codigo === $(elements[i]).attr('data-codigo')) {
		msjs.push('El codigo "' + obj.codigo + '" ya existe');
		valida = false;
	  }
	  if (obj.nombre === $(elements[i]).text()) {
		msjs.push('La cuenta con nombre "' + obj.nombre + '" ya existe');
		valida = false;
	  }
	}
  }
  if (!valida) {
	for (i = 0; i < msjs.length; i++) {
	  texto = texto + msjs[i] + '\n';
	}
	alert('Error: \n' + texto);
	return;
  }

  // actualizar el nuevo nodo
  $(treeCatalog.currentNode).attr({
	'data-codigo': obj.codigo,
	'data-descripcion': obj.descripcion,
	'data-saldo': obj.saldo
  });
  if($(treeCatalog.currentNode).attr('data-new')==='true') {
	$(treeCatalog.currentNode).html('<i class="fa fa-folder mr-1 text-success"></i>' + obj.nombre);
  } else {
	$(treeCatalog.currentNode).html('<i class="fa fa-folder mr-1 text-warning"></i>' + obj.nombre);
  }
  span = $(treeCatalog.currentNode).parent().find('span')[0];
  $(span).html(fullCode(treeCatalog.currentNode));
}
function fullCode(element) {
  var code = $(element).attr('data-codigo');
  var i,reco;
  reco = element;
  for (i = 0;i < treeCatalog.maxLevel; i++) {
	reco = $(reco).parent().parent()[0];
	if(reco===$(treeCatalog.name)[0]) {
	  return code;
	} else {
	  reco = $(reco).prev('a');
	  code = $(reco).attr('data-codigo') + code;
	}
  }
  return code;
}
function newElementA(text = null, saldoHeredado = true) {

  //crear un elemento a (enlace)
  var nuevo = document.createElement('a');
  //establecer sus atributos, el icono y el texto del enlace
  $(nuevo).attr({
	href: '#',
	'data-codigo': '',
	'data-descripcion': '',
	'data-saldo': '',
	'data-id': ''
  });

  if (text === null) {
	text = treeCatalog.newText;
  }
  $(nuevo).html('<i class="fa fa-folder text-success mr-1"></i>' + text);
  //el atributo data-new ha sido agregado para poder diferenciar las cuentas nuevas de las modificadas
  $(nuevo).attr('data-new','true');
  return nuevo;
}
function newNode() {
  //crear un elemento li y agregarle un enlace (dentro)
  var nuevoLi = document.createElement('li');
  return $(nuevoLi).append(newElementA());
}
/*
 * El abrol de cuentas, ya inicializado tiene una estructura similar a: 
 <ul class="tree-root">
 <li.><a>cuenta1</a></li>
 <li><a>cuenta2</a>
	<ul>
	<li><a>subcuenta1</a></li>
	<li><a>subcuenta2</a></li>
	</ul>
 </li>
 </ul>
 */
function createNode() {

  //cuando se crea un nuevo elemento esta funcion debe ser llamada
  var nuevo;
  var span;
  //no hay nodo seleccionado, y por tanto, se crea un nodo principal, sin padre
  if (treeCatalog.currentNode === null) {
	//crear un nuevo nodo de lista
	nuevo = newNode();
	//insertar el nuevo elemento RAIZ al final
	$(treeCatalog.name).append(nuevo);

	//obtener un nuevo codigo generado
	var lista = $(treeCatalog.name + ' > li > a');
	var mayor = mayorElementoPor('data-codigo', lista) + 1;

	//seleccionar el elemento recien creado
	var a = $(nuevo).find('a')[0];
	span = document.createElement('span');
	span.innerHTML = mayor;
	$(span).insertBefore($(a));
	$(a).attr('data-codigo', mayor);
	seleccionarElemento($(nuevo).find('a')[0]);

  } else {

	//se obtenemos el elemento padre que se supone es un li
	var dataSaldo = $(treeCatalog.currentNode).attr('data-saldo');
	//pst debe ser un li
	var par = $(treeCatalog.currentNode).parent();
	//buscamos el primer ul
	var sel = $(par).children('ul:first');
	nuevo = null;

	//para el caso que el elemento actual tiene al menos un hijo
	if (sel.length > 0) {

	  //agregar al ul padre un item con un enlace
	  $(sel).append(newNode());

	  //nuevo es el nodo recien creado
	  nuevo = $(sel).find('li:last a')[0];

	  //Ahora debemos obtener un codigo generado
	  //primero obtenemos los elementos <a> inmediatamento hijos de los <li> inmediatamente hijos de <ul>
	  var lista = $(sel).find('> li > a');

	  var mayor = mayorElementoPor('data-codigo', lista) + 1;
//		 console.log('mayor: ' + mayor);
	  var nivel = obtenerNivel(nuevo);
//		 console.log('nivel: ' + nivel);
	  mayor = genCodNivel(mayor, nivel);
//		 console.log('codigo: ' + mayor);
	  $(nuevo).attr('data-codigo', mayor);
	  $(nuevo).attr('data-saldo', dataSaldo);
	  span = document.createElement('span');
	  span.innerHTML = mayor;
	  $(span).insertBefore(nuevo);
	  seleccionarElemento(nuevo);
	} else {

	  //para el caso que el elemento <li> no tenga <ul> hijo asi como lo siguiente: 
	  /*
	   <li><a>cuenta1</a></li>
	   */
	  //entonces crear la estructura necesaria: 
	  /*
	   <li><a>cuenta1</a>
	   <ul></ul>
	   </li>
	   */
	  nuevo = document.createElement('ul');
	  $(nuevo).append(newNode());
	  $(par).append(nuevo);

	  //nuevo es el nodo recien creado
	  nuevo = $(par).find('ul li:last a')[0];

	  //obtener un nuevo codigo generado
	  var lista = $(sel).find('a');
	  var mayor = 1;
//		 console.log('mayor: ' + mayor);
	  var nivel = obtenerNivel(nuevo);
//		 console.log('nivel: ' + nivel);
	  mayor = genCodNivel(mayor, nivel);
//		 console.log('codigo: ' + mayor);
	  span = document.createElement('span');
	  span.innerHTML = mayor;
	  $(span).insertBefore(nuevo);
	  $(nuevo).attr('data-codigo', mayor);
	  $(nuevo).attr('data-saldo', dataSaldo);
	  seleccionarElemento(nuevo);
	}
	$(sel).show(125);
  }

  $('#nombre-cuenta').focus();
  $('#nombre-cuenta').selectRange(0, $('#nombre-cuenta').val().length);
}

function deleteNode() {

  $(treeCatalog.name + ' .focus-gained').removeClass('focus-gained');
  $(treeCatalog.currentNode).parent().remove();
  treeCatalog.currentNode = null;
  limpiarFormulario();
}
function deselect() {
  $(treeCatalog.name + ' .focus-gained').removeClass('focus-gained');
  treeCatalog.currentNode = null;
  limpiarFormulario();
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

function genCodNivel(numero, nivel) {
  if (nivel < 0) {
	return '';
  } else {
	switch (nivel) {
	  case 0:
	  case 1:
		return convert(numero, 1);
	  default:
		return convert(numero, 2);
	}
  }
}
function obtenerNivel(elem) {
  var nivel = 0;
  var tmp = elem;
  //  console.log(elem);
  while (tmp && !$(tmp).is(treeCatalog.name + ' > li')) {
//	  console.log(tmp);
	tmp = $(tmp).parent();
	if (!$(tmp).is('li')) {
	  nivel++;
	}
  }

  return nivel;
}
function mayorElementoPor(prop, lista) {
  if (prop === null || prop === '' || !lista) {
	return null;
  } else {
	var dataCodigo = $(lista[0]).attr(prop);
	if (dataCodigo === '' || typeof dataCodigo === 'undefined') {
	  return 0;
	}
	var may = Number.parseInt($(lista[0]).attr(prop));
	var next;
	var i;
	for (var i = 1; i < lista.length; i++) {
	  next = Number.parseInt($(lista[i]).attr(prop));
	  if (next > may) {
		may = next;
	  }
	}
	return may;
  }
}
function ordenarPorCodigo(elemA, elemB) {
  if ($(elemA).attr('data-codigo') > $(elemB).attr('data-codigo')) {
	return 1;
  }
  if ($(elemA).attr('data-codigo') < $(elemB).attr('data-codigo')) {
	return -1;
  }
  // a must be equal to b
  return 0;
}

function enviarFormulario(e) {
  //primeramente se obtienen las cuentas del formulario
  var lista = new Array();
  var arbol = $(treeCatalog.name);
  var i = 0;
  arbolALista("", arbol, lista);
  console.log(lista);
  for (i = 0; i < lista.length; i++) {
	$('#form-catalogo').append(
			'<input type="hidden" name="nombre-cuenta" value="' + lista[i].nombre + '">'
			+ '<input type="hidden" name="id-cuenta" value="' + lista[i].id + '">'
			+ '<input type="hidden" name="codigo-cuenta" value="' + lista[i].codigo + '">'
			+ '<input type="hidden" name="descripcion-cuenta" value="' + lista[i].descripcion + '">'
			+ '<input type="hidden" name="saldo" value="' + lista[i].saldo + '">'
			);
  }

}

function arbolALista(codigo, arbol, lista) {
  var a_elems = $(arbol).find('> li > a');
  var i = 0;
  var obj = new Object();
  for (i = 0; i < a_elems.length; i++) {
	obj = new Object();
	obj.nombre = $(a_elems[i]).text().trim();
	obj.codigo = codigo + $(a_elems[i]).attr('data-codigo');
	obj.descripcion = $(a_elems[i]).attr('data-descripcion');
	obj.saldo = $(a_elems[i]).attr('data-saldo');
	obj.id = $(a_elems[i]).attr('data-id');
	lista.push(obj);
	arbolALista(obj.codigo, $(a_elems[i]).parent().find(' > ul'), lista);
  }
}
