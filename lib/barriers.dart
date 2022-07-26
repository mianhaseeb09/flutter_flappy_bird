import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  const Barrier({Key? key, this.size}) : super(key: key);
  final size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(
            width: 10,
            color: Colors.yellow,
          ),
          borderRadius: BorderRadius.circular(15.0)),
    );
  }
}
