import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_state.dart';
import 'package:salles_tools/src/models/customer_get_form_model.dart';
import 'package:salles_tools/src/models/lead_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/utils/currency_format.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';

class ProspectAddView extends StatefulWidget {
  final Datum value;
  ProspectAddView({this.value});

  @override
  _ProspectAddViewState createState() => _ProspectAddViewState();
}

class _ProspectAddViewState extends State<ProspectAddView> {
  var _formKey = GlobalKey<FormState>();

  int dataSelection = -1;
  
  DateTime currentTime = DateTime.now();

  int _currentStep = 0;
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  final dateFormat = DateFormat("yyyy-MM-dd");

  var leadCodeCtrl = new TextEditingController();
  var leadNameCtrl = new TextEditingController();
  var prospectDateCtrl = new TextEditingController();
  var followUpCtrl = new TextEditingController();
  var salesNameCtrl = new TextEditingController();

  var _currentSelectItemColour;
  var _currentSelectYear;
  var _currentSelectPrice;
  var _currentSelectQuantity;
  var _currentSelectFollowUp = "7 Hari";
  List<String> followUpList = [
    "1 Hari",
    "2 Hari",
    "3 Hari",
    "4 Hari",
    "5 Hari",
    "5 Hari",
    "6 Hari",
  "7 Hari",
  ];

  var customerProspectSourceCtrl = new TextEditingController();
  var currentSelectProspectSource;
  var prospectSourceId;
  List<SelectorProspectSourceModel> sourceList = [];

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

  void _showListClass1() {
    SelectDialog.showModal<String>(
      context,
      label: "Jenis Kendaraan",
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
            itemClass: ""
          )));
        });
      },
    );
  }

  void _showListItemModel() {
    SelectDialog.showModal<String>(
      context,
      label: "Model Kendaraan",
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
              itemClass: ""
          )));
        });
      },
    );
  }

  void _showListItemType() {
    SelectDialog.showModal<String>(
      context,
      label: "Tipe Kendaraan",
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

  void _showListFollowUp() {
    SelectDialog.showModal<String>(
      context,
      label: "Follow Up",
      selectedValue: _currentSelectFollowUp,
      items: followUpList,
      onChange: (String selected) {
        setState(() {
          _currentSelectFollowUp = selected;
          followUpCtrl.text = selected;
        });
      },
    );
  }

  void _showListSource() {
    SelectDialog.showModal<SelectorProspectSourceModel>(
      context,
      label: "Sumber Prospek",
      selectedValue: currentSelectProspectSource,
      items: sourceList,
      onChange: (SelectorProspectSourceModel selected) {
        setState(() {
          currentSelectProspectSource = selected;
          customerProspectSourceCtrl.text = selected.sourceName;
          prospectSourceId = selected.sourceId;
        });
      },
    );
  }

  void _showListItemCode() {
    SelectDialog.showModal<SelectorPriceListModel>(
      context,
      label: "Kode Kendaraan",
      selectedValue: currentSelectPriceList,
      items: priceList,
      itemBuilder: (context, SelectorPriceListModel item, bool isSelected) {
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
            subtitle: Text("Kode Item : ${item.itemCode}"),
          ),
        );
      },
      onChange: (SelectorPriceListModel selected) {
        setState(() {
          currentSelectPriceList = selected;
          itemCodeCtrl.text = selected.itemCode;

          // ignore: close_sinks
          final dmsBloc = BlocProvider.of<DmsBloc>(context);
          dmsBloc.add(FetchItemList(ItemListPost(
            itemCode: itemCodeCtrl.text,
            customerGroup: "1",
            itemGroup: "101",
          )));
        });
      },
    );
  }

  void onCreateProspect() {
    log.info("""
      Card Name : ${widget.value.cardName}
      Customer Group ID : ${widget.value.customerGroupId}
      Prospect Source ID : $prospectSourceId
      Lead Code : ${widget.value.leadCode}
      Item Code : ${itemCodeCtrl.text}
      Item Model : ${itemModelCtrl.text}
      Item Type : ${itemTypeCtrl.text}
      Item Colour : $_currentSelectItemColour
      Item Year : $_currentSelectYear
      Price $_currentSelectPrice
      Date ${DateFormat("yyyy-MM-dd").format(currentTime)}
    """);

    if (_formKey.currentState.validate()) {
      // ignore: close_sinks
      final dmsBloc = BlocProvider.of<DmsBloc>(context);
      dmsBloc.add(CreateProspect(ProspectPost(
        cardName: widget.value.cardName,
        customerGroupId: widget.value.customerGroupId.toString(),
        fromSuspect: "Y",
        itemColor: _currentSelectItemColour,
        itemModel: itemModelCtrl.text,
        itemType: itemTypeCtrl.text,
        itemYear: _currentSelectYear,
        leadCode: widget.value.leadCode,
        prospectFollowUp: 7,
        prospectDate: DateFormat("yyyy-MM-dd").format(currentTime).toString(),
        quantity: "1",
        price: _currentSelectPrice,
        itemCode: itemCodeCtrl.text,

      )));
    } else {
      log.warning("Please Complete Form!");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    leadCodeCtrl.text = widget.value.leadCode;
    leadNameCtrl.text = widget.value.cardName;
    prospectDateCtrl.value = TextEditingValue(text: dateFormat.format(DateTime.now()).toString());
    salesNameCtrl.text = widget.value.salesName;
    followUpCtrl.text = "7 Hari";

    // ignore: close_sinks
    final dmsBloc = BlocProvider.of<DmsBloc>(context);
    dmsBloc.add(FetchClass1Item());

    prospectSourceList.forEach((f) {
      sourceList.add(SelectorProspectSourceModel(
        sourceId: f.prospectSourceId,
        sourceName: f.prospectSourceName,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor("#C61818"),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Create Contact / Lead",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
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
                if (f.itemModel == currentSelectItemModel && f.itemType == currentSelectItemType) {
                  priceList.add(SelectorPriceListModel(
                    itemCode: f.itemCode,
                    itemModel: f.itemModel,
                    itemType: f.itemType,
                  ));
                }
              });
            }

            if (state is CreateProspectSuccess) {
              log.info("Success Create Lead");
              Alert(
                  context: context,
                  type: AlertType.success,
                  title: 'Success',
                  desc: "Created Prospect!",
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
                        Navigator.pop(context, false);
                        Navigator.pop(context, false);
                      },
                      color: HexColor("#C61818"),
                    ),
                  ]
              ).show();
            }

            if (state is CreateProspectError) {
              log.warning("Fail Create Prospect");
              Alert(
                  context: context,
                  type: AlertType.error,
                  title: 'Error',
                  desc: "Failed to Create Prospect!",
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
                  ]
              ).show();
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
                        "Info Prospect",
                        style: TextStyle(color: Colors.white),
                      ),
                      isActive: _currentStep == 0 ? true : false,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Tanggal Prospek",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formDateProspect(),
                          Text(
                            "Kode Lead",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formLeadCode(),
                          Text(
                            "Nama Lead",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formLeadName(),
                          Text(
                            "Nama Sales",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formSalesName(),
                          Text(
                            "Sumber Prospek (*)",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formSelectProspectSource(),
                          Text(
                            "Follow Up Pertama (*)",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          dropdownFollowUp(),
                        ],
                      ),
                    ),
                    Step(
                      title: Text(
                        "Data Model",
                        style: TextStyle(color: Colors.white),
                      ),
                      isActive: _currentStep == 1 ? true : false,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Jenis Kendaraan (*)",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formSelectItemClass1(),
                          Text(
                            "Model Kendaraan (*)",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formSelectItemModel(),
                          Text(
                            "Tipe Kendaraan (*)",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formSelectItemType(),
                          Text(
                            "Kode Kendaraan",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formSelectItemCode(),
                          itemList(),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
                            child: Container(
                              width: screenWidth(context),
                              child: RaisedButton(
                                onPressed: () {
                                  onCreateProspect();
                                },
                                child: Text(
                                  "Create",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: HexColor('#C61818'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
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
                          'BACK',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      _currentStep == 1
                          ? SizedBox()
                          : FlatButton(
                        onPressed: () => _onStepContinue(),
                        child: Text(
                          'NEXT',
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
      ),
    );
  }

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }

  Widget formDateProspect() {
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
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Tanggal Prospect",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: prospectDateCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formLeadCode() {
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
                  hintText: "Kode Lead",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: leadCodeCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formLeadName() {
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
                  hintText: "Nama Lead",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: leadNameCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSalesName() {
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
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Nama Sales",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: salesNameCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropdownFollowUp() {
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
                  _showListFollowUp();
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
                      hintText: "Pilih Follow Up Pertama",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: followUpCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectProspectSource() {
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
                  _showListSource();
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
                      hintText: "Pilih Sumber Contact",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerProspectSourceCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectItemClass1() {
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
                  _showListClass1();
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
                      hintText: "Pilih Jenis",
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

  Widget formSelectItemModel() {
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
                  _showListItemModel();
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
                      hintText: "Pilih Model",
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

  Widget formSelectItemType() {
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
                  _showListItemType();
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
                      hintText: "Pilih Tipe",
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

  Widget formSelectItemCode() {
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
                  _showListItemCode();
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
                      hintText: "Pilih Kode",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: itemCodeCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      child: BlocBuilder<DmsBloc, DmsState>(
        builder: (context, state) {
          if (state is ItemListSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Data Stock",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var value = state.value.data[0].stocks[index];
                    return ExpansionTile(
                      title: Text("${state.value.data[0].itemName}"),
                      initiallyExpanded: dataSelection == index ? true : false,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Kode Kendaraan"),
                              Text(
                                "${state.value.data[0].itemCode}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Model Kendaraan"),
                              Text("${state.value.data[0].itemModel}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Tahun"),
                              Text("${value.tahun}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Warna"),
                              Text("${value.namaWarna}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Harga On The Road"),
                              Text("Rp ${CurrencyFormat().data.format(state.value.data[0].pricelists[0].ontr)}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Stok "),
                              Text("${value.quantity}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Rp ${CurrencyFormat().data.format(state.value.data[0].pricelists[0].ontr)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                  fontSize: 16,
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    dataSelection = index;
                                    _currentSelectItemColour = state.value.data[0].stocks[index].namaWarna;
                                    _currentSelectYear = state.value.data[0].stocks[index].tahun;
                                    _currentSelectPrice = state.value.data[0].pricelists[0].ontr;
                                  });
                                },
                                elevation: 1,
                                child: Text(
                                  dataSelection == index
                                      ? "Dipilih"
                                      : "Pilih",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                color: dataSelection == index
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: state.value.data[0].stocks.length,
                ),
              ],
            );
          }

          if (state is ItemListFailed) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Data tidak berhasil ditemukan!",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
