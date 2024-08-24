import 'package:docs_clone/clients/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepository {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  void joinRoom(String documentId) {
    _socketClient.emit('join', documentId);
  }

  void typing(Map<String, dynamic> data) {
    _socketClient.emit('typing', data);
  }

  void changeListener(Function(Map<String, dynamic>) function) {
    _socketClient.on(
      'changes',
      (data) => function(data),
    );
  }

  void autosave(Map<String, dynamic> map) {
    _socketClient.emit('save', map);
  }
}
