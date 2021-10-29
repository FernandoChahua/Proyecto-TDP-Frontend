import 'package:ayuda_mujer/app/data/user.dart' as model;
import 'package:ayuda_mujer/app/modules/home/views/home_view.dart';
import 'package:ayuda_mujer/app/modules/perfil/controllers/perfil_controller.dart';

import 'package:ayuda_mujer/app/utils/stream_api.dart';
import 'package:ayuda_mujer/app/utils/widgets/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ParticipantsPage extends StatefulWidget {
  @override
  _ParticipantsPageState createState() => _ParticipantsPageState();
}

class _ParticipantsPageState extends State<ParticipantsPage> {
  Set<User>? selectedUserss = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: customAppBar(),
        body: UsersBloc(
          child: UserListView(
            onUserTap: (User user, _) async {
              final idParticipants = [user.id];
              await StreamChannelApi.createChannel(
                context,
                name:
                    "${user.name} - ${Get.find<PerfilController>().user["email"]}",
                idMembers: idParticipants,
              );

              Get.back();
            },
            filter: Filter.autoComplete('id', 'SP'),
            sort: const [
              SortOption(
                'isOnline',
                direction: 1,
              ),
              SortOption(
                'name',
                direction: 1,
              ),
            ],
            pagination: const PaginationParams(
              limit: 25,
            ),
          ),
        ),
      );
}
