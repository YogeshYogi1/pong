import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball(
      {Key? key,
      required this.ballX,
      required this.ballY,
      required this.isgamestarted})
      : super(key: key);
  final double ballX;
  final double ballY;
  final bool isgamestarted;

  @override
  Widget build(BuildContext context) {
    return isgamestarted
        ? Container(
            alignment: Alignment(ballX, ballY),
            child: Container(
              width: MediaQuery.of(context).size.width / 22,
              height: MediaQuery.of(context).size.width / 22,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          )
        : Container(
            alignment: Alignment(0, 0),
            child: AvatarGlow(
              glowColor: Colors.white,
              endRadius: 60,
              child: Container(
                width: MediaQuery.of(context).size.width / 22,
                height: MediaQuery.of(context).size.width / 22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}
