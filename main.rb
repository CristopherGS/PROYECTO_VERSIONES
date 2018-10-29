require 'rubygems'
require 'terminal-table/import'

def limpiar_pantalla
  system('clear')
end

def lista_autores(cola)
  limpiar_pantalla
  if cola[:vacio]
    puts "No se han registrado          autores"
  else
    user_table=table  do |t|
      t.title = "LISTADO DE AUTORES"
      t.headings = 'NOMBRE DEL AUTOR', 'LIBROS'
       aux = cola[:tope]
      loop do
        t << [
          aux[:nombre],
          aux[:libros]
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

def registro_libros(pila, cola)
  limpiar_pantalla
  if cola[:vacio]
    puts 'No se han registrado autores'
  else
    print 'Ingrese el nombre del autor: '
    nombre = gets.chomp
    aux_autor = buscar_autor(cola,nombre)
    if aux_autor == 'El autor no esta registrado'
      puts 'Este autor no se ha registrado'
    else
      if pila[:vacio]
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
            aux[:existencias]+=1
          else
            puts 'ERROR, conflicto de ISBN'
            puts 'Este ISBN ya lo contiene un libro de otro autor'
          end
        end
      end
    end
  end
  print 'Presione enter para continuar'
  gets
end

def lista_libros(pila)
  limpiar_pantalla
  if pila[:tope] == nil
    puts 'No Hay Libros Ingresados O En Existencia'
  else
    user_table=table do |t|
      t.title = 'LISTA DE lIBROS'
      t.headings = 'ISBN', 'NOMBRE', 'PRECIO','AUTOR','EXISTENCIAS'
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

def registro_autores(cola)
  limpiar_pantalla
  if cola[:size] < cola[:max]
    if cola[:vacio]
      print 'Ingrese el nombre del nuevo autor: '
      nombre = gets.chomp
      autor = {
        nombre: nombre,
        libros: 0,
        siguiente: nil
      }
      cola[:tope] = autor
      cola[:final] = autor
      cola[:vacio] = false
      cola[:size] += 1
      cola[:vacio] = false
    else
      print 'Ingrese el nombre del nuevo autor: '
      nombre = gets.chomp
      elemento = cola[:tope]
      c = 1
      c2 = 0
      while c <= cola[:size]
        if elemento[:nombre] == nombre
          c2 += 1
        end
        if c != cola[:size]
          aux_elemento = elemento[:siguiente]
          elemento = aux_elemento
        end
        c += 1
      end
      if c2 > 0
        puts 'Ya existe un autor registrado con el mismo nombre'
      else
        autor = {
          nombre:nombre,
          libros: 0,
          libros1: nil,
          vacio: true,
          siguiente:nil,
        }
        aux = cola[:final]
        aux[:siguiente] = autor
        cola[:final] = autor
        cola[:size]+=1
      end
    end
  else
    puts 'Se ha agotado el espacio para registrar autores'
  end
  print 'Presione enter para continuar'
  gets
  limpiar_pantalla
end

def buscar_autor(cola,nombre)
  limpiar_pantalla
  elemento = cola[:tope]
  c = 1
  while c <= cola[:size]
    if elemento[:nombre] == nombre
      c=6
      return elemento
      break
    elsif   elemento[:siguiente] == nil && elemento[:valor] != nombre
      return 'El autor no esta registrado'
      break
    else
      aux = elemento[:siguiente]
      elemento = aux
      c+=1
    end
  end
end

def buscar_autor1(cola,pila)
  limpiar_pantalla
  if cola[:vacio]
    puts 'No hay autores registrados'
  else
    print 'Ingrese el nombre del autor: '
    nombre = gets.chomp
    elemento = buscar_autor(cola,nombre)
    if elemento =='El autor no esta registrado'
      puts elemento
    else
      if elemento[:libros] == 0
        user_table = table do |t|
        t.title = "Nombre Autor: #{elemento[:nombre]}"
        t << ['El autor no tiene libros registrados']
        end
        puts user_table
      else
        tope = pila[:tope]
        user_table = table do |t|
        t.title = " AUTOR -#{elemento[:nombre]}-"
        t << ['ISBN','NOMBRE','PRECIO','EXISTENCIAS']
        loop do
          if tope[:autor] == elemento[:nombre]
            t << [
              tope[:ISBN],
              tope[:nombre],
              tope[:precio],
              tope[:existencias]
            ]
            if tope[:siguiente] == nil
              break
            end
            tope = tope[:siguiente]
          else
            if tope[:siguiente] == nil
              break
            end
            tope = tope[:siguiente]
          end
        end
        end
        puts user_table
      end
    end
  end
  print 'Presione enter para continuar'
  gets
end

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
      t.headings = 'ISBN', 'NOMBRE DEL LIBRO', 'AUTOR', 'PRECIO', 'EXISTENCIAS'
      t << [
        libro[:ISBN],
        libro[:nombre],
        libro[:autor],
        libro[:precio],
        libro[:existencias]
      ]
    end
    puts user_table
  else
    limpiar_pantalla
    puts 'El libro no se registrado'
  end
  gets
end

venta ={
  tope:nil,
  max:-1,
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
      puts "\tAdministracion de libros"
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
