import 'dart:async';
import 'dart:convert';

import 'package:greem/models/message.dart';
import 'package:greem/models/token.dart';
import 'package:greem/providers/auth_providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageWS {
  final String _baseWSUrl = 'ws://127.0.0.1:3000';
  Tokens tokens;
  Ref ref;
  Stream? stream;
  WebSocketChannel? channel;
  MessageWS({required this.tokens, required this.ref});

  connect() {
    try {
      var uri = Uri.parse(
          '$_baseWSUrl?&token=${ref.watch(tokensProvider).token ?? ''}');

      channel = WebSocketChannel.connect(uri);

      return stream;
    } catch (e) {
      rethrow;
    }
  }

  sendMessage(message) {
    channel!.sink.add(message);
  }
}
