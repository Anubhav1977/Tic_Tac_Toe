// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<List<String>> gameBoard = [];
  String? currentPlayer;
  List<List<bool>> isTapped = [];
  late String winner;
  int xCtr = 0;
  int oCtr = 0;
  bool flag = false;

  /// Initializes the game board and sets the starting player.
  void initializeGame() {
    gameBoard = List.generate(3, (_) => List.filled(3, ""));
    isTapped = List.generate(3, (_) => List.filled(3, false));
    currentPlayer = '𒉽'; // X starts the game
  }

  /// Handles the tap event on a grid cell.
  void ontap(int row, int col) {
    if (gameBoard[row][col].isEmpty) {
      setState(() {
        flag = true;
        isTapped[row][col] = true;
        gameBoard[row][col] = currentPlayer!;
        // Switches to the next player.
        currentPlayer = (currentPlayer == '𒉽') ? '𒆸' : '𒉽';
      });
    }
  }

  /// Displays a dialog to show the result of the game.
  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.teal[50],
        title: Center(
          child: Text(
            "Game Over",
            style: TextStyle(
              color: Colors.teal,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: Text(
          winner == "Draw" ? "It's a Draw" : "The Winner is $winner !!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  // Resets the game board and winner after closing the dialog.
                  initializeGame();
                  winner = '';
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Play Again",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Checks the game board for a winner or a draw.
  String? checkWinner() {
    bool isDraw = true;
    // Checks if the game board is full to determine if it’s a draw.
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (gameBoard[i][j].isEmpty) {
          isDraw = false;
          break;
        }
      }
    }
    // Checks for winning conditions in rows and columns.
    for (int i = 0; i < 3; i++) {
      if (gameBoard[i][0] == gameBoard[i][1] &&
          gameBoard[i][0] == gameBoard[i][2] &&
          gameBoard[i][0].isNotEmpty) {
        return gameBoard[i][0];
      } else if (gameBoard[0][i] == gameBoard[1][i] &&
          gameBoard[0][i] == gameBoard[2][i] &&
          gameBoard[0][i].isNotEmpty) {
        return gameBoard[0][i];
      }
    }
    // Checks for winning conditions in diagonals.
    if (gameBoard[0][0] == gameBoard[1][1] &&
        gameBoard[0][0] == gameBoard[2][2] &&
        gameBoard[0][0].isNotEmpty) {
      return gameBoard[0][0];
    } else if (gameBoard[2][0] == gameBoard[1][1] &&
        gameBoard[2][0] == gameBoard[0][2] &&
        gameBoard[2][0].isNotEmpty) {
      return gameBoard[2][0];
    } else if (isDraw) {
      return "Draw";
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    // Initializes the game board when the widget is first created.
    initializeGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TIC TAC TOE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.teal[50],
        child: Column(
          children: [
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "𒉽 Wins: $xCtr",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "𒆸 Wins: $oCtr",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              "Current Player: $currentPlayer",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100),
            Container(
              height: 300,
              width: 300,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final row = (index ~/ 3);
                  final col = (index % 3);
                  return GestureDetector(
                    onTap: () {
                      // Handles the tap event and checks for the winner.
                      ontap(row, col);
                      winner = checkWinner() ?? '';
                      if (winner == '𒉽') {
                        xCtr++;
                      } else if (winner == '𒆸') {
                        oCtr++;
                      }
                      if (winner.isNotEmpty) {
                        showWinnerDialog(winner);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: isTapped[row][col]
                            ? Colors.greenAccent
                            : Colors.white,
                        border: Border.all(color: Colors.teal),
                      ),
                      child: Center(
                        child: Text(
                          gameBoard[row][col],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(200, 100, 40, 0),
              child: ElevatedButton(
                onPressed: () {
                  // Resets the game board when the button is pressed.
                  setState(() {
                    initializeGame();
                    winner = '';
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  backgroundColor: Colors.teal,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Reset Board",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
