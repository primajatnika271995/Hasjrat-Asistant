import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var dpVehicleCtrl = MoneyMaskedTextController(leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');

  double _lamaCicilan = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Calculator",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            formAddVehicle(),
            formAddVehicleType(),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(
                child: Text(
                  "Rp {?}",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            formDP(),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: Text(
                "Isi simulasi lama Cicilan",
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Slider(
                onChanged: (val) {
                  setState(() {
                    _lamaCicilan = val;
                  });
                },
                activeColor: HexColor('#E07B36'),
                inactiveColor: Colors.grey,
                max: 36.0,
                min: 1.0,
                divisions: 36,
                value: _lamaCicilan,
                label: _lamaCicilan.round().toString(),
              ),
            ),
            Center(
              child: Text(
                "${_lamaCicilan.round().toString()} bulan",
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Container(
                width: screenWidth(context),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Calculate",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: HexColor('#E07B36'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 5),
              child: Text(
                "Cicilan Bulan",
                style: TextStyle(
                  letterSpacing: 0.8,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 5),
              child: Text(
                "Rp {no data} / Bulan",
                style: TextStyle(
                  letterSpacing: 0.8,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formAddVehicle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Vehicle Name',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
          prefixIcon: Icon(Icons.time_to_leave),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        maxLines: null,
      ),
    );
  }

  Widget formAddVehicleType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Vehicle Type',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
          prefixIcon: Icon(Icons.time_to_leave),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        maxLines: null,
      ),
    );
  }

  Widget formDP() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Rp',
          labelText: 'Uang (DP)',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
            fontWeight: FontWeight.w400,
          ),
          hasFloatingPlaceholder: true,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
              width: 1,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
              width: 2,
            ),
          ),
        ),
        controller: dpVehicleCtrl,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
