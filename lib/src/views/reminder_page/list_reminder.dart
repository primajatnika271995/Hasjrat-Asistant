import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/models/reminder_sqlite_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/services/sqlite_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/reminder_page/add_reminder.dart';

class ReminderListView extends StatefulWidget {
  @override
  _ReminderListViewState createState() => _ReminderListViewState();
}

class _ReminderListViewState extends State<ReminderListView> {
  bool pendingIsExpanded = false;
  bool todayIsExpanded = true;
  bool tomorrowIsExpanded = false;
  bool upcomingIsExpanded = false;

  SqliteService _dbHelper = SqliteService();
  Future<List<ReminderSqlite>> pending;
  Future<List<ReminderSqlite>> today;
  Future<List<ReminderSqlite>> tomorrow;
  Future<List<ReminderSqlite>> upcoming;

  int selectionDataPending;
  int selectionDataToday;
  int selectionDataTomorrow;
  int selectionDataUpcoming;

  void _updateListView() {
    setState(() {
      pending = _dbHelper.getReminderPending();
      today = _dbHelper.getReminderToday();
      tomorrow = _dbHelper.getReminderTomorrow();
      upcoming = _dbHelper.getReminderUpcoming();
    });
  }

  void _setSelectedPending(int val) {
    setState(() {
      selectionDataPending = val;
    });
  }

  void _setSelectedToday(int val) {
    setState(() {
      selectionDataToday = val;
    });
  }

  void _setSelectedTomorrow(int val) {
    setState(() {
      selectionDataTomorrow = val;
    });
  }

  void _setSelectedUpcoming(int val) {
    setState(() {
      selectionDataUpcoming = val;
    });
  }

  void _onAddReminderNavigation() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => CustomerBloc(CustomerService()),
          child: ReminderAddView(),
        ),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _updateListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _updateListView();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Reminder",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ExpansionTile(
              title: Text(
                "Pending",
                style: TextStyle(
                  color: pendingIsExpanded ? HexColor('#E07B36') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.pendingIsExpanded = val);
              },
              children: <Widget>[
                FutureBuilder<List<ReminderSqlite>>(
                  future: pending,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.length >= 1) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return listDataPending(snapshot.data[index], index);
                        },
                      );
                    } else {
                      return Center(
                        child: Image.asset(
                          "assets/icons/empty_icon.png",
                          height: 100,
                          color: HexColor('#E07B36'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                "Today",
                style: TextStyle(
                  color: todayIsExpanded ? HexColor('#E07B36') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.todayIsExpanded = val);
              },
              initiallyExpanded: todayIsExpanded,
              children: <Widget>[
                FutureBuilder<List<ReminderSqlite>>(
                  future: today,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.length >= 1) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return listDataToday(snapshot.data[index], index);
                        },
                      );
                    } else {
                      return Center(
                        child: Image.asset(
                          "assets/icons/empty_icon.png",
                          height: 100,
                          color: HexColor('#E07B36'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                "Tomorrow",
                style: TextStyle(
                  color:
                      tomorrowIsExpanded ? HexColor('#E07B36') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.tomorrowIsExpanded = val);
              },
              children: <Widget>[
                FutureBuilder<List<ReminderSqlite>>(
                  future: tomorrow,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.length >= 1) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return listDataTomorrow(snapshot.data[index], index);
                        },
                      );
                    } else {
                      return Center(
                        child: Image.asset(
                          "assets/icons/empty_icon.png",
                          height: 100,
                          color: HexColor('#E07B36'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                "Upcoming",
                style: TextStyle(
                  color:
                      upcomingIsExpanded ? HexColor('#E07B36') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.upcomingIsExpanded = val);
              },
              children: <Widget>[
                FutureBuilder<List<ReminderSqlite>>(
                  future: upcoming,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.length >= 1) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return listDataUpcoming(snapshot.data[index], index);
                        },
                      );
                    } else {
                      return Center(
                        child: Image.asset(
                          "assets/icons/empty_icon.png",
                          height: 100,
                          color: HexColor('#E07B36'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onAddReminderNavigation();
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: HexColor('#E07B36'),
      ),
    );
  }

  Widget listDataPending(ReminderSqlite value, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: RadioListTile(
        value: index,
        groupValue: selectionDataPending,
        title: Text(
          '${value.taskDescription}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Row(
            children: <Widget>[
              Container(
                height: 18,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "${value.timeReminder}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 18,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    value.taskType == 'Call' ? Icons.call : Icons.person,
                    size: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        onChanged: (val) {
          _setSelectedTomorrow(val);
          print(value.id);
        },
        activeColor: HexColor('#E07B36'),
        selected: selectionDataPending == index,
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blueAccent,
          icon: Icons.edit,
          onTap: () async {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => ReminderAddView(
                  id: value.id,
                  taskType: value.taskType,
                  taskDescription: value.taskDescription,
                  dateReminder: value.dateReminder,
                  timeReminder: value.timeReminder,
                  notes: value.notes,
                ),
                transitionDuration: Duration(milliseconds: 150),
                transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            await _dbHelper.delete(value.id);
            _updateListView();
          },
        ),
      ],
    );
  }

  Widget listDataToday(ReminderSqlite value, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: RadioListTile(
        value: index,
        groupValue: selectionDataToday,
        title: Text(
          '${value.taskDescription}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Row(
            children: <Widget>[
              Container(
                height: 18,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "${value.timeReminder}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 18,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    value.taskType == 'Call' ? Icons.call : Icons.person,
                    size: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        onChanged: (val) {
          _setSelectedToday(val);
        },
        activeColor: HexColor('#E07B36'),
        selected: selectionDataToday == index,
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blueAccent,
          icon: Icons.edit,
          onTap: () async {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => ReminderAddView(
                  id: value.id,
                  taskType: value.taskType,
                  taskDescription: value.taskDescription,
                  dateReminder: value.dateReminder,
                  timeReminder: value.timeReminder,
                  notes: value.notes,
                ),
                transitionDuration: Duration(milliseconds: 150),
                transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        IconSlideAction(
          caption: 'Pending',
          color: HexColor('#E07B36'),
          icon: Icons.archive,
          onTap: () async {
            await _dbHelper.update(
              ReminderSqlite(
                value.taskType,
                value.taskDescription,
                'Prima Jatnika',
                value.dateReminder,
                value.timeReminder,
                value.notes,
                'Pending',
              ),
              value.id,
            );
            _updateListView();
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            await _dbHelper.delete(value.id);
            _updateListView();
          },
        ),
      ],
    );
  }

  Widget listDataTomorrow(ReminderSqlite value, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: RadioListTile(
        value: index,
        groupValue: selectionDataTomorrow,
        title: Text(
          '${value.taskDescription}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Row(
            children: <Widget>[
              Container(
                height: 18,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "${value.timeReminder}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 18,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    value.taskType == 'Call' ? Icons.call : Icons.person,
                    size: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        onChanged: (val) {
          _setSelectedTomorrow(val);
          print(value.id);
        },
        activeColor: HexColor('#E07B36'),
        selected: selectionDataTomorrow == index,
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blueAccent,
          icon: Icons.edit,
          onTap: () async {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => ReminderAddView(
                  id: value.id,
                  taskType: value.taskType,
                  taskDescription: value.taskDescription,
                  dateReminder: value.dateReminder,
                  timeReminder: value.timeReminder,
                  notes: value.notes,
                ),
                transitionDuration: Duration(milliseconds: 150),
                transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        IconSlideAction(
          caption: 'Pending',
          color: HexColor('#E07B36'),
          icon: Icons.archive,
          onTap: () async {
            await _dbHelper.update(
              ReminderSqlite(
                value.taskType,
                value.taskDescription,
                'Prima Jatnika',
                value.dateReminder,
                value.timeReminder,
                value.notes,
                'Pending',
              ),
              value.id,
            );
            _updateListView();
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            await _dbHelper.delete(value.id);
            _updateListView();
          },
        ),
      ],
    );
  }

  Widget listDataUpcoming(ReminderSqlite value, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: RadioListTile(
        value: index,
        groupValue: selectionDataUpcoming,
        title: Text(
          '${value.taskDescription}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Row(
            children: <Widget>[
              Container(
                height: 18,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "${value.timeReminder}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 18,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    value.taskType == 'Call' ? Icons.call : Icons.person,
                    size: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        onChanged: (val) {
          _setSelectedUpcoming(val);
        },
        activeColor: HexColor('#E07B36'),
        selected: selectionDataUpcoming == index,
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blueAccent,
          icon: Icons.edit,
          onTap: () async {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => ReminderAddView(
                  id: value.id,
                  taskType: value.taskType,
                  taskDescription: value.taskDescription,
                  dateReminder: value.dateReminder,
                  timeReminder: value.timeReminder,
                  notes: value.notes,
                ),
                transitionDuration: Duration(milliseconds: 150),
                transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        IconSlideAction(
          caption: 'Pending',
          color: HexColor('#E07B36'),
          icon: Icons.archive,
          onTap: () async {
            await _dbHelper.update(
              ReminderSqlite(
                value.taskType,
                value.taskDescription,
                'Prima Jatnika',
                value.dateReminder,
                value.timeReminder,
                value.notes,
                'Pending',
              ),
              value.id,
            );
            _updateListView();
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            await _dbHelper.delete(value.id);
            _updateListView();
          },
        ),
      ],
    );
  }
}
