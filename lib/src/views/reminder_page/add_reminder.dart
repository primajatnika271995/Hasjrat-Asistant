import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
        this.notes,
      });

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
  List<String> _taskList = ["Call", "Meet Up"];

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
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
      context: context,
      initialTime: timeOfDay,
    );

    if (picked != null)
      setState(() {
        timeOfDay = picked;
        timeSelected.value = TextEditingValue(text: timeOfDay.format(context));
      });
  }

  void _showListTask() {
    SelectDialog.showModal<String>(
      context,
      label: "Task Type",
      selectedValue: _currentSelectTask,
      items: _taskList,
      itemBuilder: (context, String item, bool isSelected) {
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
            title: Text(item),
            trailing: Icon(item == "Call" ? Icons.call : Icons.people),
          ),
        );
      },
      onChange: (String selected) {
        setState(() {
          _currentSelectTask = selected;
          taskTypeCtrl.text = selected;
        });
      },
    );
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Task Type (*)",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Task Title (*)",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              formTaskDescription(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Date (*)",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              formDatePicker(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Time (*)",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              formTimePicker(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Note (*)",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              formNote(),
              SizedBox(height: 10),
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
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _showListTask();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 18),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Select Task Type",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: taskTypeCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formTaskDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 17),
                  prefixIcon: Icon(
                    Icons.title,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Task Title",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: taskDescriptionCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _selectedDate(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 18),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Tanggal",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: dateSelected,
                    focusNode: dateSelectedFocus,
                  ),
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
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _selectedTime(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 18),
                      prefixIcon: Icon(
                        Icons.access_time,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Jam",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: timeSelected,
                    focusNode: timeSelectedFocus,
                  ),
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
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Notes",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: notesCtrl,
                maxLines: 6,
                focusNode: noteFocus,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
