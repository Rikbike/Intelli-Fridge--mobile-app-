# Intelli Fridge
ntelli Fridge es una aplicación innovadora desarrollada con Flutter y Firebase, diseñada para ayudarte a gestionar y monitorear tu refrigerador de manera inteligente. Con esta aplicación, puedes registrar y visualizar dentr del refrigerador por medio de la camara al igual la temperatura y humedad dentro de tu refrigerador, así como registrar productos y notas importantes.

## Estructura del Proyecto
La estructura principal del proyecto es la siguiente:

## lib/
- main.dart
- firebase_options.dart
- pantallas/
- LoginScreen.dart
- TemperaturaScreen.dart
- RegisterScreen.dart
- PerfilesScreen.dart
- NotasScreen.dart
- HomeScreen.dart
- CamaraScreen.dart

## Uso de la Aplicación
Inicio de Sesión
Al iniciar la aplicación, se presenta la pantalla de inicio de sesión (LoginScreen.dart). Los usuarios pueden iniciar sesión con sus credenciales de Firebase Authentication.

## Registro de Usuarios
Si no tienes una cuenta, puedes registrarte en la pantalla de registro (register_screen.dart). Se solicitan los datos básicos del usuario, que se almacenan en Firebase.

## Pantalla Principal
Después de iniciar sesión, se muestra la pantalla principal (home.dart). Desde aquí, puedes navegar a las diferentes secciones de la aplicación.

## Monitor de Temperatura y Humedad
En la pantalla de temperatura (temperatura.dart), puedes visualizar la temperatura y humedad actual dentro de tu refrigerador. Estos datos se obtienen de un sensor DHT11 conectado a Firebase en tiempo real.

## Notas y Recordatorios
La sección de notas (notas.dart) permite a los usuarios registrar notas importantes y recordatorios sobre los productos almacenados en el refrigerador.

## Gestión de Perfiles
En la pantalla de perfiles (perfiles.dart), los usuarios pueden gestionar sus datos personales y preferencias.

## Cámara
La pantalla de cámara (CamaraScreen.dart) permite tomar fotos de los productos y almacenarlas en Firebase Storage para un fácil acceso y gestión visual.

# Herramientas Utilizadas
## Flutter
Flutter es el framework principal utilizado para desarrollar la interfaz de usuario de la aplicación. Proporciona un entorno de desarrollo rápido y eficiente para aplicaciones multiplataforma.

## Firebase
Firebase se utiliza para la autenticación, almacenamiento en tiempo real de datos y almacenamiento de imágenes. Los servicios de Firebase empleados incluyen:

- Firebase Authentication: Para la gestión de usuarios.
- Firebase Realtime Database: Para almacenar y sincronizar datos de temperatura y humedad.
- Firebase Storage: Para almacenar imágenes de productos.

## Sensor DHT11
El sensor DHT11 se utiliza para medir la temperatura y humedad dentro del refrigerador. Los datos del sensor se envían a Firebase, donde se actualizan en tiempo real y se muestran en la aplicación.

## Funcionamiento de la Aplicación
- Inicio de Sesión y Registro: Los usuarios pueden iniciar sesión o registrarse utilizando Firebase Authentication.
- Monitor de Temperatura y Humedad: La aplicación muestra datos en tiempo real del sensor DHT11, permitiendo a los usuarios monitorear las condiciones del refrigerador.
- Gestión de Notas y Productos: Los usuarios pueden registrar notas y tomar fotos de los productos para una gestión eficiente.
- Gestión de Perfiles: Los usuarios pueden actualizar sus datos personales y preferencias desde la pantalla de perfiles.
