import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sigv4/sigv4.dart';

class BotService {
  String botName = "AsignarEspecialista";
  String kAccessKeyId = 'AKIA5NVUE4G6WSAPUZ4H';
  String kSecretAccessKey = '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';
  String botAlias = "Prod";
  String botAWSRegion = "us-east-1";

  String requestUrl = "";

  BotService() {
    requestUrl =
        "https://runtime.lex.$botAWSRegion.amazonaws.com/bot/$botName/alias/$botAlias/user/1234/text";
  }

  Future<Map<String, dynamic>> callBot(String message) async {
    var response;

    final Sigv4Client client = Sigv4Client(
      region: botAWSRegion,
      serviceName: 'lex',
      keyId: kAccessKeyId,
      accessKey: kSecretAccessKey,
    );

    final request = client.request(
      requestUrl,
      method: 'POST',
      body: jsonEncode({'inputText': message}),
    );

    response = await http.post(request.url,
        headers: request.headers, body: request.body);
    return jsonDecode(response.body.toString()) as Map<String, dynamic>;
  }
}
