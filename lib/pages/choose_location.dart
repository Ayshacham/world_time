import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:world_time/services/location.dart';
import 'package:world_time/services/location_card.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List locations = [];
  bool loading = false;
  bool fetching = false;
  DateTime time = DateTime.now();

  Future<void> fetchLocations() async {
    var url = Uri.https('restcountries.com', '/v3.1/region/africa',
        {'fields': 'capital,flags'});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      setState(() {
        locations = data.take(15).toList();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    setState(() {
      loading = false;
    });
  }

  void changeLocation(Location location) async {
    setState(() {
      loading = true;
      fetching = true;
    });

    WorldTime worldTime = WorldTime(url: location.name);
    await worldTime.getTime();

    setState(() {
      time = worldTime.time;
      fetching = false;
      loading = false;
    });

    if (!mounted) return;

    if (!fetching) {
      location.time = time;

      Navigator.pushNamed(context, '/home', arguments: location);
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      loading = true;
    });

    fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose location",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: loading
          ? Center(
              child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                backgroundColor: Colors.purple,
                color: Colors.purple[100],
              ),
            ))
          : ListView(
              children: locations
                  .map((value) => LocationCard(
                      changeLocation: changeLocation,
                      location: Location(
                          flag: value['flags']['png'],
                          name: value['capital'][0] ?? ' ')))
                  .toList()),
    );
  }
}
