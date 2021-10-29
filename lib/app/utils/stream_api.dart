import 'package:ayuda_mujer/app/utils/constants/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'package:ayuda_mujer/app/data/user.dart' as model;

import 'controllers/session_controller.dart';

class StreamApi {
  static const apiKey = 'cserywmqxw78';
  static final client = StreamChatClient(apiKey, logLevel: Level.SEVERE);
}

class StreamChannelApi {
  static Future<Channel> createChannel(
    BuildContext context, {
    required String name,
    List<String> idMembers = const [],
  }) async {
    return createChannelWithUsers(
      context,
      name: name,
      idMembers: idMembers,
    );
  }

  static Future<Channel> createChannelWithUsers(
    BuildContext context, {
    required String name,
    List<String> idMembers = const [],
  }) async {
    final idSelfUser = Get.find<SessionController>().chatId.value;
    final id = "$idSelfUser-${idMembers[0]}";
    final channel = StreamApi.client.channel(
      'messaging',
      id: id,
      extraData: {
        'name': name,
        'image': ImageGeneratonr.getImage(id),
        'members': idMembers..add(idSelfUser),
      },
    );
    await channel.create();

    await channel.watch();
    return channel;
  }
}

class StreamUserApi {
  static Future<List<model.User>> getAllUsers({bool includeMe = false}) async {
    const sort = SortOption('last_message_at');
    final response = await StreamApi.client.queryUsers();

    final allUsers = response.users
        .map((user) => model.User(
              idUser: user.id,
              name: user.name,
              imageUrl: user.extraData['image'].toString(),
              isOnline: user.online,
            ))
        .toList();

    return allUsers;
  }

  static Future createUser({
    required String idUser,
    required String username,
    required String urlImage,
  }) async {
    final token = StreamApi.client.devToken(idUser);

    final user = User(
      id: idUser,
      extraData: {
        'name': username,
        'image': urlImage,
      },
    );
    await StreamApi.client.connectUser(user, token.rawValue);
  }

  static Future login({required String idUser}) async {
    final token = StreamApi.client.devToken(idUser);

    final user = User(id: idUser);
    await StreamApi.client.connectUser(user, token.rawValue);
  }
}
