class ReminderSqlite {
  int _id;
  String _taskType;
  String _taskDescription;
  String _customerName;
  String _dateReminder;
  String _timeReminder;
  String _notes;
  String _status;
  String _createdBy;

  ReminderSqlite(this._taskType, this._taskDescription, this._customerName, this._dateReminder, this._timeReminder, this._notes, this._status, this._createdBy);

  ReminderSqlite.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._taskType = map['task_type'];
    this._taskDescription = map['task_description'];
    this._customerName = map['customer_name'];
    this._dateReminder = map['date_reminder'];
    this._timeReminder = map['time_reminder'];
    this._notes = map['notes'];
    this._status = map['status'];
    this._createdBy = map['created_by'];
  }

  int get id => _id;
  String get taskType => _taskType;
  String get taskDescription => _taskDescription;
  String get customerName => _customerName;
  String get dateReminder => _dateReminder;
  String get timeReminder => _timeReminder;
  String get notes => _notes;
  String get status => _status;
  String get createdBy => _createdBy;

  set taskType(String value) {
    _taskType = value;
  }

  set taskDescription(String value) {
    _taskDescription = value;
  }

  set customerName(String value) {
    _customerName = value;
  }

  set dateReminder(String value) {
    _dateReminder = value;
  }

  set timeReminder(String value) {
    _timeReminder = value;
  }

  set notes(String value) {
    _notes = value;
  }

  set status(String value) {
    _status = value;
  }

  set createdBy(String value) {
    _createdBy = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['task_type'] = this._taskType;
    map['task_description'] = this._taskDescription;
    map['customer_name'] = this._customerName;
    map['date_reminder'] = this._dateReminder;
    map['time_reminder'] = this._timeReminder;
    map['notes'] = this._notes;
    map['status'] = this._status;
    map['created_by'] = this._createdBy;
    return map;
  }
}