### Mostrar una página
- Estado loading y llamar a metadata y parameters
- Llamar a data por cada código
- Cargar datos


> Todas las páginas se abren con bottom sheet

### Información de indicador

### Añadir página

### Eliminar página

### Editar página

### Gestión de refresco de datos

### Sistema de alertas
- Crear endpoint que recibe las alertas a mostrar al usuario
- Cada alerta tiene un código único para poder gestionar si se muestra en local
{
"code": String,
"publication_date": Date,
"title": String?
"message": String,
"icon": URL?,
"background_color": HEX, // default negro
"foreground_color": HEX // default blanco
}
