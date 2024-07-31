import 'package:flutter/material.dart';
import 'dart:async';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {});
    });
  }

  void _startStopwatch() {
    _stopwatch.start();
    _startTimer();
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {});
  }

  String _formatTime(int milliseconds) {
    int hundredths = (milliseconds / 10).truncate();
    int seconds = (hundredths / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String hundredthsStr = (hundredths % 100).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr:$hundredthsStr";
  }

  @override
  Widget build(BuildContext context) {
    final String formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[900],
              ),
              padding: const EdgeInsets.all(20.0),
              child: Text(
                formattedTime,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                  child: Icon(
                    _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: _resetStopwatch,
                  child: const Icon(
                    Icons.stop,
                    color: Colors.white,
                  ),
                ),
              ],
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

void main() {
  runApp(const MaterialApp(
    home: First(),
  ));
}
