Feature: Gestión de Rett Persona
  
  Escenario: Listar Rett Personas
    Dado que el usuario está en la página
    Cuando el usuario accede a la sección de Rett Personas
    Entonces el usuario ve una lista de Rett Personas ordenadas por orden alfabético
    # Columnas de la lista: Nombre y Apellidos, Fecha de Nacimiento, (Provincia ??)
    # Se mostrará un icono con una cruz al lado de la fecha de nacimiento en caso que la Rett Persona haya fallecido

    Ejemplos:
        | Nombre y Apellidos | Fecha de Nacimiento | Provincia |
        | Juana Pérez        | 01/01/1990          | Madrid    |
        | María López        | 02/02/1991          | Barcelona |
        | Antonia Gómez      | 03/03/1992          | Valencia  |
        | Ana Martínez       | 04/04/1993 x        | Sevilla   |

  Escenario: Buscar Rett Persona
    Dado que el usuario está en la sección de Rett Personas
    Cuando el usuario busca una Rett Persona
    Entonces el usuario ve una lista de contactos que coinciden con la búsqueda
    # Buscar por Nombre y Apellidos, Fecha de Nacimiento y Provincia

  Escenario: 