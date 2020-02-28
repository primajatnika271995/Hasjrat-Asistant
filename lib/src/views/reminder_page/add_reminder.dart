import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/models/reminder_sqlite_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/services/sqlite_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';

class ReminderAddView extends StatefulWidget {
  final int id;
  final String taskType;
  final String taskDescription;
  final String dateReminder;
  final String timeReminder;
  final String notes;

  ReminderAddView(
      {this.id,
      this.taskType,
      this.taskDescription,
      this.dateReminder,
      this.timeReminder,
      this.notes});

  @override
  _ReminderAddViewState createState() => _ReminderAddViewState();
}

class _ReminderAddViewState extends State<ReminderAddView> {
  SqliteService _dbHelper = SqliteService();

  final dateFormat = DateFormat("dd MMMM yyyy");
  final timeFormat = DateFormat("h:mm a");

  DateTime _dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  var dateSelected = new TextEditingController();
  var timeSelected = new TextEditingController();
  var taskTypeCtrl = new TextEditingController();
  var taskDescriptionCtrl = new TextEditingController();
  var customerNameCtrl = new TextEditingController();
  var notesCtrl = new TextEditingController();

  String _currentSelectTask;
  String _currentSelectCustomer;
  List<String> _customerList;

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

  void _showListCustomer() {
    SelectDialog.showModal<String>(
      context,
      label: "Data Customer",
      selectedValue: _currentSelectCustomer,
      items: _customerList,
      onChange: (String selected) {
        setState(() {
          _currentSelectCustomer = selected;
        });
      },
    );
  }

  void _onCreateReminder() async {
    DateTime _now = DateTime.now();

    log.info(_now.difference(_dateTime).inDays);
    if (_now.difference(_dateTime).inDays <= -1) {
      await _dbHelper.insert(ReminderSqlite(
        _currentSelectTask,
        taskDescriptionCtrl.text,
        'Prima Jatnika',
        dateSelected.text,
        timeSelected.text,
        notesCtrl.text,
        'Upcoming',
      ));
      Navigator.of(context).pop();
    } else {
      await _dbHelper.insert(ReminderSqlite(
        _currentSelectTask,
        taskDescriptionCtrl.text,
        'Prima Jatnika',
        dateSelected.text,
        timeSelected.text,
        notesCtrl.text,
        'Now',
      ));
      Navigator.of(context).pop();
    }
  }

  void _onUpdateReminder() async {
    await _dbHelper.update(
      ReminderSqlite(
        _currentSelectTask,
        taskDescriptionCtrl.text,
        'Prima Jatnika',
        dateSelected.text,
        timeSelected.text,
        notesCtrl.text,
        'Now',
      ),
      widget.id,
    );
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    _currentSelectTask = widget.taskType;
    taskDescriptionCtrl.text = widget.taskDescription;
    dateSelected.text = widget.dateReminder;
    timeSelected.text = widget.timeReminder;
    notesCtrl.text = widget.notes;

    // ignore: close_sinks
    final customerBloc = BlocProvider.of<CustomerBloc>(context);
    customerBloc.add(FetchCustomer(CustomerPost(
      cardCode: "",
      cardName: "",
      custgroup: "",
    )));

    super.initState();
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
      body: BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomerSuccess) {
            _customerList.add(state.value.data[3].cardName);
            state.value.data.forEach((val) {
              log.info(val.cardName);
            });
          }
        },
        child: SingleChildScrollView(
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
                      onPressed: () {
                        _showListCustomer();
                      },
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
                    onPressed: () {
                      widget.id == null
                          ? _onCreateReminder()
                          : _onUpdateReminder();
                    },
                    child: Text(
                      widget.id == null ? "Create" : "Update",
                      style: TextStyle(color: Colors.white),
                    ),
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
              errorText: 'Task Type harus diisi',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentSelectTask,
                hint: Text('Task Type'),
                isDense: true,
                onChanged: (String newVal) {
                  setState(() {
                    _currentSelectTask = newVal;
                    state.didChange(newVal);
                  });
                },
                items: ['Call', 'Meet Up'].map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(val),
                        Icon(
                          val == 'Call' ? Icons.call : Icons.person,
                          color: HexColor('#E07B36'),
                        ),
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
          errorText: 'Task Description harus diisi',
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
        controller: taskDescriptionCtrl,
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
        controller: notesCtrl,
        maxLines: 4,
      ),
    );
  }
}

