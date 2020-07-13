import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/calculator_basic_page/display.dart';
import 'package:salles_tools/src/views/calculator_basic_page/key-pad.dart';
import 'package:salles_tools/src/views/calculator_basic_page/key_controller.dart';
import 'package:salles_tools/src/views/calculator_basic_page/processor.dart';
import 'package:salles_tools/src/views/components/log.dart';

class CalculatorBasicScreen extends StatefulWidget {
  CalculatorBasicScreen({Key key}) : super(key: key);

  @override
  _CalculatorBasicScreenState createState() => _CalculatorBasicScreenState();
}

class _CalculatorBasicScreenState extends State<CalculatorBasicScreen> {

  String _output;

  @override
  void initState() {
    log.info("Init State");

    KeyController.listen((event) => Processor.process(event));
    Processor.listen((data) => setState(() { _output = data; }));
    Processor.refresh();
    super.initState();
  }

  @override
  void dispose() {
    KeyController.dispose();
    Processor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size screen = MediaQuery.of(context).size;
    double buttonSize = screen.width / 4;
    double displayHeight = screen.height - (buttonSize * 5) - (buttonSize);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        iconTheme: IconThemeData(
          color: HexColor('#C61818'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Display(
            value: _output,
            height: displayHeight,
          ),
          KeyPad(),
        ],
      ),
    );
  }
}
