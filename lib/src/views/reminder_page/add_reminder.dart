import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class ReminderAddView extends StatefulWidget {
  @override
  _ReminderAddViewState createState() => _ReminderAddViewState();
}

class _ReminderAddViewState extends State<ReminderAddView> {
  TaskType _currentSelectTask;

  final dateFormat = DateFormat("dd MMMM yyyy");
  final timeFormat = DateFormat("h:mm a");

  DateTime _dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  var dateSelected = new TextEditingController();
  var timeSelected = new TextEditingController();

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
        dateSelected.value = TextEditingValue(text: dateFormat.format(picked).toString());
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
          "Add Reminder",
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
            formTaskDescription(),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    color: HexColor('#E07B36'),
                  ),
                  Text("Add Customer"),
                ],
              ),
            ),
            formDatePicker(),
            formTimePicker(),
            formNote(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
              hintText: 'Task Type',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<TaskType>(
//                        value: _currentSelectTask,
                hint: Text('Task Type'),
                isDense: true,
                onChanged: (TaskType newVal) {
                  setState(() {
                    _currentSelectTask = newVal;
                    state.didChange(newVal.taskName);
                    print(_currentSelectTask.taskName);
                  });
                },
                items: TaskType.getTask().map((TaskType val) {
                  return DropdownMenuItem<TaskType>(
                    value: val,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(val.taskName),
                        Icon(val.taskIcon, color: HexColor('#E07B36'),),
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

  Widget formTaskDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Task Description',
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

class TaskType {
  String taskName;
  IconData taskIcon;

  TaskType({this.taskName, this.taskIcon});

  static List<TaskType> getTask() {
    return <TaskType>[
      TaskType(taskName: 'Call', taskIcon: Icons.phone),
      TaskType(taskName: 'Meet Up', taskIcon: Icons.person),
    ];
  }
}
