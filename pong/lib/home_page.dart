import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong/ball.dart';
import 'package:pong/board.dart';
import 'package:pong/cover_screen.dart';
import 'package:pong/score_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  bool isgamestarted = false;
  int playerscore = 0;
  int enemyscore = 0;
  double brickrwidth = 0.4;
  double enemyX = -0.2;
  double ballX = 0;
  double ballY = 0;
  double playerx = 0;
  var ballYdirection = direction.DOWN;
  var ballXdirection = direction.LEFT;

  void startGame() {
    Timer.periodic(
      Duration(milliseconds: 1),
      (timer) {
        moveEnemy();
        isgamestarted = true;
        updateDirection();
        moveBall();
        if (isPlayerOut()) {
          enemyscore++;
          timer.cancel();
          _showDialog(false);
        }
        if (isEnemyOut()) {
          playerscore++;
          timer.cancel();
          _showDialog(true);
        }
      },
    );
  }

  bool isEnemyOut() {
    if (ballY <= -1) {
      return true;
    }
    return false;
  }

  void moveEnemy() {
    enemyX = ballX;
  }

  _showDialog(bool enenmydied) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                enenmydied ? 'P I N K   W I N' : 'P U R P L E   W I N',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: enenmydied
                          ? Colors.pink[100]
                          : Colors.deepPurple[100],
                      child: Text(
                        'P l a y  A g a i n',
                        style: TextStyle(
                            color: enenmydied
                                ? Colors.pink[800]
                                : Colors.deepPurple[800]),
                      ),
                    )),
              ),
            ],
          );
        });
  }

  bool isPlayerOut() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      isgamestarted = false;
      ballX = 0;
      ballY = 0;
      playerx = -0.2;
    });
  }

  void updateDirection() {
    //VERTICAL DIRECTION

    setState(
      () {
        if (ballY >= 0.9 &&
            playerx + brickrwidth >= ballX &&
            playerx <= ballX) {
          ballYdirection = direction.UP;
        } else if (ballY <= -0.9) {
          ballYdirection = direction.DOWN;
        }
        //HORIZONTAL DIRECTION
        if (ballX >= 1) {
          ballXdirection = direction.LEFT;
        } else if (ballX <= -1) {
          ballXdirection = direction.RIGHT;
        }
      },
    );
  }

  void moveBall() {
    setState(
      () {
        //VERTICAL MOVEMENT
        if (ballYdirection == direction.DOWN) {
          ballY += 0.01;
        } else if (ballYdirection == direction.UP) {
          ballY -= 0.01;
        }
        //HORIZONTAL DIRECTION
        if (ballXdirection == direction.LEFT) {
          ballX -= 0.01;
        } else if (ballXdirection == direction.RIGHT) {
          ballX += 0.01;
        }
      },
    );
  }

  void moveLeft() {
    setState(() {
      if (!(playerx - 0.1 <= -1)) {
        playerx -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerx + brickrwidth >= 1)) {
        playerx += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: () {
          startGame();
        },
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: Stack(
            children: [
              Board(
                boardX: enemyX,
                boardY: -0.97,
                brickwidth: brickrwidth,
                isenemy: true,
              ),
              Board(
                boardX: playerx,
                boardY: 0.97,
                brickwidth: brickrwidth,
                isenemy: false,
              ),
              Ball(
                ballX: ballX,
                ballY: ballY,
                isgamestarted: isgamestarted,
              ),
              CoverScreen(
                isgamestarted: isgamestarted,
              ),
              ScoreScreen(
                isgamestarted: isgamestarted,
                enemyscore: enemyscore.toString(),
                playerscore: playerscore.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
