import 'package:advanced_flutter/presentation/resources/route_manager.dart';
import 'package:advanced_flutter/presentation/resources/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key); //default constructor
  MyApp._internal(); //private named constructor
  int appState=0;

  static final MyApp instance = MyApp._internal(); // single instance --> Singleton
  /**
   * Dart'ın factory constuctorları sayesinde, bir singleton oluşturmak kolaydır. Yani bu sınıf bu örnek tekil olur
   * static ve final olması, yani artık değişmeyecek
   */

  factory MyApp() => instance; // factory for the class instance
  /**
   * Factory metodu içinde bulunduğu sınıftan kalıtım alan diğer sınıflara yönlendirme yapıp türettiğiniz nesneyi o sınıflardan oluşturmanıza yarar.
   * Normalde kurucu metotlar geriye bir değer döndürmez. Factory kurucu metodumuz ise özel bir metottur ve geriye değer döndürür.
   */

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),);
  }
}
