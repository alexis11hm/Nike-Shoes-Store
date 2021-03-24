import 'package:flutter/material.dart';

class ShoeSizeItem extends StatelessWidget {
  final String text;

  const ShoeSizeItem({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text('US $text',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
    );
  }
}
