require 'rubygems'
require 'terminal-table/import'

def limpiar_pantalla
  system('clear')
end

def buscar_libro(pila)
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
end

venta ={
  tope:nil,
  max:20,
  size:0
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
      when '2'
      when '3'
        buscar_libro(pila)
      when '4'
      when '5'
      when '6'
      end
    end while opcion1 != '7'
  when '2'
  end
  limpiar_pantalla()
end while opcion != '3'
