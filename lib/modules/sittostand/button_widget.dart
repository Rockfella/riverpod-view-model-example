import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;

  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override 
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromRGBO(31, 92, 139, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16 )),
    onPressed: onClicked,
    child: Text(
      text, 
      style: const TextStyle(fontSize: 20
  ),),
  );
}