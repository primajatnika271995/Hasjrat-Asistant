import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

enum TypeService { perbaikanUmum, serviceBerkala }

class BookServiceAddView extends StatefulWidget {
  @override
  _BookServiceAddViewState createState() => _BookServiceAddViewState();
}

class _BookServiceAddViewState extends State<BookServiceAddView> {
  final dateFormat = DateFormat("dd MMMM yyyy");
  final timeFormat = DateFormat("h:mm a");

  DateTime _dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  var dateSelected = new TextEditingController();
  var timeSelected = new TextEditingController();

  TypeService _typeService = TypeService.perbaikanUmum;

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _dateTime)
      setState(() {
        _dateTime = picked;
        dateSelected.value =
            TextEditingValue(text: dateFormat.format(picked).toString());
      });
  }

  Future<Null> _selectedTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (picked != null && picked != timeOfDay)
      setState(() {
        timeOfDay = picked;
        timeSelected.value = TextEditingValue(text: timeOfDay.format(context));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Add Book Service",
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
            formAddCustomer(),
            formAddVehicle(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Container(
                child: DottedBorder(
                  strokeWidth: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Text(
                          "Type Service",
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      radioButtonCategory(),
                    ],
                  ),
                ),
              ),
            ),
            formServiceBerkala(),
            formAddDealer(),
            formDatePicker(),
            formTimePicker(),
            formNote(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Container(
                width: screenWidth(context),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: HexColor('#C61818'),
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

  Widget formAddCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Customer',
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

  Widget radioButtonCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: Column(
        children: <Widget>[
          RadioListTile<TypeService>(
            value: TypeService.perbaikanUmum,
            onChanged: (TypeService val) {
              setState(() {
                _typeService = val;
              });
            },
            groupValue: _typeService,
            title: Text(
              "Perbaikan Umum",
              style: TextStyle(
                letterSpacing: 0.8,
                fontSize: 13,
              ),
            ),
            activeColor: HexColor('#C61818'),
          ),
          RadioListTile<TypeService>(
            value: TypeService.serviceBerkala,
            onChanged: (TypeService val) {
              setState(() {
                _typeService = val;
              });
            },
            groupValue: _typeService,
            title: Text(
              "Service Berkala",
              style: TextStyle(
                letterSpacing: 0.8,
                fontSize: 13,
              ),
            ),
            activeColor: HexColor('#C61818'),
          ),
        ],
      ),
    );
  }

  Widget formServiceBerkala() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Vehicle Name',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
          prefixIcon: Icon(Icons.access_time),
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

  Widget formAddDealer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Dealer Name',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
          prefixIcon: Icon(Icons.location_city),
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

  Widget formDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: GestureDetector(
        onTap: () {
          _selectedDate(context);
        },
        child: AbsorbPointer(
          child: TextField(
            controller: dateSelected,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              hintText: 'Select Date',
              errorText: 'Tanggal harus diisi',
              prefixIcon: Icon(Icons.calendar_today),
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
        ),
      ),
    );
  }

  Widget formTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: GestureDetector(
        onTap: () {
          _selectedTime(context);
        },
        child: AbsorbPointer(
          child: TextField(
            controller: timeSelected,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              hintText: 'Select Time',
              errorText: 'Waktu harus diisi',
              prefixIcon: Icon(Icons.access_time),
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
        ),
      ),
    );
  }

  Widget formNote() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Note',
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        maxLines: 4,
      ),
    );
  }
}
