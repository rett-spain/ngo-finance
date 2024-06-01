Feature: Gestión de Transacciones

  Scenario: Añadir una nueva transacción bancaria
    Given el usuario está autenticado y en la sección de transacciones
    When el usuario selecciona la opción para añadir una nueva transacción
    And el usuario introduce los detalles de la transacción (fecha, monto, descripción)
    And el usuario guarda la transacción
    Then la nueva transacción es guardada en el sistema
    And la transacción es visible en la lista de transacciones

  Scenario: Añadir una lista de transacciones bancarias
    Given el usuario está autenticado y en la sección de transacciones
    When el usuario selecciona la opción para importar una lista de transacciones
    And el usuario carga el archivo con las transacciones
    And el sistema procesa el archivo y muestra un resumen de las transacciones importadas
    And el usuario confirma y guarda las transacciones
    Then las transacciones son guardadas en el sistema
    And las transacciones son visibles en la lista de transacciones
