import 'package:dotted_border/dotted_border.dart';
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

enum TypeService { perbaikanUmum, serviceBerkala }

class BookServiceAddView extends StatefulWidget {
  final String customerName;
  BookServiceAddView({this.customerName});

  @override
  _BookServiceAddViewState createState() => _BookServiceAddViewState();
}

class _BookServiceAddViewState extends State<BookServiceAddView> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentStep = 0;
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("Hms");

  DateTime _dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  var customerNameCtrl = new TextEditingController();
  var vehicleNumberCtrl = new TextEditingController();
  var customerContactCtrl = new TextEditingController();
  var customerEmailCtrl = new TextEditingController();
  var dealerNameCtrl = new TextEditingController();
  var dealerAddressCtrl = new TextEditingController();
  var dealerEmailCtrl = new TextEditingController();
  var salesEmailCtrl = new TextEditingController();
  var kepalaBengkelEmailCtrl = new TextEditingController();
  var dateSelected = new TextEditingController();
  var timeSelected = new TextEditingController();
  var servicePeriodeTypeCtrl = new TextEditingController();
  var serviceBerkalaCtrl = new TextEditingController();

  var customerNameFocus = new FocusNode();
  var vehicleNumberFocus = new FocusNode();
  var customerContactFocus = new FocusNode();
  var customerEmailFocus = new FocusNode();
  var dealerAddressFocus = new FocusNode();

  var currentSelectStation;
  List<SelectorStation> _stationList = [];

  var currentSelectTypeService = "Perbaikan Umum";

  var currentSelectBookCategory = "On Call In (BS)";
  var bookingCategoryCtrl = new TextEditingController();
  List<String> bookCategoryList = [
    "On Call In (BS)",
    "On Call Out (BS)",
    "On Call In (THS)",
    "On Call Out (THS)",
    "HA Care",
    "Walk In",
  ];

  double _servicePriodeMonth = 6.0;

  var _currentSelectServicePeriodeType;
  List<String> _servicePeriodeType = [
    "Berdasarkan Jarak (KM)",
    "Berdasarkan Waktu (bulan)"
  ];

  var _currentSelectServiceBerkala;
  List<String> _serviceBerkalaList = [];

  TypeService _typeService = TypeService.perbaikanUmum;

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
        DateTime date = DateFormat.Hm().parse(timeOfDay.format(context));
        timeSelected.value = TextEditingValue(text: timeFormat.format(date));
      });
  }

  void _showListServicePeriodeType() {
    SelectDialog.showModal<String>(
      context,
      label: "Tipe Service Periode",
      selectedValue: _currentSelectServicePeriodeType,
      items: _servicePeriodeType,
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
          ),
        );
      },
      onChange: (String selected) {
        setState(() {
          _currentSelectServicePeriodeType = selected;
          servicePeriodeTypeCtrl.text = selected;
        });
      },
    );
  }

  void _showListServiceBerkala() {
    SelectDialog.showModal<String>(
      context,
      label: "Service Berkala",
      selectedValue: _currentSelectServiceBerkala,
      items: _serviceBerkalaList,
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
          ),
        );
      },
      onChange: (String selected) {
        setState(() {
          _currentSelectServiceBerkala = selected;
          serviceBerkalaCtrl.text = selected;
        });
      },
    );
  }

  void _showListStation() {
    SelectDialog.showModal<SelectorStation>(
      context,
      label: "List Bengkel",
      selectedValue: currentSelectStation,
      items: _stationList,
      onChange: (SelectorStation selected) {
        setState(() {
          currentSelectStation = selected;
          dealerNameCtrl.text = selected.name;
          dealerAddressCtrl.text = selected.address;
          dealerEmailCtrl.text = selected.email;
          kepalaBengkelEmailCtrl.text = selected.emailKabeng;
        });
      },
    );
  }

  void _showListBookCategory() {
    SelectDialog.showModal<String>(
      context,
      label: "Kategori Booking",
      selectedValue: currentSelectBookCategory,
      items: bookCategoryList,
      onChange: (String selected) {
        setState(() {
          currentSelectBookCategory = selected;
          bookingCategoryCtrl.text = selected;
        });
      },
    );
  }

  void createBokingService() async {
    var salesName = await SharedPreferencesHelper.getSalesName();

    if (dateSelected.text.isEmpty || timeSelected.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Hari dan Tanggal Wajib diisi"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    if (dealerEmailCtrl.text.isEmpty ||
        dealerNameCtrl.text.isEmpty ||
        dealerAddressCtrl.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Identitas Bengkel Tidak Lengkap"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    // ignore: close_sinks
    final bookingDriveBloc = BlocProvider.of<BookingDriveBloc>(context);
    bookingDriveBloc.add(AddBookingServiceViaEmail(
      BookingServicePost(
          customerName: customerNameCtrl.text,
          customerEmail: customerEmailCtrl.text,
          customerPhone: customerContactCtrl.text,
          bookingTypeName: currentSelectTypeService,
          bookingDate: dateSelected.text,
          bookingTime: timeSelected.text,
          dealerAddress: dealerAddressCtrl.text,
          dealerEmail: dealerEmailCtrl.text,
          dealerName: dealerNameCtrl.text,
          periodService:
              servicePeriodeTypeCtrl.text == "Berdasarkan Waktu (bulan)"
                  ? _servicePriodeMonth.toString() + " bulan"
                  : _currentSelectServiceBerkala,
          serviceCategoryName: currentSelectBookCategory,
          vehicleNumber: vehicleNumberCtrl.text,
          salesName: salesName,
          salesEmail: salesEmailCtrl.text,
          kabengEmail: kepalaBengkelEmailCtrl.text),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final bookingDriveBloc = BlocProvider.of<BookingDriveBloc>(context);
    bookingDriveBloc.add(FetchStation());

    for (var data, i = 1; i < 36; i++) {
      setState(() {
        _serviceBerkalaList.add("SB $i");
      });
    }

    bookingCategoryCtrl.text = "On Call In (BS)";
    servicePeriodeTypeCtrl.text = "Berdasarkan Waktu (bulan)";
    customerNameCtrl.text = widget.customerName;
    super.initState();
  }

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor("#C61818"),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Tambah Booking Service",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<BookingDriveBloc, BookingDriveState>(
        listener: (context, state) {
          if (state is BookingDriveLoading) {
            onLoading(context);
          }

          if (state is BookingDriveDisposeLoading) {
            Navigator.of(context, rootNavigator: false).pop();
          }

          if (state is StationListSuccess) {
            state.value.forEach((f) {
              _stationList.add(SelectorStation(
                name: f.name,
                address: f.address,
                email: f.email,
                emailKabeng: f.emailKabeng,
              ));
            });
          }

          if (state is AddBookingServiceVieEmailSuccess) {
            log.info("Success Create Booking Service");
            Alert(
                context: context,
                type: AlertType.success,
                title: 'Berhasil',
                desc:
                    "Terima Kasih telah melakukan Booking Service, data telah dikimkan ke Email Bengkel!",
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

          if (state is AddBookingServiceVieEmailError) {
            log.warning("Fail Create Booking Service");
            Alert(
                context: context,
                type: AlertType.error,
                title: 'Gagal membuat Pemesanan',
                desc: "Silahkan cek data yang dimasukan.",
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
        child: Stack(
          children: <Widget>[
            Theme(
              data: ThemeData(
                canvasColor: HexColor("#C61818"),
              ),
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep >= 2) return;
                  setState(() {
                    _currentStep += 1;
                  });
                },
                onStepCancel: () {
                  if (_currentStep <= 0) return;
                  setState(() {
                    _currentStep -= 1;
                  });
                },
                onStepTapped: (int index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                controlsBuilder: _createEventControlBuilder,
                steps: [
                  Step(
                    title: Text(
                      "Pelanggan",
                      style: TextStyle(color: Colors.white),
                    ),
                    isActive: _currentStep == 0 ? true : false,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nama Pelanggan (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formAddCustomer(),
                        Text(
                          "Nomor Plat (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formAddVehicleNumber(),
                        Text(
                          "Nomor Telepon Pelanggan (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formAddContactCustomer(),
                        Text(
                          "Email Pelanggan (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formAddEmailCustomer(),
                        Text(
                          "Tanggal Service (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formDatePicker(),
                        Text(
                          "Waktu Service (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formTimePicker(),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: Text(
                      "Service",
                      style: TextStyle(color: Colors.white),
                    ),
                    isActive: _currentStep == 1 ? true : false,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Pilih Tipe Service (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
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
                        currentSelectTypeService != "Perbaikan Umum"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Text(
                                    "Tipe Service Periode (*)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  formSelectServicePeriodeType(),
                                  SizedBox(height: 10),
                                  Text(
                                    "Service Periode (*)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  servicePeriodeTypeCtrl.text ==
                                          "Berdasarkan Waktu (bulan)"
                                      ? sliderPriodeServiceMonth()
                                      : formAddServiceBerkala(),
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Kategori Booking (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formAddBookCategori(),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: Text(
                      "Bengkel",
                      style: TextStyle(color: Colors.white),
                    ),
                    isActive: _currentStep == 2 ? true : false,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nama Bengkel (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formAddDealer(),
                        currentSelectStation != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Alamat Bengkel",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  formAddDealerAddress(),
                                  Text(
                                    "Email Bengkel",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  formAddDealerMail(),
                                  Text(
                                    "Email Sales",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  formAddSalesEmail(),
                                  Text(
                                    "Email Ka. Bengkel",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  formAddKepalaBengkel(),
                                ],
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Container(
                            width: screenWidth(context),
                            child: RaisedButton(
                              onPressed: () {
                                createBokingService();
                              },
                              child: Text(
                                "Create Booking",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: HexColor('#C61818'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _currentStep == 0
                        ? SizedBox()
                        : FlatButton(
                            onPressed: () => _onStepCancel(),
                            child: Text(
                              'Kembali',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                    _currentStep == 2
                        ? SizedBox()
                        : FlatButton(
                            onPressed: () => _onStepContinue(),
                            child: Text(
                              'Selanjutnya',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                  ],
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
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.people,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Masukan Nama Customer",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(vehicleNumberFocus);
                },
                controller: customerNameCtrl,
                focusNode: customerNameFocus,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddVehicleNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.chrome_reader_mode,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Masukan Plat Nomor",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(customerContactFocus);
                },
                controller: vehicleNumberCtrl,
                focusNode: vehicleNumberFocus,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddContactCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Masukan Nomor Telepon",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(customerEmailFocus);
                },
                controller: customerContactCtrl,
                focusNode: customerContactFocus,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddEmailCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.contact_mail,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Masukan Email Customer",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: customerEmailCtrl,
                focusNode: customerEmailFocus,
              ),
            ),
          ),
        ),
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
                currentSelectTypeService = "Perbaikan Umum";
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
                currentSelectTypeService = "Service Berkala";
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

  Widget formAddBookCategori() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                  _showListBookCategory();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 16),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: 'Pilih Kategori Booking',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: bookingCategoryCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectServicePeriodeType() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                  _showListServicePeriodeType();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 16),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: 'Pilih Tipe Service Periode',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: servicePeriodeTypeCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddDealer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                  _showListStation();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    showCursor: true,
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 16),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: 'Pilih Bengkel',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(dealerAddressFocus);
                    },
                    controller: dealerNameCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddDealerAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                readOnly: true,
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Alamat Bengkel",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: dealerAddressCtrl,
                focusNode: dealerAddressFocus,
                maxLines: null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddDealerMail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                readOnly: true,
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Alamat Email Bengkel",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: dealerEmailCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddSalesEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Alamat Email Sales",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: salesEmailCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddKepalaBengkel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Alamat Email Ka.Bengkel",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: kepalaBengkelEmailCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 16),
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
                      hintText: "Silahkan Pilih Tanggal",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(dealerAddressFocus);
                    },
                    controller: dateSelected,
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
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 16),
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
                      hintText: "Silahkan Pilih Jam Service",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(dealerAddressFocus);
                    },
                    controller: timeSelected,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddServiceBerkala() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                  _showListServiceBerkala();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    showCursor: true,
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 16),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: 'Pilih Service Berkala',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: serviceBerkalaCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sliderPriodeServiceMonth() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Slider(
            onChanged: (val) {
              setState(() {
                _servicePriodeMonth = val;
              });
            },
            activeColor: HexColor('#C61818'),
            inactiveColor: Colors.grey,
            max: 36.0,
            min: 6.0,
            divisions: 5,
            value: _servicePriodeMonth,
            label: _servicePriodeMonth.round().toString(),
          ),
        ),
        Center(
          child: Text(
            "${_servicePriodeMonth.round().toString()} bulan",
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
