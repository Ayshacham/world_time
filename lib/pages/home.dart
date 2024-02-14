import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:world_time/services/location.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Location location =
        ModalRoute.of(context)!.settings.arguments as Location;

    final DateTime date = location.time ?? DateTime.now();
    final String name = location.name;
    final String flag = location.flag;
    final String day = DateFormat('EEEE dd MMMM, yyyy').format(date);
    final String time = DateFormat('hh:mm').format(date);
    final String timeOfDay =
        DateFormat('a').format(date) == 'AM' ? 'night' : 'morning';

    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: [
              FilledButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/location');
                  },
                  icon: const Icon(
                    Icons.edit_location,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo[400])),
                  label: const Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(flag),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(name,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 20,
              ),
              Text(day),
              Text(time,
                  style: const TextStyle(
                      fontSize: 42, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/$timeOfDay.png',
                height: 350,
              )
            ],
          ),
        ),
      )),
    );
  }
}
