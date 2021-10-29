import 'package:flutter/material.dart';

import 'participants_page.dart';

class ActiveUsersRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => buildCreateRoom(context);

  Widget buildCreateRoom(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParticipantsPage()),
        ),
        child: SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                radius: 25,
                child:
                    const Icon(Icons.video_call, size: 28, color: Colors.black),
              ),
              const Text(
                'Buscar\nEspecialista',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      );
}
