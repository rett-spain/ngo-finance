Feature: Gestión de Transacciones

  Escenario: Añadir una nueva transacción bancaria
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona la opción para añadir una nueva transacción
    Y el usuario introduce los detalles de la transacción (fecha, monto, descripción y categoría)
    Y el usuario guarda la transacción
    Entonces la nueva transacción es guardada en el sistema
    Y la transacción es visible en la lista de transacciones

  Escenario: Añadir una lista de transacciones bancarias
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona la opción para importar una lista de transacciones
    Y el usuario carga el archivo con las transacciones
    Y el sistema procesa el archivo y muestra un resumen de las transacciones importadas
    Y el usuario confirma y guarda las transacciones
    Entonces las transacciones son guardadas en el sistema
    Y las transacciones son visibles en la lista de transacciones
    # En este caso, quedaría pendiente la validación de los datos importados y categorización de las transacciones

  Escenario: Asociar una transacción con una cuenta de pago
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona una transacción de la lista
    Y el usuario elige la cuenta de pago correspondiente
    Y el usuario guarda la asociación
    Entonces la transacción es asociada con la cuenta de pago seleccionada

  Escenario: Asociar una transacción con un proveedor
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona una transacción de la lista
    Y el usuario busca y selecciona el proveedor correspondiente
    Y el usuario guarda la asociación
    Entonces la transacción es asociada con el proveedor seleccionado

