import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive._bloc.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_event.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_state.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_state.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/models/test_drive_model.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:select_dialog/select_dialog.dart';

import '../../bloc/dms_bloc/dms_event.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_preferences_helper.dart';
import '../components/log.dart';

class BookTestDriveAddView extends StatefulWidget {
  @override
  _BookTestDriveAddViewState createState() => _BookTestDriveAddViewState();
}

class _BookTestDriveAddViewState extends State<BookTestDriveAddView> {
  List<String> _listKendaraan = new List<String>();
  var _formKey = GlobalKey<FormState>();

//shared prefference var
  var _branchName;
  var _branchId;
  var _outletName;
  var _outletId;
//end of shared prefference var

// list car dms
  var itemCodeCtrl = new TextEditingController();
  var currentSelectPriceList;
  List<SelectorPriceListModel> priceList = [];

  var class1Ctrl = new TextEditingController();
  var currentSelectClass1;
  List<String> class1List = [];
// list car dms

  int convertDate;

//text editing controller init
  var customerNameCtrl = new TextEditingController();
  var customerContactCtrl = new TextEditingController();
  var branchNameCtrl = new TextEditingController();
  var outletNameCtrl = new TextEditingController();
  var dateSelected = new TextEditingController();
  var timeSelected = new TextEditingController();
  var notesCtrl = new TextEditingController();
//end of text editing controller init

  var costumerNameFocus = new FocusNode();
  var phoneNumberFocus = new FocusNode();
  var dateSelectedFocus = new FocusNode();
  var timeSelectedFocus = new FocusNode();

  final dateFormat = DateFormat("dd MMMM yyyy");
  final timeFormat = DateFormat("h:mm a");

  DateTime _dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

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
        convertDate = _dateTime.toUtc().millisecondsSinceEpoch;
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

  final modelItems = List.generate(
    50,
    (index) => TestDriveModel(
      // avatar: "https://i.imgur.com/lTy4hiN.jpg",
      // name: "Deivão $index",
      // id: "$index",
      // createdAt: DateTime.now(),
    ),
  );

  void _showListClass1() {
    SelectDialog.showModal<String>(
      context,
      label: "Class 1",
      selectedValue: currentSelectClass1,
      items: class1List,
      onChange: (String selected) {
        setState(() {    
          currentSelectClass1 = selected;
          class1Ctrl.text = selected;
        });
      },
    );
  }

  void _getSharedPrefferences() async {
    _branchName = await SharedPreferencesHelper.getSalesBrach();
    _branchId = await SharedPreferencesHelper.getSalesBrachId();

    _outletName = await SharedPreferencesHelper.getSalesOutlet();
    _outletId = await SharedPreferencesHelper.getSalesOutletId();

    setState(() {
      branchNameCtrl.text = _branchName;
      outletNameCtrl.text = _outletName;

      // branchNameCtrl.text = _branchId;
      // outletNameCtrl.text = _outletId;
    });
  }

  // void onSaveBooking() {
  //   if (_formKey.currentState.validate()) {
  //     print("data register book test drive");
  //     final dmsBloc = BlocProvider.of<DmsBloc>(context);
  //     dmsBloc.add(BookingTestDriveRegister(BookingTestDrivePost(
  //       customerName: customerNameCtrl.text,
  //       customerPhone: customerContactCtrl.text,
  //       branchCode: _branchId,
  //       outletCode: _outletId,
  //       notes: notesCtrl.text,
  //       carId: itemCodeCtrl.text,
  //       schedule: convertDate,
  //     )));
  //     print("schedule in milisecon => $convertDate");
  //     print(
  //         "data booking | ${customerNameCtrl.text} | ${customerContactCtrl.text} | $_branchId | $_outletId | ${notesCtrl.text} | ${itemCodeCtrl.text} | $convertDate");
  //   } else {
  //     log.warning("Please Complete Form!");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Add Book Test Drive",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: BlocListener<BookingDriveBloc, BookingDriveState>(
          listener: (context, state) {
            if (state is DmsLoading) {
              onLoading(context);
            }

            if (state is DmsDisposeLoading) {
              Navigator.of(context, rootNavigator: false).pop();
            }
            if (state is CarListSuccess) {
               state.value.data.forEach((f) {
                class1List.add(f.itemModel);
              });
            }
            if (state is RegisterBookingTestDriveSuccess) {
              log.info("Success Create Booking Test Drive");
              Alert(
                  context: context,
                  type: AlertType.success,
                  title: 'Success',
                  desc: "Created Booking Test Drive!",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context, true),
                      color: HexColor("#C61818"),
                    ),
                  ]).show();
            }
            if (state is RegisterBookingTestDriveError) {
              log.warning("Fail Create Booking Test Drive");
              Alert(
                  context: context,
                  type: AlertType.error,
                  title: 'Error',
                  desc: "Failed to Create Booking Test Drive!",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: HexColor("#C61818"),
                    ),
                  ]).show();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Customer Name (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formAddCustomer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Customer Contact (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formContact(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Branch (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formAddDealer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Outlet (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formAddOutlet(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Vehicle Name (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formAddVehicle(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Date (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formDatePicker(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Time (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formTimePicker(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Note (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formNote(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Container(
                    width: screenWidth(context),
                    child: RaisedButton(
                      onPressed: () {
                        // onSaveBooking();
                      },
                      child: Text(
                        "Save",
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
      ),
    );
  }

  Widget formAddCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        height: 30,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 2),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // contentPadding: EdgeInsets.only(bottom: 18),
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Input Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                focusNode: costumerNameFocus,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(costumerNameFocus);
                },
                controller: customerNameCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        height: 30,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.phone,
                color: Color(0xFF6991C7),
                size: 24.0,
              ),
              hintText: "Input Phone Number",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
            keyboardType: TextInputType.number,
            focusNode: phoneNumberFocus,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(phoneNumberFocus);
            },
            controller: customerContactCtrl,
          ),
        ),
      ),
    );
  }

  Widget formAddDealer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        height: 30,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 15,
            ),
          ],
        ),
        child: Center(
          child: Theme(
            data: ThemeData(hintColor: Colors.transparent),
            child: GestureDetector(
              onTap: () {
                //list dealer from api here
                print('Open dialog chose dealer from api');
              },
              child: AbsorbPointer(
                child: TextFormField(
                  readOnly: true,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.local_convenience_store,
                      color: Color(0xFF6991C7),
                      size: 24.0,
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF6991C7),
                      size: 24.0,
                    ),
                    hintText: "Select Dealer",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                  controller: branchNameCtrl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddOutlet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        height: 30,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 15,
            ),
          ],
        ),
        child: Center(
          child: Theme(
            data: ThemeData(hintColor: Colors.transparent),
            child: GestureDetector(
              onTap: () {
                //list dealer from api here
                print('Open dialog chose Outlet from api');
              },
              child: AbsorbPointer(
                child: TextFormField(
                  readOnly: true,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Color(0xFF6991C7),
                      size: 24.0,
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF6991C7),
                      size: 24.0,
                    ),
                    hintText: "Select Outlet",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                  controller: outletNameCtrl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddVehicle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        height: 30,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 15,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 2),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  //list vehicle name from api here
                  print('Open dialog chose vehicle name from api');
                  _showListClass1();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Select Vehicle Name",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: class1Ctrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        height: 30,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 15,
            ),
          ],
        ),
        child: Center(
          child: Theme(
            data: ThemeData(hintColor: Colors.transparent),
            child: GestureDetector(
              onTap: () {
                _selectedDate(context);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  readOnly: true,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: Color(0xFF6991C7),
                      size: 24.0,
                    ),
                    hintText: "Select Date",
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
    );
  }

  Widget formTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        height: 30,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 15,
            ),
          ],
        ),
        child: Center(
          child: Theme(
            data: ThemeData(hintColor: Colors.transparent),
            child: GestureDetector(
              onTap: () {
                _selectedTime(context);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  readOnly: true,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.access_time,
                      color: Color(0xFF6991C7),
                      size: 24.0,
                    ),
                    hintText: "Select Time",
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
    );
  }

  Widget formNote() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 2),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                maxLines: 7,
                //controller next here
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _getSharedPrefferences();

    final bookingDriveBloc = BlocProvider.of<BookingDriveBloc>(context);
    // dmsBloc.add(FetchClass1Item());
    bookingDriveBloc.add(FetchTestDriveCar());

    print(
        "============================= page add booking test drive =============================");
    super.initState();
  }
}
