require 'rubygems'
require 'terminal-table/import'

def limpiar_pantalla
  system('clear')
end

def registro_libros(pila, cola)
  if cola[:vacio]
    puts 'No se han ingresado autores al sistema, enter para continuar'
    gets
  else
    print 'Ingrese el nombre del autor: '
    nombre = gets.chomp
    aux_autor = buscar_autor(cola,nombre)
    #CHECAR ESTO EN FUNCION DE BUSCAR AUTOR
    if aux_autor == '***El autor no existe en el sistema***'
      puts "Este autor no se ha registrado"
    else
      if pila[:esta_vacio]
        print 'Ingrese el ISBN del libro: '
        isbn = gets.chomp
        print 'Ingrese el nombre del libro: '
        nomlibro = gets.chomp
        print 'Ingrese el precio del libro: '
        preclibro = gets.to_i
        libro = {
          nombre:nomlibro,
          ISBN:isbn,
          autor: nombre,
          precio: preclibro,
          existencias: 1,
          siguiente: nil
        }
        pila[:tope] = libro
        pila[:vacio] = false
        pila[:size] += 1
        aux_autor[:libros] += 1
      else
        print 'Ingrese el ISBN del libro: '
        isbn = gets.chomp
        aux = buscar_libro(pila,isbn)
        if aux == 'El libro que ingreso no existe en el sistema'
          print 'Ingrese el nombre del libro: '
          nomlibro = gets.chomp
          print 'Ingrese el precio del libro: '
          preclibro = gets.to_i
          libro = {
            nombre:nomlibro,
            ISBN:isbn,
            autor: nombre,
            precio: preclibro,
            existencias: 1,
            siguiente: nil
          }
          libro[:siguiente] = pila[:tope]
          pila[:tope] = libro
          pila[:size] += 1 
          aux_autor[:libros] += 1
        else
          if nombre == aux[:autor]
            puts "El ISBN ingresado pertenece al libro -#{aux[:nombre]}-"
            puts "Perteneciente al autor -#{aux[:autor]}-"
            puts "se le sumara una a las existencias de este libro."
            aux[:existencias]+=1
          else
            puts "El ISBN #{isbn} le pertene al  libro -#{aux[:nombre]}-"
            puts "Perteneciente al autor -#{aux[:autor]}-"
            puts "Ingrese un ISBN DIFERENTE!!!"
          end
        end
      end
    end
  end
end

def lista_libros(pila)
  if pila[:tope] == nil
    puts 'No Hay Libros Ingresados O En Existencia'
  else
    user_table=table do |t|
      t.title = 'Lista de Libros'
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
  gets
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

def buscar_libro1(pila)
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
      t.title = 'Buscador de Libros'
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
        registro_libros(pila, cola)
      elsif opc_2 == '2'
        # registro_autores(cola)
      elsif opc_2 == '3'
        lista_libros(pila)
      elsif opc_2 == '4'
        # lista_autores(cola)
      elsif opc_2 == '5'
        buscar_libro1(pila)
      elsif opc_2 == '6'
        # buscar_autor(cola, pila)
    end
    limpiar_pantalla()
    end while opc_2 != '7'
  end
 limpiar_pantalla()
end while opcion != '3'