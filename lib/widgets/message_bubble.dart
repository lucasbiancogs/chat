import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final String userName;
  final bool belongsToMe;
  final bool isFirstMessage;
  final bool isLastMessage;
  final Key key;

  MessageBubble(
    this._message, {
    this.userName,
    this.belongsToMe,
    this.isFirstMessage,
    this.isLastMessage,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment:
          belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: phoneWidth * 0.7),
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          margin: EdgeInsets.only(
            left: belongsToMe ? 0 : 15,
            top: 2.5,
            bottom: 2.5,
            right: belongsToMe ? 15 : 0,
          ),
          decoration: BoxDecoration(
            color:
                belongsToMe ? Theme.of(context).accentColor : Colors.grey[800],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomRight: belongsToMe && isLastMessage ? Radius.circular(0) : Radius.circular(8),
              bottomLeft: !belongsToMe && isLastMessage ? Radius.circular(0) : Radius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFirstMessage)
                Text(
                  userName,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              Text(
                _message,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
