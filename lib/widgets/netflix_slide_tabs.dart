import 'package:flutter/material.dart';

class NetflixSlideTabs extends StatelessWidget {
  NetflixSlideTabs({
    super.key,
  });

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            width: 100.0,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(32.0)),
          ),
          ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              TextButton(
                key: _globalKey,
                child: const Text('Coming Soon'),
                onPressed: () {},
              ),
              TextButton(
                child: const Text('Everyone\'s watching'),
                onPressed: () {},
              ),
              TextButton(
                child: const Text('Games'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
