import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_state.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:select_dialog/select_dialog.dart';

import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../utils/shared_preferences_helper.dart';

class BookTestDriveAddView extends StatefulWidget {
  @override
  _BookTestDriveAddViewState createState() => _BookTestDriveAddViewState();
}

class _BookTestDriveAddViewState extends State<BookTestDriveAddView> {
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

  var itemModelCtrl = new TextEditingController();
  var currentSelectItemModel;
  List<String> itemModelList = [];

  var itemTypeCtrl = new TextEditingController();
  var currentSelectItemType;
  List<String> itemTypeList = [];
// list car dms

//text editing controller init
  var branchNameCtrl = new TextEditingController();
  var outletNameCtrl = new TextEditingController();
//end of text editing controller init

  var costumerNameFocus = new FocusNode();
  var emailFocus = new FocusNode();
  var phoneNumberFocus = new FocusNode();

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

  void _showListClass1() {
    SelectDialog.showModal<String>(
      context,
      label: "Class 1",
      selectedValue: currentSelectClass1,
      items: class1List,
      onChange: (String selected) {
        setState(() {
          itemModelList = [];
          currentSelectClass1 = selected;
          class1Ctrl.text = selected;

          // ignore: close_sinks
          final dmsBloc = BlocProvider.of<DmsBloc>(context);
          dmsBloc.add(FetchItemModel(ItemModelPost(
              itemType: "",
              itemModel: "",
              itemClass1: class1Ctrl.text,
              itemClass: "")));
        });
      },
    );
  }

  void _showListItemModel() {
    SelectDialog.showModal<String>(
      context,
      label: "Item Model",
      selectedValue: currentSelectItemModel,
      items: itemModelList.toSet().toList(),
      onChange: (String selected) {
        setState(() {
          itemTypeList = [];
          currentSelectItemModel = selected;
          itemModelCtrl.text = selected;

          // ignore: close_sinks
          final dmsBloc = BlocProvider.of<DmsBloc>(context);
          dmsBloc.add(FetchItemType(ItemModelPost(
              itemType: "",
              itemModel: itemModelCtrl.text,
              itemClass1: class1Ctrl.text,
              itemClass: "")));
        });
      },
    );
  }

  void _showListItemType() {
    SelectDialog.showModal<String>(
      context,
      label: "Item Type",
      selectedValue: currentSelectItemType,
      items: itemTypeList,
      onChange: (String selected) {
        setState(() {
          priceList = [];
          currentSelectItemType = selected;
          itemTypeCtrl.text = selected;

          // ignore: close_sinks
          final dmsBloc = BlocProvider.of<DmsBloc>(context);
          dmsBloc.add(FetchPriceList(PriceListPost(
            itemCode: "",
            custGroup: "1",
          )));
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
      // branchNameCtrl.text = _branchName;
      // outletNameCtrl.text = _outletName;

      branchNameCtrl.text = _branchId;
      outletNameCtrl.text = _outletId;
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
        child: BlocListener<DmsBloc, DmsState>(
          listener: (context, state) {
            if (state is DmsLoading) {
              onLoading(context);
            }

            if (state is DmsDisposeLoading) {
              Navigator.of(context, rootNavigator: false).pop();
            }

            if (state is Class1ItemSuccess) {
              state.value.data.forEach((f) {
                class1List.add(f);
              });
            }

            if (state is ItemModelSuccess) {
              state.value.data.forEach((f) {
                itemModelList.add(f.itemModel);
              });
            }

            if (state is ItemTypeSuccess) {
              state.value.data.forEach((f) {
                itemTypeList.add(f.itemType);
              });
            }

            if (state is PriceListSuccess) {
              state.value.data.forEach((f) {
                if (f.itemModel == currentSelectItemModel &&
                    f.itemType == currentSelectItemType) {
                  priceList.add(SelectorPriceListModel(
                    itemCode: f.itemCode,
                    itemModel: f.itemModel,
                    itemType: f.itemType,
                  ));
                }
              });
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
                    "Customer Email (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formEmail(),
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
                    "Model (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formAddModelVehicle(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Type (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                formAddType(),
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
                        print('go to next step');
                      },
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
                //controller next here
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formEmail() {
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
                Icons.email,
                color: Color(0xFF6991C7),
                size: 24.0,
              ),
              hintText: "Input Email",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
            focusNode: emailFocus,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(emailFocus);
            },
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
            focusNode: phoneNumberFocus,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(phoneNumberFocus);
            },
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

  Widget formAddModelVehicle() {
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
                  _showListItemModel();
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
                      hintText: "Select Model Vehicle",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: itemModelCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddType() {
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
                  _showListItemType();
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
                      hintText: "Select Type",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: itemTypeCtrl,
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
                  // controller: dealerCtrl,
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
                  // controller: dealerCtrl,
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

    final dmsBloc = BlocProvider.of<DmsBloc>(context);
    dmsBloc.add(FetchClass1Item());

    print(
        "============================= page add booking test drive =============================");
    super.initState();
  }
}
