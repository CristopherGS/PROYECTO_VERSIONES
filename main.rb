require 'rubygems'
require 'terminal-table/import'

def limpiar_pantalla
  system('clear')
end

def lista_libros(pila)
  if pila[:tope] == nil
    puts 'No Hay Libros Ingresados O En Existencia'
  else
  tabla = Terminal::Table.new do |t|
    t.title = 'Listado de Libros'
    t.headings = ['ISB', 'NOMBRE', 'PRECIO','AUTOR','EXISTENCIAS']
    aux = pila[:tope]
    loop do
      t.add_row([
        aux[:ISBN],
        aux[:nombre],
        aux[:precio],
        aux[:autor],
        aux[:existencias]
      ])
      if aux[:siguiente] == nil
        break
      end
      aux = aux[:siguiente]
    end
  end
  puts tabla
  gets
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
    # limpiar_pantalla()
    # user_table = table do |t|
    #   t.headings = 'ISBN', 'Nombre del Libro', 'Autor', 'Precio', 'Existencias'
    #   t << [
    #     libro[:ISBN],
    #     libro[:nombre],
    #     libro[:autor],
    #     libro[:Precio],
    #     libro[:existencias]
    #   ]
    limpiar_pantalla()
    tabla = Terminal::Table.new do |t|
      t.headings = ['NOMBRE','AUTOR','ISBN','PRECIO','EXISTENCIAS']
      t.add_row([
        libro[:nombre],
        libro[:autor],
        libro[:ISBN],
        libro[:Precio],
        libro[:existencias]
      ])
    
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
      puts '1. Registro de nuevos Libros'
      puts '2. Registro de autores'
      puts '3. Lista de Libros'
      puts '4. Lista de Autores'
      puts '5. Buscar libro'
      puts '6. Buscar Autor'
      puts '7. Salir'
      print 'Ingrese una opcion: '
      opc_2 = gets.chomp
      if opc_2 == '1'
        # registro_libros(pila, cola)
      elsif opc_2 == '2'
        # registro_autores(cola)
      elsif opc_2 == '3'
        lista_libros(pila)
      elsif opc_2 == '4'
        # lista_autores(cola)
      elsif opc_2 == '5'
        funcion(pila)
      elsif opc_2 == '6'
        # buscar_autor(cola, pila)
    end
    limpiar_pantalla()
    end while opc_2 != '7'
  end
 limpiar_pantalla()
end while opcion != '3'