import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isCurrentUser;
  MessageBubble({required this.text, required this.isCurrentUser});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
          widget.isCurrentUser ? 64.0 : 16.0,
          4,
          widget.isCurrentUser ? 16.0 : 64.0,
          4,
        ),
        child: Align(
          alignment: widget.isCurrentUser
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: widget.isCurrentUser ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color:
                        widget.isCurrentUser ? Colors.white : Colors.black87),
              ),
            ),
          ),
        ));
  }
}
