import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final bool belongsToMe;
  final Key key;

  MessageBubble(
    this._message, {
    this.belongsToMe,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: phoneWidth * 0.7),
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          margin: EdgeInsets.only(
            left: 15,
            top: 2.5,
            bottom: 2.5,
          ),
          decoration: BoxDecoration(
            color:
                belongsToMe ? Theme.of(context).accentColor : Colors.grey[800],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            _message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        )
      ],
    );
  }
}
