import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({Key? key, required this.isgamestarted}) : super(key: key);
  final bool isgamestarted;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, -0.2),
      child: isgamestarted
          ? const Text('')
          : const Text(
              'T A P  T O  P L A Y',
              style: TextStyle(color: Colors.white60, fontSize: 18),
            ),
    );
  }
}
