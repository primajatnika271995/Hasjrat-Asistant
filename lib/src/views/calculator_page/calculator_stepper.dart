import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_event.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_state.dart';
import 'package:salles_tools/src/models/asset_price_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:select_dialog/select_dialog.dart';

class CalculatorStepperScreen extends StatefulWidget {
  @override
  _CalculatorStepperScreenState createState() =>
      _CalculatorStepperScreenState();
}

class _CalculatorStepperScreenState extends State<CalculatorStepperScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentStep = 0;

  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  var dpVehicleCtrl = MoneyMaskedTextController(leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');
  int priceSelection = -1;
  String currentSelectMethode;

  var branchNameCtrl = new TextEditingController();
  var currentSelectBranch;
  var branchCode;
  List<SelectorBranchModel> branchList = [];

  var outletNameCtrl = new TextEditingController();
  var currentSelectOutlet;
  var outletCode;
  List<SelectorOutletModel> outletList = [];

  var assetKindCtrl = new TextEditingController();
  var currentSelectAssetKind;
  var assetKindCode;
  List<SelectorAssetKindModel> assetKindList = [];

  var insuranceTypeCtrl = new TextEditingController();
  var currentSelectInsuranceType;
  var insuranceTypeCode;
  List<SelectorInsuranceTypeModel> insuranceTypeList = [];

  var assetGroupCtrl = new TextEditingController();
  var currentSelectAssetGroup;
  var assetGroupCode;
  List<SelectorAssetGroupModel> assetGroupList = [];

  var assetTypeCtrl = new TextEditingController();
  var currentSelectAssetType;
  var assetTypeCode;
  List<SelectorAssetTypeModel> assetTypeList = [];

  AssetPriceModel _assetPriceModel;

  String dpMinimum = "0";
  String dpMaximum = "0";
  var priceListId;
  var priceOriginal;

  void _onSelectionPrice(int index) {
    setState(() {
      priceSelection = index;
    });
  }

  void _onCalculateSimulator() {
    switch (currentSelectMethode) {
      case "Down Payment":
        if (dpVehicleCtrl.numberValue < double.parse(dpMinimum.replaceAll(".", "")) || dpVehicleCtrl.numberValue > double.parse(dpMaximum.replaceAll(".", ""))) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.info_outline),
                  ),
                  Expanded(
                    child: Text(
                        " Down Price Minimum : Rp $dpMinimum \n Down Price Maximum : Rp $dpMaximum"),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // ignore: close_sinks
          final simulationBloc = BlocProvider.of<FinanceBloc>(context);
          simulationBloc.add(FetchSimulationDownPayment(branchCode, assetKindCode, insuranceTypeCode, assetGroupCode, assetTypeCode, priceListId, priceOriginal, (dpVehicleCtrl.numberValue / 10).toString()));
        }
        break;
      case "Price List":
        // ignore: close_sinks
        final simulationBloc = BlocProvider.of<FinanceBloc>(context);
        simulationBloc.add(FetchSimulationPriceList(branchCode, assetKindCode, insuranceTypeCode, assetGroupCode, assetTypeCode, priceListId, priceOriginal));
        break;
    }
  }

  void _showListBranch() {
    SelectDialog.showModal<SelectorBranchModel>(
      context,
      label: "Branch Name",
      selectedValue: currentSelectBranch,
      items: branchList,
      onChange: (SelectorBranchModel selected) {
        setState(() {
          outletList = [];
          currentSelectBranch = selected;
          branchNameCtrl.text = selected.branchName;
          branchCode = selected.id;

          // ignore: close_sinks
          final outletBloc = BlocProvider.of<FinanceBloc>(context);
          outletBloc.add(FetchOutlet(branchCode));
        });
      },
    );
  }

  void _showListOutlet() {
    SelectDialog.showModal<SelectorOutletModel>(
      context,
      label: "Outlet Name",
      selectedValue: currentSelectOutlet,
      items: outletList,
      onChange: (SelectorOutletModel selected) {
        setState(() {
          assetKindList = [];
          currentSelectOutlet = selected;
          outletNameCtrl.text = selected.outletName;
          outletCode = selected.id;

          // ignore: close_sinks
          final assetKindBloc = BlocProvider.of<FinanceBloc>(context);
          assetKindBloc.add(FetchAssetKind(branchCode));
        });
      },
    );
  }

  void _showListAssetKind() {
    SelectDialog.showModal<SelectorAssetKindModel>(
      context,
      label: "Asset Kind",
      selectedValue: currentSelectAssetKind,
      items: assetKindList,
      onChange: (SelectorAssetKindModel selected) {
        setState(() {
          insuranceTypeList = [];
          currentSelectAssetKind = selected;
          assetKindCtrl.text = selected.assetKindName;
          assetKindCode = selected.id;

          // ignore: close_sinks
          final insuranceBloc = BlocProvider.of<FinanceBloc>(context);
          insuranceBloc.add(FetchInsuranceType(branchCode, assetKindCode));
        });
      },
    );
  }

  void _showListInsuranceType() {
    SelectDialog.showModal<SelectorInsuranceTypeModel>(
      context,
      label: "Asset Kind",
      selectedValue: currentSelectInsuranceType,
      items: insuranceTypeList,
      onChange: (SelectorInsuranceTypeModel selected) {
        setState(() {
          assetGroupList = [];
          currentSelectInsuranceType = selected;
          insuranceTypeCtrl.text = selected.insuranceTypeName;
          insuranceTypeCode = selected.id;

          // ignore: close_sinks
          final assetGroupBloc = BlocProvider.of<FinanceBloc>(context);
          assetGroupBloc.add(FetchAssetGroup(branchCode, assetKindCode, insuranceTypeCode));
        });
      },
    );
  }

  void _showListAssetGroup() {
    SelectDialog.showModal<SelectorAssetGroupModel>(
      context,
      label: "Asset Group",
      selectedValue: currentSelectAssetGroup,
      items: assetGroupList,
      onChange: (SelectorAssetGroupModel selected) {
        setState(() {
          assetTypeList = [];
          currentSelectAssetGroup = selected;
          assetGroupCtrl.text = selected.assetGroupCode;
          assetGroupCode = selected.assetGroupCode;

          // ignore: close_sinks
          final assetTypeBloc = BlocProvider.of<FinanceBloc>(context);
          assetTypeBloc.add(FetchAssetType(branchCode, assetKindCode, insuranceTypeCode, assetGroupCode));
        });
      },
    );
  }

  void _showListAssetType() {
    SelectDialog.showModal<SelectorAssetTypeModel>(
      context,
      label: "Asset Group",
      selectedValue: currentSelectAssetType,
      items: assetTypeList,
      onChange: (SelectorAssetTypeModel selected) {
        setState(() {
          _assetPriceModel = null;
          currentSelectAssetType = selected;
          assetTypeCtrl.text = selected.assetTypeName;
          assetTypeCode = selected.assetTypeCode;

          // ignore: close_sinks
          final assetPriceBloc = BlocProvider.of<FinanceBloc>(context);
          assetPriceBloc.add(FetchAssetPrice(branchCode, assetKindCode, insuranceTypeCode, assetGroupCode, assetTypeCode));
        });
      },
    );
  }

  Widget _createEventControlBuilder(BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final branchBloc = BlocProvider.of<FinanceBloc>(context);
    branchBloc.add(FetchBranch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Calculator",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<FinanceBloc, FinanceState>(
        listener: (context, state) {
          if (state is BranchSuccess) {
            state.value.result.forEach((f) {
              branchList.add(
                SelectorBranchModel(
                  id: f.id,
                  branchName: f.text,
                ),
              );
            });
          }

          if (state is OutletSuccess) {
            state.value.result.forEach((f) {
              outletList.add(
                SelectorOutletModel(
                  id: f.id,
                  outletName: f.text,
                ),
              );
            });
          }

          if (state is AssetKindSuccess) {
            state.value.result.forEach((f) {
              assetKindList.add(
                SelectorAssetKindModel(
                  id: f.id,
                  assetKindName: f.text,
                ),
              );
            });
          }

          if (state is InsuranceTypeSuccess) {
            state.value.result.forEach((f) {
              insuranceTypeList.add(
                SelectorInsuranceTypeModel(
                  id: f.insuranceTypeCode,
                  insuranceTypeName: f.insuranceTypeName,
                ),
              );
            });
          }

          if (state is AssetGroupSuccess) {
            state.value.result.forEach((f) {
              assetGroupList.add(
                SelectorAssetGroupModel(
                  assetGroupCode: f.assetGroupCode,
                  assetGroupName: f.assetGroupName,
                ),
              );
            });
          }

          if (state is AssetTypeSuccess) {
            state.value.result.forEach((f) {
              assetTypeList.add(
                SelectorAssetTypeModel(
                  assetTypeCode: f.assetTypeCode,
                  assetTypeName: f.assetTypeName,
                ),
              );
            });
          }

          if (state is AssetPriceSuccess) {
            _assetPriceModel = state.value;
          }

          if (state is FinanceLoading) {
            onLoading(context);
          }

          if (state is FinanceDisposeLoading) {
            Navigator.of(context, rootNavigator: false).pop();
          }
        },
        child: Stack(
          children: <Widget>[
            Stepper(
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
                  isActive: _currentStep == 0 ? true : false,
                  title: Text("Vehicle"),
                  state: StepState.editing,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Branch", style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      )),
                      formSelectBranch(),
                      Text("Outlet", style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      )),
                      formSelectOutlet(),
                      Text("Asset Kind", style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      )),
                      formSelectAssetKind(),
                      Text("Insurance", style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      )),
                      formSelectInsuranceType(),
                      Text("Asset Group", style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      )),
                      formSelectAssetGroup(),
                      Text("Asset Type", style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      )),
                      formSelectAssetType(),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep == 1 ? true : false,
                  title: Text("Category"),
                  state: StepState.editing,
                  content: stepCategory(),
                ),
                Step(
                  isActive: _currentStep == 2 ? true : false,
                  title: Text("Tenor"),
                  state: StepState.complete,
                  content: stepTenor(),
                ),
              ],
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
                    _currentStep == 2
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
    );
  }

  Widget formSelectBranch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18),
            labelText: 'Branch Name',
            hasFloatingPlaceholder: false,
            suffixIcon: IconButton(
              onPressed: () {
                _showListBranch();
              },
              icon: Icon(Icons.navigate_next),
              color: Colors.red,
            ),
            prefixIcon: Icon(Icons.location_on, color: HexColor('#E07B36')),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: branchNameCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formSelectOutlet() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18),
            hasFloatingPlaceholder: false,
            labelText: 'Outlet Name',
            suffixIcon: IconButton(
              onPressed: () {
                _showListOutlet();
              },
              icon: Icon(Icons.navigate_next),
              color: Colors.red,
            ),
            prefixIcon: Icon(Icons.location_on, color: HexColor('#E07B36')),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: outletNameCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formSelectAssetKind() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18),
            hasFloatingPlaceholder: false,
            labelText: 'Asset Kind',
            suffixIcon: IconButton(
              onPressed: () {
                _showListAssetKind();
              },
              icon: Icon(Icons.navigate_next),
              color: Colors.red,
            ),
            prefixIcon: Icon(Icons.web_asset, color: HexColor('#E07B36')),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: assetKindCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formSelectInsuranceType() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18),
            hasFloatingPlaceholder: false,
            labelText: 'Insurance Type',
            suffixIcon: IconButton(
              onPressed: () {
                _showListInsuranceType();
              },
              icon: Icon(Icons.navigate_next),
              color: Colors.red,
            ),
            prefixIcon: Icon(Icons.assignment_ind, color: HexColor('#E07B36')),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: insuranceTypeCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formSelectAssetGroup() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18),
            hasFloatingPlaceholder: false,
            labelText: 'Asset Group',
            suffixIcon: IconButton(
              onPressed: () {
                _showListAssetGroup();
              },
              icon: Icon(Icons.navigate_next),
              color: Colors.red,
            ),
            prefixIcon: Icon(Icons.group_work, color: HexColor('#E07B36')),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: assetGroupCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formSelectAssetType() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18),
            hasFloatingPlaceholder: false,
            labelText: 'Asset Type',
            suffixIcon: IconButton(
              onPressed: () {
                _showListAssetType();
              },
              icon: Icon(Icons.navigate_next),
              color: Colors.red,
            ),
            prefixIcon: Icon(Icons.directions_car, color: HexColor('#E07B36')),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: assetTypeCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget selectedMethode() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              hintText: 'Select Methode',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentSelectMethode,
                hint: Text('Select Simulation Type'),
                isDense: true,
                onChanged: (String newVal) {
                  setState(() {
                    currentSelectMethode = newVal;
                    state.didChange(newVal);
                  });
                },
                items: ['Down Payment', 'Price List'].map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget formDP() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Rp',
        labelText: 'Uang (DP)',
        labelStyle: TextStyle(
          color: HexColor('#E07B36'),
          fontWeight: FontWeight.w400,
        ),
        hasFloatingPlaceholder: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#E07B36'),
            width: 1,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#E07B36'),
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#E07B36'),
            width: 2,
          ),
        ),
      ),
      controller: dpVehicleCtrl,
      keyboardType: TextInputType.number,
    );
  }

  Widget stepCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _assetPriceModel != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Price List",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var value = _assetPriceModel.result[index];
                return ExpansionTile(
                  title: Text("${value.priListTitle}"),
                  initiallyExpanded: priceSelection == index
                      ? true
                      : false,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Type"),
                          Text(
                            "${value.assetTypeName}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Start Date"),
                          Text("${value.startDate}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("End Date"),
                          Text("${value.endDate}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Minimum DP"),
                          Text("Rp ${value.dpBottomLimit} (${value.dpBottomLimitPercentage} %)"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Maximum DP"),
                          Text("Rp ${value.dpTopLimit} (${value.dpTopLimitPercentage} %)"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Rp ${value.price}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                              fontSize: 16,
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              _onSelectionPrice(index);
                              setState(() {
                                priceListId = value.priceListId;
                                dpMinimum = value.dpBottomLimit;
                                dpMaximum = value.dpTopLimit;
                                priceOriginal = value.price;
                              });
                            },
                            elevation: 1,
                            child: Text(
                              priceSelection == index
                                  ? "Selected"
                                  : "Take it",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: priceSelection == index
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemCount: _assetPriceModel.result.length,
            ),
          ],
        )
            : Center(
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
        ),
        _assetPriceModel == null
            ? SizedBox()
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            Padding(
              padding:
              const EdgeInsets.only(right: 25, top: 10),
              child: Text(
                "Simulation Type",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            selectedMethode(),
            currentSelectMethode == "Down Payment"
                ? formDP()
                : SizedBox(),
            currentSelectMethode == "Down Payment"
                ? Row(
              children: <Widget>[
                Text("* Minimum DP : "),
                Text(
                  "$dpMinimum",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ) : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          _onCalculateSimulator();
                        },
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                              color: Colors.white),
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
          ],
        ),
      ],
    );
  }

  Widget stepTenor() {
    return Column(
      children: <Widget>[
        BlocBuilder<FinanceBloc, FinanceState>(
          builder: (context, state) {
            if (state is SimulationFailed) {
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

            if (state is SimulationSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "List Tenor",
                    style: TextStyle(
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      var data = state.value.result[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "Tenor ${data.tenorName}",
                              style: TextStyle(
                                letterSpacing: 0.8,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              "Rp ${data.installment} / Bulan",
                              style: TextStyle(
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              "Lama Tenor ${data.tenorVale} Bulan",
                              style: TextStyle(
                                letterSpacing: 0.8,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: state.value.result.length,
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}
