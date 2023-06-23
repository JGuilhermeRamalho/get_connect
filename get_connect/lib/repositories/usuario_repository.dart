import 'package:get/get.dart';
import 'package:get_connect/models/usuario_model.dart';

class UsuarioRepository {
  //TODO BUSCAR DADOS - GET
  final restClient = GetConnect();
  Future<List<UsuarioModel>> listaGeral() async {
    final resultado = await restClient.get('http://192.168.5.34:8080/users');

    if (resultado.hasError) {
      throw Exception('Erro ao buscar usuário(${resultado.statusText})');
    }
    return resultado.body
        .map<UsuarioModel>((usuario) => UsuarioModel.fromMap(usuario))
        .toList();
  }

  //TODO SALVAR DADOS, PRA ISSO ENVIO OS DADOS - POST
  Future<void> save(UsuarioModel usuario) async {
    final resultado = await restClient.post(
        'http://192.168.5.34:8080/users', usuario.toMap());
    if (resultado.hasError) {
      throw Exception('Erro ao salvar usuário(${resultado.statusText})');
    }
  }

//TODO DELETAR DADOS - DELETE
  Future<void> deleteUsuario(UsuarioModel usuario) async {
    final resultado = await restClient.delete(
      'http://192.168.5.34:8080/users/${usuario.id}',
    );
    if (resultado.hasError) {
      throw Exception('Erro ao deletar usuário(${resultado.statusText})');
    }
  }

  //TODO ATUALIZAR DADOS - PUT
  Future<void> updateUsuario(UsuarioModel usuario) async {
    final resultado = await restClient.put(
      'http://192.168.5.34:8080/users/${usuario.id}',
      usuario.toMap(),
    );
    if (resultado.hasError) {
      throw Exception('Erro ao atualizar usuário(${resultado.statusText})');
    }
  }
}
