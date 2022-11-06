import 'package:flutter/material.dart';

class NewAndHotTileAction extends StatelessWidget {
  const NewAndHotTileAction(
      {super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 72.0, maxWidth: 72.0),
      child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
            child: Column(
              children: [
                Icon(icon),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 12.0),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )),
    );
  }
}
