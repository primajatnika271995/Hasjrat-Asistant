import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class ProspectAddView extends StatefulWidget {
  @override
  _ProspectAddViewState createState() => _ProspectAddViewState();
}

class _ProspectAddViewState extends State<ProspectAddView> {
  ContextType _currentSelectContext;
  ColorData _currentSelectColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Add Prospect",
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
            dropdownMenu(),
            formNamaCusotmer(),
            formNIK(),
            formContact(),
            formEmail(),
            formAlamat(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Container(
                height: 180,
                width: screenWidth(context),
                child: DottedBorder(
                  strokeWidth: 1,
                  color: Colors.grey,
                  child: Center(
                    child: IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 45,
                        color: HexColor('#E07B36'),
                        onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            formSelectVehicle(),
            formSelectVehicleType(),
            dropdownMenuColor(),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
              child: Container(
                width: screenWidth(context),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("Create", style: TextStyle(color: Colors.white),),
                  color: HexColor('#E07B36'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              hintText: 'Context Type',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              errorText: 'Context Type harus diisi',
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ContextType>(
//                        value: _currentSelectTask,
                hint: Text('Context Type'),
                isDense: true,
                onChanged: (ContextType newVal) {
                  setState(() {
                    _currentSelectContext = newVal;
                    state.didChange(newVal.contextName);
                    print(_currentSelectContext.contextName);
                  });
                },
                items: ContextType.getTask().map((ContextType val) {
                  return DropdownMenuItem<ContextType>(
                    value: val,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(val.contextName),
                        Text("●", style: TextStyle(color: val.contextColor),),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget dropdownMenuColor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              hintText: 'Warna',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              errorText: 'Warna harus diisi',
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ColorData>(
//                        value: _currentSelectTask,
                hint: Text('Warna'),
                isDense: true,
                onChanged: (ColorData newVal) {
                  setState(() {
                    _currentSelectColor = newVal;
                    state.didChange(newVal.colorName);
                    print(_currentSelectColor.colorName);
                  });
                },
                items: ColorData.getColor().map((ColorData val) {
                  return DropdownMenuItem<ColorData>(
                    value: val,
                    child: Text(val.colorName),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget formNamaCusotmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Nama Customer',
          errorText: 'Nama customer harus diisi',
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
      ),
    );
  }

  Widget formNIK() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'NIK',
          errorText: 'NIK 16 character',
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
      ),
    );
  }

  Widget formContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'No. Telp',
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
      ),
    );
  }

  Widget formEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Email',
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
      ),
    );
  }

  Widget formAlamat() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Alamat',
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

  Widget formSelectVehicle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Vehicle',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
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

  Widget formSelectVehicleType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Vehicle Type',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
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
}

class ContextType {
  String contextName;
  Color contextColor;

  ContextType({this.contextName, this.contextColor});

  static List<ContextType> getTask() {
    return <ContextType>[
      ContextType(contextName: 'Context', contextColor: Colors.orangeAccent),
      ContextType(contextName: 'Prospect', contextColor: Colors.green),
      ContextType(contextName: 'Hot Prospect', contextColor: Colors.red),
    ];
  }
}

class ColorData {
  String colorName;

  ColorData({this.colorName});

  static List<ColorData> getColor() {
    return<ColorData>[
      ColorData(colorName: 'Merah'),
      ColorData(colorName: 'Hitam'),
      ColorData(colorName: 'Putih'),
    ];
  }
}
