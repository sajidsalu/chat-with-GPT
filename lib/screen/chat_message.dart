import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
class ChatMessage extends StatelessWidget {

  final String message;
  final String sender;

  const ChatMessage({Key? key, required this.message, required this.sender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(child: Text(sender[0]),),
        ),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sender, style: Theme.of(context).textTheme.titleSmall,),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(message, style: Theme.of(context).textTheme.labelMedium,),
            )
          ],
        ))
      ],
    ).p8();
  }
}
