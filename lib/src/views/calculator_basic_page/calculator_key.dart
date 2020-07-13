import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/calculator_basic_page/key_controller.dart';
import 'package:salles_tools/src/views/calculator_basic_page/key_symbol.dart';

abstract class Keys {

  static KeySymbol clear = const KeySymbol('C');
  static KeySymbol sign = const KeySymbol('±');
  static KeySymbol percent = const KeySymbol('%');
  static KeySymbol divide = const KeySymbol('÷');
  static KeySymbol multiply = const KeySymbol('x');
  static KeySymbol subtract = const KeySymbol('-');
  static KeySymbol add = const KeySymbol('+');
  static KeySymbol equals = const KeySymbol('=');
  static KeySymbol decimal = const KeySymbol('.');

  static KeySymbol zero = const KeySymbol('0');
  static KeySymbol one = const KeySymbol('1');
  static KeySymbol two = const KeySymbol('2');
  static KeySymbol three = const KeySymbol('3');
  static KeySymbol four = const KeySymbol('4');
  static KeySymbol five = const KeySymbol('5');
  static KeySymbol six = const KeySymbol('6');
  static KeySymbol seven = const KeySymbol('7');
  static KeySymbol eight = const KeySymbol('8');
  static KeySymbol nine = const KeySymbol('9');
}

class CalculatorKey extends StatelessWidget {
  final KeySymbol symbol;
  CalculatorKey({ this.symbol });

  Color get color {
    switch (symbol.type) {
      case KeyType.FUNCTION:
        return Color.fromARGB(255, 96, 96, 96);
      case KeyType.OPERATOR:
        return Color.fromARGB(255, 32, 96, 128);
      case KeyType.INTEGER:
      default:
        return Color.fromARGB(255, 128, 128, 128);
    }
  }

  static dynamic _fire(CalculatorKey key) => KeyController.fire(KeyEvent(key));

  @override
  Widget build(BuildContext context) {

    double size = MediaQuery.of(context).size.width / 4;
    TextStyle style = Theme.of(context).textTheme.headline4.copyWith(color: Colors.white);

    return Container(
      width: (symbol == Keys.zero) ? (size * 2) : size,
      padding: EdgeInsets.all(2),
      height: size,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: (symbol == Keys.equals) ? HexColor('#C61818') : color,
        elevation: 4,
        child: Text(symbol.value, style: style),
        onPressed: () => _fire(this),
      ),
    );
  }
}
