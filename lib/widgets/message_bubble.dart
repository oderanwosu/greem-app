import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageBubble extends StatefulWidget {
  Message message;
  final bool showUsername;

  MessageBubble({required this.showUsername, required this.message});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
          widget.message.isFromUser ?? false ? 64.0 : 16.0,
          4,
          widget.message.isFromUser ?? false ? 16.0 : 64.0,
          4,
        ),
        child: Align(
          alignment: widget.message.isFromUser ?? false
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: widget.message.isFromUser ?? false
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              widget.showUsername
                  ? Text(
                      widget.message.sender?.username ?? '',
                      style: Theme.of(context).textTheme.caption,
                    )
                  : Container(),
              SizedBox(
                height: widget.showUsername ? 4 : 0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: widget.message.isFromUser ?? false
                      ? Colors.blue
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.message.body,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: widget.message.isFromUser ?? false
                            ? Colors.white
                            : Colors.black87),
                  ),
                ),
              ),
              // widget.showUsername
              //     ? Text(
              //         widget.message.timeSent,
              //         style: Theme.of(context).textTheme.caption,
              //       )
              //     : Container(),
            ],
          ),
        ));
  }
}
