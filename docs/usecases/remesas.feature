Feature: Remesas

  Escenario: Crear nueva remesa bancaria para pago de cuotas de socios
    # Premisas:
    # La aplicación identifica automáticamente los socios que tienen cuotas pendientes de pago
    # La aplicación permite seleccionar otros socios para incluir en la remesa
    # La aplicación identifica automáticamente el importe de la cuota de socio
    # La aplicación genera un archivo con el formato de remesa bancaria (SEPA)
    Dado que el usuario está en la sección de remesas
    Cuando el usuario selecciona la opción para crear una nueva remesa bancaria
    Y el sistema identifica automáticamente los socios con cuotas pendientes de pago
    Y el sistema identifica automáticamente el importe de la cuota de socio
    Y el usuario selecciona los socios adicionales que desea incluir en la remesa
    Y el usuario confirma y guarda la remesa
    Entonces el sistema genera un archivo con el formato de remesa bancaria (formato SEPA)

  Escenario: Generar transacciones individuales correspondientes a la remesa bancaria de cuota de socio, a partir de un archivo con formato específico
    Dado que el usuario está en la sección de transacciones
    Cuando el usuario selecciona la opción para importar una remesa bancaria
    Y el usuario carga el archivo con la remesa bancaria
    Y el sistema procesa el archivo y muestra un resumen de las transacciones importadas
    Y el usuario confirma y guarda las transacciones
    Entonces las transacciones son guardadas en el sistema como pago de cuotas de socios

      Ejemplos:
      # Formato de archivo
      | DNI socio | Nombre socio | Fecha de pago |
      | XXXXXXXXX | Juan Pérez   | 2021-01-15   |
      | XXXXXXXXX | María López  | 2021-01-15   |
      | XXXXXXXXX | Pedro Gómez  | 2021-01-15   |
