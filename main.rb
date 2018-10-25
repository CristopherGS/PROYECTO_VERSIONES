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
  puts "\tBiblioteca"
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
      when '4'
      when '5'
      when '6'
      end
    end while opcion1 != '7'
  when '2'
  end
  limpiar_pantalla() 
end while opcion != '3'