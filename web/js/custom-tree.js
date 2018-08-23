/*
 * Links:
 * Reemplazar nodos de texto:
 * https://stackoverflow.com/questions/11867269/replace-only-text-inside-a-div-using-jquery
 * 
 **/
var _tree = {
   name: '.tree-root',
   new_text: 'nueva cuenta',
   current_node: null
}

$(document).ready(function () {
   //convertir la lista anidada en un arbol
   initialize();

   //generar codigo automatico para cada cuenta
   var dataGen = $(_tree.name).attr('data-genCodigo');
   ;
   if (dataGen === '' || typeof dataGen === 'undefined' || dataGen === 'true') {
      genCodNodo($(_tree.name));
   } else {
      dividirCodigo($(_tree.name));
   }
   //observese que no se asignará el evento click de forma no tan usual
   //sino con delegacion de evento
   $(_tree.name).on('click', 'li a', enfocar);

   //limpiar formulario
   limpiarFormulario();

   //asociar un formulario a cada elemento para editar sus atributos
   $('#form-cuenta').on('submit', guardarCuenta);

   $('#form-catalogo').submit(enviarFormulario);

   //funcion del doble click
   $(_tree.name).on('dblclick', 'li a', manejadorDblclick);
});

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
   if (_tree.current_node === null) {
      $(actual).addClass("focus-gained");
      $(actual).focus();
      _tree.current_node = actual;
   } else {
      //cuando hay un elemento seleccionado:
      //primeramente deseleccionar el actual
      //despues seleccionar el nodo actual
      $(_tree.current_node).removeClass('focus-gained');
      $(actual).addClass('focus-gained');
      $(actual).focus();
      _tree.current_node = actual;
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
function collExp(alink_elem, segundos) {
   var next_element = $(alink_elem).next('ul');
   var open = $(next_element).attr('data-opened');

   if (open === null || open === 'false') {
      $(next_element).attr('data-opened', true);
      $(next_element).show(segundos);
   } else {
      $(next_element).attr('data-opened', false);
      $(next_element).hide(segundos);
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
   for (var i = 0; i < listaNodos.length; i++) {
      elem = $(listaNodos[i]).children('a');
      cod = $(elem).attr('data-codigo');
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
 */
function genCodNodo(nodo, nivel = 0, sobreEscribirCodigo = true) {
   //nodo es un elemento ul
   if (nodo === null) {
      return;
   }
   var listaNodos = $(nodo).children('li');
   var elem;
   var cod;
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

/**
 * Esta funcion convierte una lista en un elemento que sera usado como arbol desde este script
 */
function initialize() {
   var elementos = $(_tree.name + ' li');
   var text = "";
   $(elementos).contents().filter(function () {
      return this.nodeType === 3;//cuando el nodo es un elemento de texto
   }).each(function () {
      var texto = this.textContent;
      //eliminar espacios en blanco
      this.textContent = texto.trim();
      if (this.textContent === '' || this.textContent === null)
         return;//para nodos vacios no hacer nada
      var nodo_nuevo = document.createElement('a');
      var nodo_nuevo = newElementA(this.textContent);
      $(this).replaceWith(nodo_nuevo);
   });
   //abrir o cerrar los nodos segun el atributo data-opened
   elementos = $(_tree.name + ' li a').each(function () {
      var next = $(this).next('ul');
      var data_abierto = $(next).attr('data-opened');

      if (data_abierto !== null && data_abierto === 'true') {
         $(next).attr('data-opened', false);
         collExp(this, 0);
      } else if (data_abierto !== null && data_abierto === 'false') {
         $(next).attr('data-opened', true);
         collExp(this, 0);
      }
   });
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
}
function guardarCuenta(e) {
   e.preventDefault();
   var obj = {
      nombre: $('#nombre-cuenta').val(),
      codigo: $('#codigo-cuenta').val(),
      descripcion: $('#descripcion-cuenta').val(),
      saldo: $('#form-cuenta input[name=saldo]:checked').val()
   };

   $(_tree.current_node).attr({
      'data-codigo': obj.codigo,
      'data-descripcion': obj.descripcion,
      'data-saldo': obj.saldo
   });
   $(_tree.current_node).html('<i class="fa fa-folder mr-1 text-info"></i>' + obj.nombre);
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

   if (text === null)
      text = _tree.new_text;
   $(nuevo).html('<i class="fa fa-folder text-info mr-1"></i>'
           + text);
   return nuevo;
}
function newNode() {
   //crear un elemento li y agregarle un enlace (dentro)
   var nuevoLi = document.createElement('li');
   return $(nuevoLi).append(newElementA());
}
function createNode() {

   //cuando se crea un nuevo elemento esta funcion debe ser llamada
   var nuevo;

   //no hay nodo seleccionado
   if (_tree.current_node === null) {
      //crear un nuevo nodo de lista
      var nuevo = newNode();
      //insertar el nuevo elemento RAIZ al final
      $(_tree.name).append(nuevo);

      //obtener un nuevo codigo generado
      var lista = $(_tree.name + ' > li > a');
      var mayor = mayorElementoPor('data-codigo', lista) + 1;

      //seleccionar el elemento recien creado
      var a = $(nuevo).find('a')[0];
      $(a).attr('data-codigo', mayor);
      seleccionarElemento($(nuevo).find('a')[0]);

   } else {

      //se obtenemos el elemento padre que se supone es un li
      var dataSaldo = $(_tree.current_node).attr('data-saldo');
      var par = $(_tree.current_node).parent();
      //buscamos el primer ul
      var sel = $(par).find('ul:first');
      nuevo = null;

      //para el caso que el elemento actual tiene al menos un hijo
      if (sel.length > 0) {

         //agregar al ul padre un item con un enlace
         $(sel).append(newNode());

         //nuevo es el nodo recien creado
         nuevo = $(sel).find(' li:last a');

         //obtener un nuevo codigo generado
         var lista = $(sel).find('a');
         var mayor = mayorElementoPor('data-codigo', lista) + 1;
//		 console.log('mayor: ' + mayor);
         var nivel = obtenerNivel(nuevo);
//		 console.log('nivel: ' + nivel);
         mayor = genCodNivel(mayor, nivel);
//		 console.log('codigo: ' + mayor);
         $(nuevo).attr('data-codigo', mayor);
         $(nuevo).attr('data-saldo', dataSaldo);
         seleccionarElemento(nuevo);
      } else {

         //para el caso que el elemento no tenga ningun hijo
         nuevo = $('<ul>');
         $(nuevo).append(newNode());
         $(par).append(nuevo);

         //nuevo es el nodo recien creado
         nuevo = $(par).find('ul li:last a');

         //obtener un nuevo codigo generado
         var lista = $(sel).find('a');
         var mayor = 1;
//		 console.log('mayor: ' + mayor);
         var nivel = obtenerNivel(nuevo);
//		 console.log('nivel: ' + nivel);
         mayor = genCodNivel(mayor, nivel);
//		 console.log('codigo: ' + mayor);

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

   $(_tree.name + ' .focus-gained').removeClass('focus-gained');
   $(_tree.current_node).parent().remove();
   _tree.current_node = null;
   limpiarFormulario();
}
function deselect() {
   $(_tree.name + ' .focus-gained').removeClass('focus-gained');
   _tree.current_node = null;
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
   while (tmp && !$(tmp).is(_tree.name + ' > li')) {
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
   var arbol = $(_tree.name);
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
