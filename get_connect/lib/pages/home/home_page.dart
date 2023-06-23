import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_connect/pages/home/home_controller.dart';

class HomePage extends GetView<HomeController> {

  const HomePage({ Key? key }) : super(key: key);


   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('HOME PAGE '),),
           floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.registrar();
            },
            child: const Icon(Icons.add),
           ),
           body: controller.obx(
            (state){
              if(state == null) {
                return const Center(
                  child: Text('Nenhum usuário cadastrado'),
                );
              }
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  final user = state[index];
                  return ListTile(
                    onTap: () =>  controller.updateUsuario(user),
                    onLongPress: () => controller.delete(user),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              );
          
           },
           onEmpty: const Center(child: Text('Nenhum usuário cadastrado'),),
           onError: (error) => const Center(child: Text('Erro ao buscar usuários'),),
           ),
       );
  }
}