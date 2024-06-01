Feature: Gestión de Transacciones

  Escenario: Añadir una nueva transacción bancaria
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona la opción para añadir una nueva transacción
    Y el usuario introduce los detalles de la transacción (fecha, monto, descripción y categoría)
    Y el usuario guarda la transacción
    Entonces la nueva transacción es guardada en el sistema
    Y la transacción es visible en la lista de transacciones
    
    Ejemplos:
    # Categorías disponibles
    | Categoría |
    | Donaciones |
    | Cuotas |
    | Subvenciones |
    | Gastos |
    | Eventos |
    | Administrativo |
    | Actividades |

  Escenario: Añadir una lista de transacciones bancarias
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona la opción para importar una lista de transacciones
    Y el usuario carga el archivo con las transacciones
    Y el sistema procesa el archivo y muestra un resumen de las transacciones importadas
    Y el usuario confirma y guarda las transacciones
    Entonces las transacciones son guardadas en el sistema
    Y las transacciones son visibles en la lista de transacciones
    # En este caso, quedaría pendiente la validación de los datos importados y la categorización de las transacciones

  Escenario: Asociar una transacción con un contacto
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona una transacción de la lista y selecciona la opción para asociar un contacto
    Y el usuario elige un contacto de la lista de contactos
    Y el usuario guarda la asociación
    Entonces la transacción es asociada con el contacto seleccionado
    # El contacto seleccionado puede ser cualquier contacto independientemente del tipo de contacto

  Escenario: Filtrar transacciones por categoría
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona una categoría de la lista de categorías
    Entonces el sistema muestra solo las transacciones de la categoría seleccionada
  
  Escenario: Filtrar transacciones por fecha
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona un rango de fechas
    Entonces el sistema muestra solo las transacciones dentro del rango seleccionado

  Escenario: Asociar una selección de transacciones con un contacto
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona varias transacciones de la lista y selecciona la opción para asociar un contacto
    Y el usuario elige un contacto de la lista de contactos
    Y el usuario guarda la asociación
    Entonces las transacciones seleccionadas son asociadas con el contacto seleccionado
