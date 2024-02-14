import 'package:flutter/material.dart';

import 'package:world_time/services/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;
  final Function changeLocation;
  const LocationCard(
      {super.key, required this.location, required this.changeLocation});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeLocation(location);
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(location.flag),
              ),
              const SizedBox(width: 20),
              Text(
                location.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
