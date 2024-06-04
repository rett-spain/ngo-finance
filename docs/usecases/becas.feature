Feature: Gestión de Becas

  Escenario: Asociar un contacto o lista de contactos con una convocatoria de becas de terapias
    Dado que el usuario está en la sección de contactos
    Cuando el usuario selecciona uno o más contactos
    Y el usuario asocia los contactos a una convocatoria de becas
    Y el usuario guarda los cambios
    Entonces los contactos son asociados a la convocatoria de becas

  Escenario: Al asociar una transacción de pago de beca con un contacto, se actualiza el estado de la beca
    Dado que el usuario está en la sección de becas
    Cuando el usuario selecciona una beca
    Y el usuario asocia una transacción de pago a la beca
    Y el usuario guarda los cambios
    Entonces el estado de la beca es actualizado para estar en estado "Pagada" para el contacto asociado

  Escenario: Dar de alta una nueva beca
    Dado que el usuario está en la sección de becas
    Cuando el usuario selecciona la opción de dar de alta una nueva beca
    Y el usuario llena los campos requeridos
    Y el usuario guarda los cambios
    Entonces la beca es creada y se muestra en la lista de becas

    Ejemplos:
      | Nombre de la beca | Fecha de inicio | Fecha de fin | Estado de la beca | Contacto asociado |
      | Beca 1            | 01/01/2021      | 01/02/2021   | Activa            | Contacto 1        |
      | Beca 2            | 01/03/2021      | 01/04/2021   | Activa            | Contacto 2        |
      | Beca 3            | 01/05/2021      | 01/06/2021   | Activa            | Contacto 3        |
      | Beca 3            | 01/07/2021      | 01/08/2021   | Activa            | Contacto 4        |
      | Beca 3            | 01/09/2021      | 01/10/2021   | Activa            | Contacto 5        |

  Escenario: Editar una beca
    Dado que el usuario está en la sección de becas
    Cuando el usuario selecciona una beca
    Y el usuario selecciona la opción de editar la beca
    Y el usuario modifica los campos requeridos
    Y el usuario guarda los cambios
    Entonces la beca es actualizada y se muestra en la lista de becas

  Escenario: Eliminar una beca
    Dado que el usuario está en la sección de becas
    Cuando el usuario selecciona una beca
    Y el usuario selecciona la opción de eliminar la beca
    Y el usuario confirma la eliminación
    Entonces la beca es eliminada y no se muestra en la lista de becas

  Escenario: Filtrar becas por estado
    Dado que el usuario está en la sección de becas
    Cuando el usuario selecciona un estado de beca
    Entonces se muestran solo las becas que tienen el estado seleccionado

