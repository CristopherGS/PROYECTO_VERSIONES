require 'rubygems'
require 'terminal-table/import'



def buscar_libro(pila,isbn)
  limpiar_pantalla
  libro = pila[:tope]
  contador=1
  while contador<=pila[:size]
    if libro[:ISBN]==isbn
      contador=pila[:size]+1
      return libro
    elsif libro[:siguiente]==nil && libro[:ISBN]!=isbn
      return 'El libro que ingreso no existe en el sistema'
      break
    else
      nuevo_elemento = libro[:siguiente]
      libro = nuevo_elemento
      contador+=1
    end
  end
end

def buscar_libro1(pila)
  limpiar_pantalla
  libro = pila[:tope]
  print 'Ingrese el ISBN del Libro: '
   isbn = gets.chomp
  contador=1
  a=0
  while contador <= pila[:size]
    if isbn == libro[:ISBN]
      contador=pila[:size]+1
      a=1
    elsif libro [:siguiente]==nil&&libro[:ISBN]!=isbn
      a=0
    else
      libro = libro[:siguiente]
    end
    contador+=1
  end
  if a==1
    limpiar_pantalla
    user_table = table do |t|
      t.title = 'BUSCADOR DE LIBROS'
      t.headings = 'ISBN', 'Nombre del Libro', 'Autor', 'Precio', 'Existencias'
      t << [
        libro[:ISBN],
        libro[:nombre],
        libro[:autor],
        libro[:Precio],
        libro[:existencias]
      ]
    end
    puts user_table
  else
    limpiar_pantalla
    puts 'El libro no se encuentra en el sistema'
  end
  gets
end

venta ={
  tope:nil,
  max:20,
  size:0,
  vacio:true,
  final:nil
}

cola ={
  vacio:true,
  size:0,
  max:5,
  tope:nil,
  final:nil
}

pila ={
  tope:nil,
  vacio:true,
  size:0
}

begin
  puts "\tBiblioteca de libros"
  puts 'Listado de opciones: '
  puts '1. Registro de Libros'
  puts '2. Control de Ventas'
  puts '3. Salir'
  print 'Ingrese una opcion: '
  opcion = gets.chomp
  limpiar_pantalla()
  if opcion == '1'
    begin
      puts "\tRegistro de Libros"
      puts 'Listado de opciones: '
      puts '1. Registro de Nuevos Libros'
      puts '2. Registro de Autores'
      puts '3. Lista de Libros'
      puts '4. Lista de Autores'
      puts '5. Buscar libro'
      puts '6. Buscar Autor'
      puts '7. Salir'
      print 'Ingrese una opcion: '
      opc_2 = gets.chomp
      if opc_2 == '1'
        registro_libros(pila, cola)
      elsif opc_2 == '2'
        registro_autores(cola)
      elsif opc_2 == '3'
        lista_libros(pila)
      elsif opc_2 == '4'
        lista_autores(cola)
      elsif opc_2 == '5'
        buscar_libro1(pila)
      elsif opc_2 == '6'
        buscar_autor1(cola, pila)
    end
    limpiar_pantalla()
    end while opc_2 != '7'
  elsif opcion == '2'
    begin
      puts "\tControl de Ventas"
      puts 'Listado de opciones: '
      puts '1. Registro De Nueva Venta'
      puts '2. Buscar una Venta'
      puts '3. Lista de Ventas'
      puts '4. Salir'
      print 'Ingrese una opcion: '
      opc_3 = gets.chomp
      if opc_3 == '1'
      elsif opc_3 == '2'
      elsif opc_3 == '3'
    end
      limpiar_pantalla()
    end while opc_3 != '4'
  end
 limpiar_pantalla()
end while opcion != '3'