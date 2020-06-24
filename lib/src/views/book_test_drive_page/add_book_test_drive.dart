import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_bloc.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_event.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_state.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/services/booking_drive_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';

class BookTestDriveAddView extends StatefulWidget {
  final String customerName;
  BookTestDriveAddView({this.customerName});

  @override
  _BookTestDriveAddViewState createState() => _BookTestDriveAddViewState();
}

class _BookTestDriveAddViewState extends State<BookTestDriveAddView> {
  var _formKey = GlobalKey<FormState>();

  var _branchName;
  var _branchId;
  var _outletName;
  var _outletId;

  var itemCodeCtrl = new TextEditingController();
  var currentSelectPriceList;
  List<SelectorPriceListModel> priceList = [];

  var vehicleCtrl = new TextEditingController();
  var currentSelectClass1;
  List<SelectorVehicleModel> vehicleList = [];

// list car dms

  int convertDate;
  int convertTime;
  int convertDateTime;

  var customerNameCtrl = new TextEditingController();
  var customerContactCtrl = new TextEditingController();
  var branchNameCtrl = new TextEditingController();
  var outletNameCtrl = new TextEditingController();
  var dateSelectedCtrl = new TextEditingController();
  var timeSelectedCtrl = new TextEditingController();
  var notesCtrl = new TextEditingController();

  var selectedCarId;

  var costumerNameFocus = new FocusNode();
  var phoneNumberFocus = new FocusNode();
  var dateSelectedFocus = new FocusNode();
  var timeSelectedFocus = new FocusNode();

  final dateFormat = DateFormat("dd MMMM yyyy");
  final dateFormatConvert = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("HH:mm:ss");

  DateTime _dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

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
        dateSelectedCtrl.value =
            TextEditingValue(text: dateFormat.format(picked).toString());
      });
  }

  Future<Null> _selectedTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
      initialTime: timeOfDay,
    );

    if (picked != null)
      setState(() {
        timeOfDay = picked;
        timeSelectedCtrl.value =
            TextEditingValue(text: timeOfDay.format(context));
      });
  }

  void _showListVehicle() {
    SelectDialog.showModal<SelectorVehicleModel>(
      context,
      label: "Item Code",
      selectedValue: currentSelectPriceList,
      items: vehicleList,
      showSearchBox: false,
      itemBuilder: (context, SelectorVehicleModel item, bool isSelected) {
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
            title: Text("${item.itemModel} ${item.itemType}"),
          ),
        );
      },
      onChange: (SelectorVehicleModel selected) {
        setState(() {
          currentSelectPriceList = selected;
          vehicleCtrl.text = selected.itemModel;
          selectedCarId = selected.id;
        });
      },
    );
  }

  void _getSharedPrefferences() async {
    _branchName = await SharedPreferencesHelper.getSalesBrach();
    _branchId = await SharedPreferencesHelper.getSalesBrachId();

    _outletName = await SharedPreferencesHelper.getSalesOutlet();
    _outletId = await SharedPreferencesHelper.getSalesOutletId();

    // ignore: close_sinks
    final bookingDriveBloc = BlocProvider.of<BookingDriveBloc>(context);
    bookingDriveBloc.add(FetchTestDriveCar(ListCarBookingPost(
      branchCode: _branchId,
      outletCode: _outletId,
    )));

    setState(() {
      branchNameCtrl.text = _branchName;
      outletNameCtrl.text = _outletName;
    });
  }

  void onSaveBooking() {
    DateTime date = DateFormat.Hm().parse(timeOfDay.format(context));
    log.info(DateFormat("HH:mm:ss").format(date));

    var dateAndTime =
        "${dateFormatConvert.format(_dateTime).toString()} ${DateFormat("HH:mm:ss").format(date)}";
    log.info("tanggal booking = $dateAndTime");
    DateTime parseDate = DateTime.parse(dateAndTime);
    log.info("konversi tanggal = ${parseDate.millisecondsSinceEpoch}");

    if (_formKey.currentState.validate()) {
      // ignore: close_sinks
      final dmsBloc = BlocProvider.of<BookingDriveBloc>(context);
      dmsBloc.add(BookingTestDriveRegister(BookingTestDrivePost(
        customerName: customerNameCtrl.text,
        customerPhone: customerContactCtrl.text,
        branchCode: _branchId,
        outletCode: _outletId,
        notes: notesCtrl.text,
        carId: selectedCarId,
        schedule: parseDate.millisecondsSinceEpoch,
      )));
    } else {
      log.warning("Please Complete Form!");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getSharedPrefferences();
    // ignore: close_sinks
    final bookingDriveBloc = BlocProvider.of<BookingDriveBloc>(context);
    bookingDriveBloc.add(FetchTestDriveCar(ListCarBookingPost(
      branchCode: _branchId,
      outletCode: _outletId,
    )));

    customerNameCtrl.text = widget.customerName;
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
          "Tambah Book Test Drive",
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
            if (state is BookingDriveLoading) {
              onLoading(context);
            }

            if (state is BookingDriveDisposeLoading) {
              Navigator.of(context, rootNavigator: false).pop();
            }

            if (state is CarListSuccess) {
              state.value.forEach((f) {
                if (f.enabled == true) {
                  vehicleList.add(SelectorVehicleModel(
                    itemModel: f.itemModel,
                    id: f.id,
                    itemType: f.itemType,
                  ));
                }
              });
            }

            if (state is RegisterBookingTestDriveSuccess) {
              log.info("Success Create Booking Test Drive");
              Alert(
                  context: context,
                  type: AlertType.success,
                  title: 'Berhasil',
                  desc: "Terima kasih telah melakukan Booking Test Drive!",
                  style: AlertStyle(
                    animationDuration: Duration(milliseconds: 500),
                    overlayColor: Colors.black54,
                    animationType: AnimationType.grow,
                  ),
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                        Navigator.pop(context, true);
                      },
                      color: HexColor("#C61818"),
                    ),
                  ]).show();
            }

            if (state is RegisterBookingTestDriveError) {
              log.warning("Fail Create Booking Test Drive");
              Alert(
                  context: context,
                  type: AlertType.error,
                  title: 'Gagal',
                  desc: "Silahkan cek kembali data yang dimasukan.",
                  style: AlertStyle(
                    animationDuration: Duration(milliseconds: 500),
                    overlayColor: Colors.black54,
                    animationType: AnimationType.grow,
                  ),
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
                    "Nama Pelanggan (*)",
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
                    "Nomer Telepon Pelanggan (*)",
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
                    "Nama Branch (*)",
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
                    "Nama Outlet (*)",
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
                    "Kendaraan (*)",
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
                    "Tanggal Booking (*)",
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
                    "Waktu Booking (*)",
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
                        onSaveBooking();
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 16),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Masukan Nama Pelanggan",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                focusNode: costumerNameFocus,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(phoneNumberFocus);
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
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 2),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 16),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Masukan Nomer Telepon",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                keyboardType: TextInputType.number,
                focusNode: phoneNumberFocus,
                controller: customerContactCtrl,
              ),
            ),
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
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 2),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {},
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 16),
                      border: InputBorder.none,
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.local_convenience_store,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Dealer",
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
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 2),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {},
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 16),
                      border: InputBorder.none,
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Outlet",
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
                  _showListVehicle();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 16),
                      border: InputBorder.none,
                      enabled: false,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Nama Kendaraan",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: vehicleCtrl,
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
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 2),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _selectedDate(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 16),
                      border: InputBorder.none,
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.date_range,
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
                    controller: dateSelectedCtrl,
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
            padding: EdgeInsets.only(left: 5, right: 2),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _selectedTime(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 16),
                      border: InputBorder.none,
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.access_time,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Waktu",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: timeSelectedCtrl,
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                maxLines: 7,
                controller: notesCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
