
import 'package:get/get.dart';
import 'package:get_connect/models/usuario_model.dart';
import 'package:get_connect/repositories/usuario_repository.dart';

class HomeController extends GetxController
    with StateMixin<List<UsuarioModel>> {
  final UsuarioRepository _repository;

  HomeController({
    required UsuarioRepository repository,
  }) : _repository = repository;

//ciclo de vida quando a tela estiver pronta
  @override
  void onReady() {
    _listaGeral();
    super.onReady();
  }

  //BUSCAR DADOS
  Future<void> _listaGeral() async {
    try {
      change([], status: RxStatus.loading());

      final usuarios = await _repository.listaGeral();

      var statusReturn = RxStatus.success();

      if (usuarios.isEmpty) {
        statusReturn = RxStatus.empty();
      }

      change(usuarios, status: statusReturn);
    } catch (e, s) {
      print(e.toString());
      print(s.toString());
      // log('Erro ao buscar usuários', error: e, stackTrace: s);
      change(state, status: RxStatus.error());
    }
  }

  Future<void> registrar() async {
    try {
      final user = UsuarioModel(
        name: 'Wenderson Silva Jornada GetX',
        email: 'wenderson17@gmail.com',
        password: '123123',
      );
      await _repository.save(user);
      _listaGeral();
      Get.snackbar('Sucesso', 'Usuário registrado com sucesso');
    } catch (e, s) {
      // TODO
      print(e);
      print(s);
      // log('Erro ao salvar usuário', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao salvar usúario');
    }
  }

  Future<void> updateUsuario(UsuarioModel usuario) async {
    try {
      usuario.name = 'TESTE NOSSO';
      usuario.email = 'sifat@gmail.com';
      await _repository.updateUsuario(usuario);
      _listaGeral();
    } catch (e, s) {
      print(e);
      print(s);
      // log('Erro ao salvar usuário', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao atualizar o usúario');
    }
  }

  Future<void> delete(UsuarioModel usuario) async {
    await _repository.deleteUsuario(usuario);
    Get.snackbar('Sucesso', 'Usuário deletado com sucesso');
    _listaGeral();


  }
}
