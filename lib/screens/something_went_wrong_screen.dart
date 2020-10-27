import 'package:flutter/material.dart';

class SomethingWentWrongScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Container(
        child: Center(
          child: Text('Ops, algo deu errado na aplicação.'),
        ),
      ),
    );
  }
}