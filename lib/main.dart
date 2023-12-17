import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RoomSelectionScreen(),
    );
  }
}

class RoomSelectionScreen extends StatelessWidget {
  final List<String> fakeParticipants = ['Participant A', 'Participant B', 'Participant C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 300, // Adjust the height to fit your logo
            width: double.infinity, // Takes full width
            // Placeholder for your logo, you can replace this with your logo widget or Image.asset
            color: Colors.white,
            alignment: Alignment.center,
            child: Image.asset("assets/logo.png"
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateRoomScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50), // 버튼의 내부 여백 설정
                      textStyle: TextStyle(fontSize: 30), // 버튼 안의 텍스트 스타일 설정
                      minimumSize: Size(150, 50), // 최소 크기 설정
                    ),
                    child: Text('게임 만들기'),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JoinRoomScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50), // 버튼의 내부 여백 설정
                      textStyle: TextStyle(fontSize: 30), // 버튼 안의 텍스트 스타일 설정
                      minimumSize: Size(150, 50), // 최소 크기 설정
                    ),
                    child: Text('게임 참가'),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CreateRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> fakeParticipants = ['김서형', '유지원', '백이현', '최원용'];

    return Scaffold(
      appBar: AppBar(
        title: Text('게임 만들기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '방의 고유 코드: ABC123',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoomDetailsScreen(participantsList: fakeParticipants, winnersList: [])),
                );
              },
              child: Text('내부 인원 및 게임 선택'),
            ),
          ],
        ),
      ),
    );
  }
}

class JoinRoomScreen extends StatelessWidget {
  final List<String> fakeParticipants = ['Participant X', 'Participant Y', 'Participant Z'];
  late String roomCode; // Declare roomCode variable

  @override
  Widget build(BuildContext context) {
    // Rest of your code remains unchanged

    return Scaffold(
      appBar: AppBar(
        title: Text('Join Room'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '방 참가 코드를 입력해주세요',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                roomCode = value; // Assign the value to roomCode
              },
              decoration: InputDecoration(
                hintText: '방 코드를 입력하세요',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ensure roomCode has a value before proceeding
                if (roomCode.isNotEmpty) {
                  // Your logic for joining the room using roomCode
                  // For now, just navigate to RoomDetailsScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomDetailsScreen(participantsList: fakeParticipants, winnersList: []),
                    ),
                  );
                }
              },
              child: Text('참가'),
            ),
          ],
        ),
      ),
    );
  }
}


class RoomDetailsScreen extends StatelessWidget {
  final List<String> participantsList;
  final List<String> winnersList;

  RoomDetailsScreen({required this.participantsList, required this.winnersList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '현재 방 인원: ${participantsList.length}명',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Column(
              children: participantsList.map((participant) {
                int winningCount = winnersList.where((winner) => winner == participant).length;
                return Row(
                  children: [
                    Text(
                      participant,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '$winningCount 회 우승',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameSelectionScreen()),
                );
              },
              child: Text('게임 선택'),
            ),
          ],
        ),
      ),
    );
  }
}


class GameSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildGameButton(
              context,
              '랜덤 사칙연산 문제',
              '10문제 주고 가장 많이 해결한 사람이 이기는 게임',
              RandomArithmeticGame(),
            ),
            SizedBox(height: 20),
            buildGameButton(
              context,
              '터치 게임',
              '20초 동안 가장 많이 터치한 사람이 이기는 게임',
              TouchGameScreen(), // TouchGame으로 변경
            ),
            SizedBox(height: 20),
            buildGameButton(
              context,
              '랜덤 게임 1',
              '랜덤 게임 1',
              RandomGameOne(),
            ),
            SizedBox(height: 20),
            buildGameButton(
              context,
              '랜덤 게임 2',
              '랜덤 게임 2',
              RandomGameTwo(),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildGameButton(BuildContext context, String gameName, String description, Widget gameWidget) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => gameWidget),
        );
      },
      child: Text(gameName),
    );
  }
}

class TouchGameScreen extends StatefulWidget {
  @override
  _TouchGameState createState() => _TouchGameState();
}

class _TouchGameState extends State<TouchGameScreen> {
  int tapCount = 0;
  bool gameEnded = false;
  int durationInSeconds = 10; // 게임 지속 시간
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (durationInSeconds == 0) {
        endGame();
      } else {
        setState(() {
          durationInSeconds--;
        });
      }
    });
  }

  void endGame() {
    setState(() {
      gameEnded = true;
    });
    _timer.cancel();
    // 게임 종료 시 각 플레이어의 터치 횟수를 RoomDetailsScreen으로 전달
    Navigator.pop(context, tapCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Touch Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '남은 시간: $durationInSeconds 초',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '터치 횟수: $tapCount',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            if (!gameEnded)
              GestureDetector(
                onTap: () {
                  setState(() {#
                    tapCount++;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.blue,
                  child: Text(
                    '터치하세요!',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            if (gameEnded)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, tapCount);
                },
                child: Text('게임 종료!'),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}




class RandomArithmeticGame extends StatefulWidget {
  @override
  _RandomArithmeticGameState createState() => _RandomArithmeticGameState();
}

class _RandomArithmeticGameState extends State<RandomArithmeticGame> {
  late int num1, num2;
  late String operator;
  late int answer;
  late TextEditingController userInputController;
  late int timeLimit = 15;
  late int remainingTime = 15;
  late bool timerRunning = true;
  late bool gameOver = false;
  late int correctAnswers = 0;
  late bool canSubmit = true;
  List<String> winners = []; // 우승자 저장 리스트

  @override
  void initState() {
    super.initState();
    userInputController = TextEditingController();
    startTimer();
    generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Arithmetic Game'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '$num1 $operator $num2 = ?',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '남은 시간: $remainingTime 초',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: userInputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '답을 입력하세요',
                border: OutlineInputBorder(),
              ),
              enabled: canSubmit,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (canSubmit) {
                  checkAnswer();
                }
              },
              child: Text('확인'),
            ),
            if (gameOver)
              Column(
                children: [
                  Text(
                    '게임 종료! 정답 개수: $correctAnswers',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, winners); // 우승자 목록을 RoomDetailsScreen으로 전달
                    },
                    child: Text('RoomDetailsScreen으로 돌아가기'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!timerRunning || remainingTime == 0) {
        timer.cancel();
        setState(() {
          gameOver = true;
          canSubmit = false;
        });
      } else {
        setState(() {
          remainingTime--;
        });
      }
    });
  }

  void generateQuestion() {
    Random random = Random();
    num1 = random.nextInt(10) + 1;
    num2 = random.nextInt(10) + 1;
    List<String> operators = ['+', '-', '*', '/'];
    operator = operators[random.nextInt(operators.length)];
    switch (operator) {
      case '+':
        answer = num1 + num2;
        break;
      case '-':
        answer = num1 - num2;
        break;
      case '*':
        answer = num1 * num2;
        break;
      case '/':
        answer = (num1 / num2).round();
        break;
    }
  }

  void checkAnswer() {
    int userAnswer = int.tryParse(userInputController.text) ?? 0;

    if (userAnswer == answer) {
      setState(() {
        correctAnswers++;
      });
      generateQuestion();
      userInputController.clear();
    } else {
      showAlertDialog('틀렸습니다. 다시 시도하세요.');
    }

    if (gameOver) {
      // 우승자를 업데이트하고 RoomDetailsScreen으로 이동
      winners.add("Player 1"); // 실제 우승자의 이름 또는 ID로 변경해주세요.
    }
  }

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    userInputController.dispose();
    super.dispose();
  }
}


class RandomGameOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Game 1'),
      ),
      body: Center(
        child: Text('추가 랜덤 게임 1'),
      ),
    );
  }
}

class RandomGameTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Game 2'),
      ),
      body: Center(
        child: Text('추가 랜덤 게임 2'),
      ),
    );
  }
}
