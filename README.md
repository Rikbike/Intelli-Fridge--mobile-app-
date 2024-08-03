# Intelli Fridge
Intelli Fridge es una aplicación que permite a los usuarios monitorear la temperatura y humedad del refrigerador, gestionar perfiles, tomar notas y usar la cámara integrada. La aplicación se basa en Flutter y utiliza Firebase para la autenticación, la base de datos en tiempo real y Firestore.

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
