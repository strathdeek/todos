import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final ImageProvider image;
  const Avatar({
    required this.image,
    required this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: image,
            fit: BoxFit.fill,
          ),
          boxShadow: [
            BoxShadow(offset: Offset(-5, 5), blurRadius: 15, spreadRadius: -8)
          ]),
    );
  }
}
