Feature: Gestión de Contactos

  Escenario: Listar contactos
    Dado que el usuario está en la página de inicio
    Cuando el usuario accede a la sección de contactos
    Entonces el usuario ve una lista de contactos ordenada alfabéticamente
    # Columnas de la lista: Nombre y Apellidos, Tipo de contacto, Teléfono, Email

  Escenario: Buscar contactos
    Dado que el usuario está en la sección de contactos
    Cuando el usuario busca un contacto
    Entonces el usuario ve una lista de contactos que coinciden con la búsqueda
    # Buscar por Nombre y Apellidos, Tipo de contacto, Teléfono, Email

  Escenario: Ver detalles de un contacto
    Dado que el usuario está en la sección de contactos
    Cuando el usuario selecciona un contacto haciendo doble click en el contacto de la lista
    Entonces se abre una ficha de detalle y el usuario ve los detalles del contacto
    # Qué detalles interesa mostrar?

  Escenario: Ver personas Rett asociados a un contacto
    Dado que el usuario está en la sección de contactos
    Cuando el usuario selecciona un contacto haciendo doble click en el contacto de la lista
    Entonces se abre una ficha de detalle y el usuario ve una lista de personas Rett asociados al contacto

  Escenario: Ver transacciones asociadas a un contacto
    Dado que el usuario está en la sección de contactos
    Cuando el usuario selecciona un contacto haciendo doble click en el contacto de la lista
    Entonces el usuario ve una lista de transacciones asociadas al contacto
    # A lo mejor tiene sentido poner diferentes acciones al usuario:
    # (ver detalle contacto, ver transacciones, lista de personas Rett asociadas con este contacto, etc.)

  @cuota
  Escenario: Ver si un contacto está al corriente de pago
    Dado que el usuario está en la sección de contactos
    Cuando el usuario selecciona un contacto
    Entonces el usuario ve si el contacto está al corriente de pago de la cuota anual

  Escenario: Ver el listado de socios al corriente de pago
    Dado que el usuario está en la sección de contactos
    Cuando el usuario accede a la sección de contactos
    Entonces el usuario ve una lista de socios al corriente de pago de la cuota anual

  Escenario: Editar el tipo de contacto
    Dado que el usuario está en la sección de contactos
    Cuando el usuario selecciona un contacto
    Entonces el usuario puede editar el tipo de contacto
    # Sólo se va a permitir editar algunos detalles del contacto

    Ejemplos: 
      | tipo de contacto |
      | Socio ordinario |
      | Socio colaborador |
      | Donante particular |
      | Donante empresa |
      | No socio |
      | Baja |
      | Proveedor |

  Escenario: Dar de baja un contacto
    Dado que el usuario está en la sección de contactos
    Cuando el usuario selecciona un contacto
    Entonces el usuario puede dar de baja el contacto, cambiando el tipo de contacto a "Baja" y obligando a introducir una fecha de baja
