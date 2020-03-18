import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(HexColor('#C61818')),
            ),
          ),
        ),
      ),
    );
  }
}