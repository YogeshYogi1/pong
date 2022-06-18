import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final String playerscore;
  final String enemyscore;
  final bool isgamestarted;
  const ScoreScreen(
      {Key? key,
      required this.playerscore,
      required this.enemyscore,
      required this.isgamestarted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isgamestarted
        ? Stack(
            children: [
              Container(
                alignment: Alignment(0, 0),
                child: Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.grey[500],
                ),
              ),
              Container(
                alignment: Alignment(0, 0.25),
                child: Container(
                  child: Text(
                    playerscore,
                    style: TextStyle(color: Colors.grey[800], fontSize: 100),
                  ),
                ),
              ),
              Container(
                alignment: Alignment(0, -0.25),
                child: Container(
                  child: Text(
                    enemyscore,
                    style: TextStyle(color: Colors.grey[800], fontSize: 100),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
