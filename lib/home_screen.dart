import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_flappy_bird/barriers.dart';
import 'package:flutter_flappy_bird/bird.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;

  static double barrierXOne = 1;

  double barrierXTwo = barrierXOne + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic( const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });

      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3.5;
        } else {
          barrierXOne -= 0.05;
        }
      });
      setState(() {
        if (barrierXTwo < -2) {
          barrierXTwo +=3.5;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (gameHasStarted) {
            jump();
          } else {
            startGame();
          }
        },
      child:Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Stack(
                  children: <Widget>[
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: const Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: const MyBird(),
                    ),
                    Container(
                      alignment: const Alignment(
                        0,
                        -0.3,
                      ),
                      child: gameHasStarted
                          ? const Text("")
                          : const Text(
                              'T A P  T O  P L A Y ',
                              style:
                               TextStyle(fontSize: 20, color: Colors.white),
                            ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXOne, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const Barrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXOne, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const Barrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXTwo, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const Barrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXTwo, -1.1),
                      duration:const Duration(milliseconds: 0),
                      child: const Barrier(
                        size: 250.0,
                      ),
                    )
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          'Score',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                         SizedBox(
                          height: 20,
                        ),
                        Text(
                          '0',
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                         Text(
                          'Best',
                          style:  TextStyle(fontSize: 20, color: Colors.white),
                        ),
                         SizedBox(
                          height: 20,
                        ),
                         Text(
                          '10',
                          style:  TextStyle(fontSize: 35, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
      );

  }
}
