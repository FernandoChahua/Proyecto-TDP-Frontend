import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatPageMobile extends StatelessWidget {
  const ChatPageMobile({Key? key}) : super(key: key);
  //final Channel channel;
  @override
  Widget build(BuildContext context) {
    /* return StreamChannel(
      channel: channel, */
    return Scaffold(
      appBar: const ChannelHeader(),
      body: Column(
        children: const [
          Expanded(child: MessageListView()),
          MessageInput(),
        ],
      ),
      //),
    );
  }
}
