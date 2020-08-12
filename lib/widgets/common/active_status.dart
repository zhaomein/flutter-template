import 'package:flutter/material.dart';

class ActiveStatus extends StatelessWidget {
  final bool isOnline;
  final double size;

  const ActiveStatus(this.isOnline, {this.size = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            color: Colors.white,
            width: 2
        ),
        color: isOnline ? Colors.green : Colors.grey,
      ),
    );
  }
  
}