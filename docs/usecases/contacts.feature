Feature: Gestión de Contactos

  Escenario: Listar contactos
    Dado que el usuario está autenticado y en la sección de contactos
    Cuando el usuario accede a la sección de contactos
    Entonces el usuario ve una lista de contactos

  Escenario: Buscar contactos
    Dado que el usuario está autenticado y en la sección de contactos
    Cuando el usuario busca un contacto
    Entonces el usuario ve una lista de contactos que coinciden con la búsqueda

  Escenario: Ver detalles de un contacto
    Dado que el usuario está autenticado y en la sección de contactos
    Cuando el usuario selecciona un contacto
    Entonces el usuario ve los detalles del contacto

  Escenario: Ver personas Rett asociados a un contacto
    Dado que el usuario está autenticado y en la sección de contactos
    Cuando el usuario selecciona un contacto
    Entonces el usuario ve una lista de personas Rett asociados al contacto

  Escenario: Ver transacciones asociadas a un contacto
    Dado que el usuario está autenticado y en la sección de contactos
    Cuando el usuario selecciona un contacto
    Entonces el usuario ve una lista de transacciones asociadas al contacto

  Escenario: Editar el tipo de contacto
    Dado que el usuario está autenticado y en la sección de contactos
    Cuando el usuario selecciona un contacto
    Entonces el usuario puede editar el tipo de contacto

    Ejemplos: 
      | tipo de contacto |
      | Socio ordinario |
      | Socio colaborador |
      | Donante particular |
      | Donante empresa |
      | No socio |
      | Baja |

  Escenario: Dar de baja un contacto
    Dado que el usuario está autenticado y en la sección de contactos
    Cuando el usuario selecciona un contacto
    Entonces el usuario puede dar de baja el contacto, cambiando el tipo de contacto a "Baja" y añadir una fecha de baja

