require 'rubygems'
require 'terminal-table/import'

def limpiar_pantalla
  system('clear')
end

def buscar_libro(pila,isbn)
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

def lista_libros(pila)
  limpiar_pantalla
  if pila[:tope] == nil
    puts 'No Hay Libros Ingresados O En Existencia'
  else
    user_table=table do |t|
      t.title = '*-*-*-*-LISTA DE LIBROS-*-*-*-*'
      t.headings = 'ISB', 'NOMBRE', 'PRECIO','AUTOR','EXISTENCIAS'
      aux = pila[:tope]
      loop do
       t << [
        aux[:ISBN],
        aux[:nombre],
        aux[:precio],
        aux[:autor],
        aux[:existencias]
      ]
       if aux[:siguiente] == nil
          break
       end
       aux = aux[:siguiente]
      end
    end
      puts user_table
  end
  gets()
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
      t.title = '*-*-*-*-Buscador de Libros-*-*-*-*'
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
  gets()
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
  puts "\tBiblioteca de lirbros"
  puts 'Listado de opciones: '
  puts '1. Registro de Libros'
  puts '2. Control de Ventas'
  puts '3. Salir'
  print 'Ingrese una opcion: '
  opcion=gets.chomp
  case opcion
  when '1'
    begin
      limpiar_pantalla()
      puts "\tRegistro de Libros"
      puts 'Listado de opciones: '
      puts '1. Registro de Nuevo Libro'
      puts '2. Registro de Nuevo Autor'
      puts '3. Buscar Libro'
      puts '4. Buscar Autor'
      puts '5. Lista de Libros'
      puts '6. Lista de Autores'
      puts '7. Salir'
      print 'Ingrese una opcion: '
      opcion1 = gets.chomp
      case opcion1
      when '1'
        registro_nuevo_libro(plia,cola)
      when '2'
        nuevo_autor(cola)
      when '3'
        buscar_libro1(pila)
      when '4'
        mostrar_autor(cola,pila)
      when '5'
        listado_de_libros(pila)
      when '6'
        lista_libros(pila)
      end
    end while opcion1 != '7'
  when '2'
    begin
      puts "\tControl de Ventas"
      puts 'Listado de opciones: '
      puts '1. Registro de una Venta'
      puts '2. Buscar una Venta'
      puts '3. Listado de Ventas'
      puts '4. Salir'
      opcion2=gets.chomp
      case opcion2
      when '1'
        registro_de_ventas(venta,pila)
      when '2'
        mostrar_una_venta(venta)
      when '3'
      end
    end while opcion2 !='4'
  end
  limpiar_pantalla()
end while opcion != '3'
