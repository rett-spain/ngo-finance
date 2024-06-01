Feature: Gestión de Contactos

  Escenario: Asociar un contacto o lista de contactos con una convocatoria de becas de terapias
    Dado que el usuario está autenticado y en la sección de contactos
    Cuando el usuario selecciona uno o más contactos
    Y el usuario asocia los contactos a una convocatoria de becas
    Y el usuario guarda los cambios
    Entonces los contactos son asociados a la convocatoria de becas
