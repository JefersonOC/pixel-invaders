import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_invaders/more.dart';
import 'package:pixel_invaders/preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.grey[800]),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int alienStartPos = 22;
  static int spaceShipCenter = 464;
  static int numberOfSquares = 480;
  static int numberOfOneLineSquare = 20;

  static int playerMissileShot;
  static int alienMissileShot;

  static bool alienGotHit = false;
  static bool playerGotHit = false;
  static bool areGaming = false;

  static int score = 0;
  static int level = 0;

  List<int> spaceship = [];
  List<int> barriers = [];
  List<int> alien = [];

  var myGoogleFont = GoogleFonts.orbitron(
      textStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30));

  void startGame() {
    const durationFood = const Duration(milliseconds: 800);
    Timer.periodic(
      durationFood,
      (Timer timer) {
        if (!areGaming) {
          timer.cancel();
        }

        alienMoves();
      },
    );
  }

  void resetGame(level) {
    playerMissileShot = -1;
    alienMissileShot = numberOfSquares + 1;
    alien.clear();

    spaceship = [
      spaceShipCenter - numberOfOneLineSquare - 18,
      spaceShipCenter - 19,
      spaceShipCenter - 18,
      spaceShipCenter - 17,
    ];

    barriers = [
      numberOfSquares - 160 + 2,
      numberOfSquares - 160 + 3,
      numberOfSquares - 160 + 4,
      numberOfSquares - 160 + 5,
      numberOfSquares - 160 + 8,
      numberOfSquares - 160 + 9,
      numberOfSquares - 160 + 10,
      numberOfSquares - 160 + 11,
      numberOfSquares - 160 + 14,
      numberOfSquares - 160 + 15,
      numberOfSquares - 160 + 16,
      numberOfSquares - 160 + 17,
      numberOfSquares - 140 + 2,
      numberOfSquares - 140 + 3,
      numberOfSquares - 140 + 4,
      numberOfSquares - 140 + 5,
      numberOfSquares - 140 + 8,
      numberOfSquares - 140 + 9,
      numberOfSquares - 140 + 10,
      numberOfSquares - 140 + 11,
      numberOfSquares - 140 + 14,
      numberOfSquares - 140 + 15,
      numberOfSquares - 140 + 16,
      numberOfSquares - 140 + 17,
    ];

    if (level == 0) {
      var objW = [1, 2, 3, 4, 5, 6, 7, 8];
      var objH = [1, 2, 3, 4];
      for (var h in objH) {
        for (var w in objW) {
          alien.add(alienStartPos + (numberOfOneLineSquare * h) + w);
        }
      }
    }

    if (level == 1) {
      var objW = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      var objH = [1, 2, 3, 4, 5, 6];
      for (var h in objH) {
        for (var w in objW) {
          alien.add(alienStartPos + (numberOfOneLineSquare * h) + w);
        }
      }
    }

    if (level == 2) {
      var objW = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      var objH = [1, 2, 3, 4, 5, 6, 7, 8];
      for (var h in objH) {
        for (var w in objW) {
          alien.add(alienStartPos + (numberOfOneLineSquare * h) + w);
        }
      }
    }

    if (level >= 3) {
      var objW = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      var objH = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
      for (var h in objH) {
        for (var w in objW) {
          alien.add(alienStartPos + (numberOfOneLineSquare * h) + w);
        }
      }
    }
  }

  String direction = 'left'; // initial direction
  void alienMoves() {
    setState(() {
      if (alien.length > 0) {
        if ((alien.first - 1) % 20 == 0) {
          direction = 'right';
        } else if ((alien.last + 2) % 20 == 0) {
          direction = 'left';
        }

        if (direction == 'right') {
          for (int i = 0; i < alien.length; i++) {
            alien[i] += 1;
          }
        } else {
          for (int i = 0; i < alien.length; i++) {
            alien[i] -= 1;
          }
        }
      }
    });
  }

  void moveLeft() {
    setState(() {
      for (int i = 0; i < spaceship.length; i++) {
        spaceship[i] -= 1;
      }
    });
  }

  void moveRight() {
    setState(() {
      for (int i = 0; i < spaceship.length; i++) {
        spaceship[i] += 1;
      }
    });
  }

  void updateDamage() {
    setState(() {
      if (alien.contains(playerMissileShot)) {
        alien.remove(playerMissileShot);
        playerMissileShot = -1;
        alienGotHit = true;
        score += 20;
      }

      if (spaceship.contains(alienMissileShot)) {
        spaceship.remove(alienMissileShot);
        alienMissileShot = alien.first;
        playerGotHit = true;
        score += -1;
      }

      if (barriers.contains(alienMissileShot)) {
        barriers.remove(alienMissileShot);
        alienMissileShot = alien.first;
        score += -1;
      }

      if (playerMissileShot == alienMissileShot) {
        playerMissileShot = -1;
        alienMissileShot = alien.first;
      }

      if (barriers.contains(playerMissileShot)) {
        barriers.remove(playerMissileShot);
        playerMissileShot = -1;
        score += -1;
      }
    });
  }

  void fireMissile() {
    playerMissileShot = spaceship.first;
    alienGotHit = false;
    const durationMissile = const Duration(milliseconds: 100);
    Timer.periodic(
      durationMissile,
      (Timer timer) {
        playerMissileShot -= 20;
        updateDamage();
        if (alienGotHit || playerMissileShot < 1) {
          timer.cancel();
        }
      },
    );
  }

  bool timeForNextShot = false;
  void updateAlienMissile() {
    setState(() {
      alienMissileShot += 20;
      if (alienMissileShot > numberOfSquares) {
        timeForNextShot = true;
      }
    });
  }

  bool alienGunAtBack = true;
  void alienMissile() {
    alienMissileShot = alien.last;
    alienGunAtBack = !alienGunAtBack;

    if (alienGunAtBack) {
      alienMissileShot = alien.last;
    } else {
      alienMissileShot = alien.first;
    }

    const durationMissile = const Duration(milliseconds: 50);
    Timer.periodic(
      durationMissile,
      (Timer timer) {
        updateAlienMissile();
        updateDamage();

        // verify game over
        if (alien.length < 1 || spaceship.length < 1) {
          timer.cancel();

          if (score < 0) {
            score = 0;
            AppPreferences.saveHighScoreKey(score);
          } else {
            AppPreferences.getHighScoreKey().then((value) {
              if (value == null) {
                AppPreferences.saveHighScoreKey(score);
              }

              if (value < score) {
                AppPreferences.saveHighScoreKey(score);
              }
            });
          }

          if (spaceship.length < 1) {
            _showGameOverScreen('Game Over', level);
            level = 0;
          } else if (alien.length < 1) {
            _showGameOverScreen('Win!', level += 1);
          }
        }

        if (timeForNextShot) {
          alienMissileShot = alien.last;
          timeForNextShot = false;
        }
      },
    );
  }

  void _showGameOverScreen(msg, level) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              msg,
              style: myGoogleFont.copyWith(color: Colors.green),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(),
                Text(
                  'Level: ' + level.toString(),
                  style: myGoogleFont.copyWith(color: Colors.black),
                ),
                Divider(),
                Text(
                  'Score: ' + score.toString(),
                  style: myGoogleFont.copyWith(color: Colors.black),
                ),
                Divider(),
                Icon(
                  FontAwesomeIcons.userAstronaut,
                  size: 128.0,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Nice!',
                  style: myGoogleFont.copyWith(color: Colors.green),
                ),
                onPressed: () {
                  areGaming = false;
                  resetGame(level);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    resetGame(level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Pixel Invaders', style: myGoogleFont),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MorePage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Container(
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: numberOfSquares,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 20),
                        itemBuilder: (BuildContext context, int index) {
                          if (spaceship.length > 0 &&
                              (playerMissileShot == index ||
                                  spaceship.first == index)) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(color: Colors.red)),
                            );
                          } else if (spaceship.contains(index)) {
                            return Center(
                              child: Container(
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else if (barriers.contains(index)) {
                            return Center(
                              child: Container(
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            );
                          }

                          if (alien.contains(index) ||
                              alienMissileShot == index) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(color: Colors.green)),
                            );
                          } else {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(color: Colors.grey[900])),
                            );
                          }
                        }),
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                height: 82.0,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                            onTap: moveLeft,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.grey[800],
                                child: Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        GestureDetector(
                          onTap: moveRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.grey[800],
                              child: Icon(
                                FontAwesomeIcons.arrowRight,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 96.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!areGaming) {
                              alienMissile();
                              startGame();
                              areGaming = true;
                            }

                            if (playerMissileShot < 1) {
                              fireMissile();
                              HapticFeedback.vibrate();
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.grey[800],
                              child: Icon(
                                FontAwesomeIcons.solidDotCircle,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
