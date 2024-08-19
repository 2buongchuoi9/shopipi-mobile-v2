import 'dart:convert';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService {
  WebSocketService._privateConstructor();

  static final WebSocketService _instance =
      WebSocketService._privateConstructor();

  factory WebSocketService() {
    return _instance;
  }

  late StompClient _client;
  bool _isConnected = false;

  StompClient get client => _client;

  void connect() {
    if (_isConnected) return;

    _client = StompClient(
      config: StompConfig(
        url: 'wss://be.shopipi.click/ws',
        onConnect: (frame) {
          print('Connected to WebSocket');
          _isConnected = true;
        },
        onWebSocketError: (error) => print('WebSocket Error: $error'),
        onStompError: (error) => print('STOMP Error: $error'),
        onDisconnect: (_) {
          print('Disconnected');
          _isConnected = false;
        },
        stompConnectHeaders: {'Authorization': 'Bearer myToken'},
        webSocketConnectHeaders: {'Authorization': 'Bearer myToken'},
      ),
    );

    _client.activate();
  }

  void disconnect() {
    if (_isConnected) {
      _client.deactivate();
    }
  }

  void sendMessage(String destination, Map<String, dynamic> message) {
    if (_isConnected) {
      _client.send(
        destination: destination,
        body: jsonEncode(message),
      );
    }
  }
}
