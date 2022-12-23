import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffd9d9d9),
        // image: DecorationImage(
        //   fit: BoxFit.cover,
        //   image: NetworkImage(
        //       'https://xsgames.co/randomusers/avatar.php?g=male'),
        // ),
      ),
    );
  }
}
