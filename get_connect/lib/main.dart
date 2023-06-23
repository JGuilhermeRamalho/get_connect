import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_connect/pages/home/home_controller.dart';
import 'package:get_connect/pages/home/home_page.dart';
import 'package:get_connect/repositories/usuario_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: HomePage(),
        getPages: [
          GetPage(
              name: '/',
              page: () => const HomePage(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => UsuarioRepository());
                Get.put(HomeController(repository: Get.find()));
              })),
        ]);
  }
}
