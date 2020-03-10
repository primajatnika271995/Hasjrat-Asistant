import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_event.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_state.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var dpVehicleCtrl = MoneyMaskedTextController(leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');
  double _lamaCicilan = 1.0;

  var branchNameCtrl = new TextEditingController();
  var currentSelectBranch;
  var branchCode;
  List<SelectorBranchModel> branchList = [];

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


  void _showListBranch() {
    SelectDialog.showModal<SelectorBranchModel>(
      context,
      label: "Branch Name",
      selectedValue: currentSelectBranch,
      items: branchList,
      onChange: (SelectorBranchModel selected) {
        setState(() {
          assetKindList = [];
          currentSelectBranch = selected;
          branchNameCtrl.text = selected.branchName;
          branchCode = selected.id;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
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
            log.info(state);
          }

          if (state is FinanceLoading) {
            onLoading(context);
          }

          if (state is FinanceDisposeLoading) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context, rootNavigator: false).pop();
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//            formAddVehicle(),
//            formAddVehicleType(),
              formSelectBranch(),
              formSelectAssetKind(),
              formSelectInsuranceType(),
              formSelectAssetGroup(),
              formSelectAssetType(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: BlocBuilder<FinanceBloc, FinanceState>(
                  builder: (context, state) {
                    if (state is AssetPriceSuccess) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var value = state.value.result[index];
                          return ExpansionTile(
                            title: Text("${value.priListTitle}"),
                            children: <Widget>[
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
                                child: Center(
                                  child: Text("Rp ${value.price}", style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.0,
                                    fontSize: 16,
                                  ),),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: state.value.result.length,
                      );
                    }
                    
                    if (state is AssetPriceFailed) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("Data tidak berhasil ditemukan!", style: TextStyle(
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w700,
                          ),),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
//              Padding(
//                padding: const EdgeInsets.only(top: 15),
//                child: Center(
//                  child: Text(
//                    "Rp {?}",
//                    style: TextStyle(
//                      letterSpacing: 1.0,
//                      fontWeight: FontWeight.w700,
//                      fontSize: 19,
//                    ),
//                  ),
//                ),
//              ),
              formDP(),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  "Isi simulasi lama Cicilan",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Slider(
                  onChanged: (val) {
                    setState(() {
                      _lamaCicilan = val;
                    });
                  },
                  activeColor: HexColor('#E07B36'),
                  inactiveColor: Colors.grey,
                  max: 36.0,
                  min: 1.0,
                  divisions: 36,
                  value: _lamaCicilan,
                  label: _lamaCicilan.round().toString(),
                ),
              ),
              Center(
                child: Text(
                  "${_lamaCicilan.round().toString()} bulan",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Container(
                  width: screenWidth(context),
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      "Calculate",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: HexColor('#E07B36'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 5),
                child: Text(
                  "Cicilan Bulan",
                  style: TextStyle(
                    letterSpacing: 0.8,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 5, bottom: 5),
                child: Text(
                  "Rp {no data} / Bulan",
                  style: TextStyle(
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formSelectBranch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Branch Name',
          suffixIcon: IconButton(
            onPressed: () {
              _showListBranch();
            },
            icon: Icon(Icons.navigate_next),
            color: Colors.red,
          ),
          prefixIcon: Icon(Icons.location_on, color: HexColor('#E07B36')),
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
        controller: branchNameCtrl,
        maxLines: null,
      ),
    );
  }

  Widget formSelectAssetKind() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Asset Kind',
          suffixIcon: IconButton(
            onPressed: () {
              _showListAssetKind();
            },
            icon: Icon(Icons.navigate_next),
            color: Colors.red,
          ),
          prefixIcon: Icon(Icons.web_asset, color: HexColor('#E07B36')),
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
        controller: assetKindCtrl,
        maxLines: null,
      ),
    );
  }

  Widget formSelectInsuranceType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Insurance Type',
          suffixIcon: IconButton(
            onPressed: () {
              _showListInsuranceType();
            },
            icon: Icon(Icons.navigate_next),
            color: Colors.red,
          ),
          prefixIcon: Icon(Icons.assignment_ind, color: HexColor('#E07B36')),
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
        controller: insuranceTypeCtrl,
        maxLines: null,
      ),
    );
  }

  Widget formSelectAssetGroup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Asset Group',
          suffixIcon: IconButton(
            onPressed: () {
              _showListAssetGroup();
            },
            icon: Icon(Icons.navigate_next),
            color: Colors.red,
          ),
          prefixIcon: Icon(Icons.group_work, color: HexColor('#E07B36')),
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
        controller: assetGroupCtrl,
        maxLines: null,
      ),
    );
  }

  Widget formSelectAssetType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Asset Type',
          suffixIcon: IconButton(
            onPressed: () {
              _showListAssetType();
            },
            icon: Icon(Icons.navigate_next),
            color: Colors.red,
          ),
          prefixIcon: Icon(Icons.directions_car, color: HexColor('#E07B36')),
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
        controller: assetTypeCtrl,
        maxLines: null,
      ),
    );
  }

  Widget formAddVehicle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Vehicle Name',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
          prefixIcon: Icon(Icons.time_to_leave),
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

  Widget formAddVehicleType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Vehicle Type',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
          prefixIcon: Icon(Icons.time_to_leave),
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

  Widget formDP() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
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
      ),
    );
  }
}

class SelectorBranchModel {
  String id;
  String branchName;

  SelectorBranchModel({this.id, this.branchName});

  @override
  String toString() => branchName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorBranchModel && other.id == id;

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode^branchName.hashCode;
}

class SelectorAssetKindModel {
  String id;
  String assetKindName;

  SelectorAssetKindModel({this.id, this.assetKindName});

  @override
  String toString() => assetKindName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorAssetKindModel && other.id == id;

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode^assetKindName.hashCode;
}

class SelectorInsuranceTypeModel {
  String id;
  String insuranceTypeName;

  SelectorInsuranceTypeModel({this.id, this.insuranceTypeName});

  @override
  String toString() => insuranceTypeName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorInsuranceTypeModel && other.id == id;

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode^insuranceTypeName.hashCode;
}

class SelectorAssetGroupModel {
  String assetGroupCode;
  String assetGroupName;

  SelectorAssetGroupModel({this.assetGroupCode, this.assetGroupName});

  @override
  String toString() => assetGroupName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorAssetGroupModel && other.assetGroupCode == assetGroupCode;

  @override
  // TODO: implement hashCode
  int get hashCode => assetGroupCode.hashCode^assetGroupName.hashCode;
}

class SelectorAssetTypeModel {
  String assetTypeCode;
  String assetTypeName;

  SelectorAssetTypeModel({this.assetTypeCode, this.assetTypeName});

  @override
  String toString() => assetTypeName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorAssetTypeModel && other.assetTypeCode == assetTypeCode;

  @override
  // TODO: implement hashCode
  int get hashCode => assetTypeCode.hashCode^assetTypeName.hashCode;
}
