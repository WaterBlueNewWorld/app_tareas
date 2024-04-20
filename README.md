# App lista tareas (TODO app)

Esta app concentra tres tipos de modulos
 * Lista de tareas por hacer
 * Calculadora de propinas
 * Solicitud a RestAPI

## Dependencias
Antes de construir esta aplicacion se debe contar con las siguientes dependencias de
desarrollo:

* Flutter 3.19.6
* Android Studio (Android SDK API 23 minimo)
* (Opcional) IntelliJ IDEA

## Construccion de app

Esta app es capaz de ser usada en todas la plataformas, sim embargo, esta pensada para Android/iOS
y la implementacion de SQLite esta pensada sobre Android/iOS tambien

Para construir la app basta ejecutar los siguientes comandos:

Obtenemos las librerias
```bash
flutter pub get
```

Seguido ejecutamos
```bash
flutter devices
```
Este comando nos dara el nombre de los dispositivos reconocidos por el SDK de flutter

Una vez hecho el paso anterior debemos escribir el siguiente comando
```bash
flutter run -d <id de dispositivo>
```

## Generacion de splash
La app cuenta con un paquete para generar imagenes splash para cargar info o mostrar informacion
mientras la app inicia.

Para crear una splash se debe ejecutar el siguiente comando
```bash
dart run flutter_native_splash:create
```
Hay que tener en cuenta que este comando no funcionara si no se ejecuta `flutter pub get` antes