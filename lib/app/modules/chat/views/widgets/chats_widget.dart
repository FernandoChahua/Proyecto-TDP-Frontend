import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_list_widget.dart';
import 'chat_page_mobile.dart';

class ChatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final idUser = Get.find<SessionController>().chatId.value;

    return ChannelListView(
      filter: Filter.in_('members', [idUser]),
      sort: const [SortOption('last_message_at')],
      pagination: const PaginationParams(limit: 20),
      channelWidget: const ChatPageMobile(),
    );
  }
}
