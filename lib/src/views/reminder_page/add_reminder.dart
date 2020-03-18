import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_bloc.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_event.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_state.dart';
import 'package:salles_tools/src/models/reminder_sqlite_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/services/sqlite_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';

class ReminderAddView extends StatefulWidget {
  final int id;
  final String taskType;
  final String taskDescription;
  final String customerName;
  final String dateReminder;
  final String timeReminder;
  final String notes;

  ReminderAddView(
      {this.id,
      this.taskType,
      this.taskDescription,
      this.customerName,
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

  var dateSelectedFocus = new FocusNode();
  var timeSelectedFocus = new FocusNode();
  var noteFocus = new FocusNode();

  String _currentSelectTask;
  var _currentSelectLead;
  var _leadName;
  List<SelectorLeadModel> _leadList = [];

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100),
    );

    if (picked != null)
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

    if (picked != null)
      setState(() {
        timeOfDay = picked;
        timeSelected.value = TextEditingValue(text: timeOfDay.format(context));
      });
  }

  void _showListCustomer() {
    SelectDialog.showModal<SelectorLeadModel>(
      context,
      label: "Data Lead",
      selectedValue: _currentSelectLead,
      items: _leadList,
      itemBuilder: (context, SelectorLeadModel item, bool isSelected) {
        return Container(
          decoration: !isSelected
              ? null
              : BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: ListTile(
            selected: isSelected,
            title: Text(item.leadName),
            subtitle: Text("Contact : ${item.leadContact}"),
          ),
        );
      },
      onChange: (SelectorLeadModel selected) {
        setState(() {
          _currentSelectLead = selected;
          _leadName = selected.leadName;
        });
      },
    );
  }

  void _onCreateReminder() async {
    DateTime _now = DateTime.now();

    if (_currentSelectLead != null) {
      log.info(_now.difference(_dateTime).inDays);
      if (_now.difference(_dateTime).inDays <= -1) {
        await _dbHelper.insert(ReminderSqlite(
          _currentSelectTask,
          taskDescriptionCtrl.text,
          _currentSelectLead,
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
          _leadName,
          dateSelected.text,
          timeSelected.text,
          notesCtrl.text,
          'Now',
        ));
        Navigator.of(context).pop();
      }
    } else {
      log.warning("Customer Tidak Boleh Kosong");
    }
  }

  void _onUpdateReminder() async {
    await _dbHelper.update(
      ReminderSqlite(
        _currentSelectTask,
        taskDescriptionCtrl.text,
        _leadName,
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
    _leadName = widget.customerName;
    taskDescriptionCtrl.text = widget.taskDescription;
    dateSelected.text = widget.dateReminder;
    timeSelected.text = widget.timeReminder;
    notesCtrl.text = widget.notes;

    // ignore: close_sinks
    final leadBloc = BlocProvider.of<LeadBloc>(context);
    leadBloc.add(RefreshLead(LeadPost(
      leadName: "",
      leadCode: "",
    )));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: BlocListener<LeadBloc, LeadState>(
        listener: (context, state) {
          if (state is LeadSuccess) {
            state.leads.forEach((val) {
              _leadList.add(SelectorLeadModel(
                leadName: val.cardName,
                leadContact: val.phone1,
              ));
            });
          }

          if (state is LeadLoading) {
            onLoading(context);
          }

          if (state is LeadDisposeLoading) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context, rootNavigator: false).pop();
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _currentSelectLead == null ? SizedBox() :
              Container(
                height: 50,
                color: HexColor('#C61818'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Customer Name : ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "$_leadName",
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              dropdownMenu(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        _showListCustomer();
                      },
                      icon: Icon(Icons.add),
                      color: HexColor('#C61818'),
                    ),
                    Text("Add Customer"),
                  ],
                ),
              ),
              formTaskDescription(),
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
                          color: HexColor('#C61818'),
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
        textInputAction: TextInputAction.done,
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
            focusNode: dateSelectedFocus,
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
          FocusScope.of(context).requestFocus(noteFocus);
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
            focusNode: timeSelectedFocus,
          ),
        ),
      ),
    );
  }

  Widget formNote() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: TextField(
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'Note',
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        controller: notesCtrl,
        maxLines: 4,
        focusNode: noteFocus,
      ),
    );
  }
}
