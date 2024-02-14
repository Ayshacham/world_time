import 'package:flutter/material.dart';

import 'package:world_time/services/location.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isLoading = true;
  DateTime time = DateTime.now();

  void fetchTime() async {
    WorldTime worldTime = WorldTime(url: 'Banjul');
    await worldTime.getTime();

    setState(() {
      time = worldTime.time;
      isLoading = false;
    });

    if (!mounted) return;

    if (!isLoading) {
      Navigator.pushNamed(context, '/home',
          arguments: Location(
              time: time,
              name: 'Banjul',
              flag: 'https://flagcdn.com/w320/gm.png'));
    }
  }

  @override
  void initState() {
    super.initState();

    fetchTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(
          backgroundColor: Colors.purple,
          color: Colors.purple[100],
        ),
      )),
    );
  }
}
