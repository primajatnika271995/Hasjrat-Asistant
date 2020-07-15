import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_bloc.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_event.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_state.dart';
import 'package:salles_tools/src/services/check_stock_service.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:salles_tools/src/models/selector_model.dart';

class CheckStockScreen extends StatefulWidget {
  CheckStockScreen({Key key}) : super(key: key);

  @override
  _CheckStockScreenState createState() => _CheckStockScreenState();
}

class _CheckStockScreenState extends State<CheckStockScreen> {
  var _formKey = GlobalKey<FormState>();

  // getter branch code and name from json
  var kodeBranchCtrl = new TextEditingController();
  var kodeBranchTerpilih;
  var getBranchCode;
  List<SelectorBranchModel> branchList = [];

  void showBranch() {
    SelectDialog.showModal<SelectorBranchModel>(
      context,
      label: "Branch",
      selectedValue: kodeBranchTerpilih,
      items: branchList,
      showSearchBox: false,
      itemBuilder: (context, SelectorBranchModel item, bool isSelected) {
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
            title: Text("${item.branchName}"),
            subtitle: Text("Branch Code : ${item.id}"),
          ),
        );
      },
      onChange: (SelectorBranchModel selected) {
        setState(() {
          kodeBranchTerpilih = selected;
          kodeBranchCtrl.text = selected.branchName;
          getBranchCode = selected.id;
          // final checkStockBloc = BlocProvider.of<CheckStockBloc>(context);
        });
      },
    );
  }

  // getter list from json
  var jenisKendaraanCtrl = new TextEditingController();
  var jenisKendaraanTerpilih;
  List<String> jenisKendaraanList = [];

  void showJenisKendaraan() {
    SelectDialog.showModal<String>(
      context,
      label: "Jenis Kendaraan",
      showSearchBox: false,
      items: jenisKendaraanList,
      selectedValue: jenisKendaraanTerpilih,
      onChange: (String selected) {
        setState(() {
          modelKendaraanList = [];
          jenisKendaraanTerpilih = selected;
          jenisKendaraanCtrl.text = selected;

          //set value for get model kendaraan
          final checkStockBloc = BlocProvider.of<CheckStockBloc>(context);
          checkStockBloc.add(FetchModelKendaraan(ModelKendaraanPost(
              itemClass1: jenisKendaraanCtrl.text,
              itemModel: "",
              itemType: "",
              itemClass: "")));
        });
      },
    );
  }

  // getter list model kendaraan from json
  var modelKendaraanCtrl = new TextEditingController();
  var modelKendaraanTerpilih;
  List<String> modelKendaraanList = [];

  void showModelKendaraan() {
    SelectDialog.showModal<String>(context,
        label: "Model Kendaraan",
        showSearchBox: false,
        items: modelKendaraanList.toSet().toList(),
        selectedValue: modelKendaraanTerpilih, onChange: (String selected) {
      setState(() {
        tipeKendaraanList = [];
        modelKendaraanTerpilih = selected;
        modelKendaraanCtrl.text = selected;
        final checkStockBloc = BlocProvider.of<CheckStockBloc>(context);
        checkStockBloc.add(FetchTipeKendaraan(ModelKendaraanPost(
            itemClass1: jenisKendaraanCtrl.text,
            itemModel: modelKendaraanCtrl.text,
            itemType: "",
            itemClass: "")));
      });
    });
  }

  // getter tipe kendaraan from json
  var tipeKendaraanCtrl = new TextEditingController();
  var tipeKendaraanTerpilih;
  List<String> tipeKendaraanList = [];

  void showTipeKendaraan() {
    SelectDialog.showModal<String>(
      context,
      label: "Tipe Kendaraan",
      selectedValue: tipeKendaraanTerpilih,
      items: tipeKendaraanList,
      showSearchBox: false,
      onChange: (String selected) {
        setState(() {
          kodeKendaraanList = [];
          tipeKendaraanTerpilih = selected;
          tipeKendaraanCtrl.text = selected;

          final checkStockBloc = BlocProvider.of<CheckStockBloc>(context);
          checkStockBloc.add(FetchKodeKendaraan(KodeKendaraanPost(
            cGroup: "1",
            itemCode: "",
          )));
        });
      },
    );
  }

  // getter kode kendaraan from json
  var kodeKendaraanCtrl = new TextEditingController();
  var kodeKendaraanTerpilih;
  List<SelectorPriceListModel> kodeKendaraanList = [];

  void showKodeKendaraan() {
    SelectDialog.showModal<SelectorPriceListModel>(
      context,
      label: "Kode Kendaraan",
      selectedValue: kodeKendaraanTerpilih,
      items: kodeKendaraanList,
      showSearchBox: false,
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
            subtitle: Text("Item Code : ${item.itemCode}"),
          ),
        );
      },
      onChange: (SelectorPriceListModel selected) {
        setState(() {
          kodeKendaraanTerpilih = selected;
          kodeKendaraanCtrl.text = selected.itemCode;

          final checkStockBloc = BlocProvider.of<CheckStockBloc>(context);
          checkStockBloc.add(FetchStockHo(CekStoKHeadOfficePost(
            branchCode: getBranchCode,
            jenisKendaraan: jenisKendaraanCtrl.text,
            modelKendaraan: modelKendaraanCtrl.text,
            tipeKendaraan: tipeKendaraanCtrl.text,
            kodeKendaraan: kodeKendaraanCtrl.text,
          )));
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    final checkStockBloc = BlocProvider.of<CheckStockBloc>(context);
    // checkStockBloc.add(FetchStockHo());
    checkStockBloc.add(FetchJenisKendaraan());
    checkStockBloc.add(FetchKodeBranch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok HO',
            style: TextStyle(color: Colors.black, letterSpacing: 1.0)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 1,
      ),
      body: Form(
        key: _formKey,
        child: BlocListener<CheckStockBloc, CheckStockState>(
          listener: (context, state) {
            if (state is CheckStockLoading) {
              onLoading(context);
            }
            if (state is CheckStockDisposeLoading) {
              Navigator.of(context, rootNavigator: false).pop();
            }
            if (state is FetchKodeBranchSukses) {
              state.value.forEach((element) {
                branchList.add(SelectorBranchModel(
                  branchName: element.name,
                  id: element.id,
                ));
              });
            }
            if (state is FetchJenisKendaraanSukses) {
              state.value.data.forEach((element) {
                jenisKendaraanList.add(element);
              });
            }
            if (state is FetchModelKendaraanSukses) {
              state.value.data.forEach((element) {
                modelKendaraanList.add(element.itemModel);
              });
            }
            if (state is FetchTipeKendaraanSukses) {
              state.value.data.forEach((element) {
                tipeKendaraanList.add(element.itemType);
              });
            }
            if (state is FetchKodeKendaraanSukses) {
              state.value.data.forEach((f) {
                if (f.itemModel == modelKendaraanTerpilih &&
                    f.itemType == tipeKendaraanTerpilih) {
                  kodeKendaraanList.add(SelectorPriceListModel(
                    itemCode: f.itemCode,
                    itemModel: f.itemModel,
                    itemType: f.itemType,
                  ));
                }
              });
            }
            // if (state is CheckStockSuccess) {
            //   print("SUKSES GET STOK DENGAN FILTER VALUE");
            // }
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Branch',
                    style: TextStyle(
                        letterSpacing: 1, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 0,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Theme(
                            data: ThemeData(hintColor: Colors.transparent),
                            child: GestureDetector(
                              onTap: () {
                                showBranch();
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
                                    hintText: "Pilih Branch",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  controller: kodeBranchCtrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Jenis Kendaraan',
                    style: TextStyle(
                        letterSpacing: 1, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 0,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Theme(
                            data: ThemeData(hintColor: Colors.transparent),
                            child: GestureDetector(
                              onTap: () {
                                showJenisKendaraan();
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
                                    hintText: "Pilih Jenis Kendaraan",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  controller: jenisKendaraanCtrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Model Kendaraan',
                    style: TextStyle(
                        letterSpacing: 1, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 17,
                              spreadRadius: 0,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Theme(
                            data: ThemeData(hintColor: Colors.transparent),
                            child: GestureDetector(
                              onTap: () {
                                showModelKendaraan();
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
                                    hintText: "Pilih Model Kendaraan",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  controller: modelKendaraanCtrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Tipe Kendaraan',
                    style: TextStyle(
                        letterSpacing: 1, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 17,
                              spreadRadius: 0,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Theme(
                            data: ThemeData(hintColor: Colors.transparent),
                            child: GestureDetector(
                              onTap: () {
                                showTipeKendaraan();
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
                                    hintText: "Pilih Tipe Kendaraan",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  controller: tipeKendaraanCtrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Kode Kendaraan',
                    style: TextStyle(
                        letterSpacing: 1, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 17,
                              spreadRadius: 0,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Theme(
                            data: ThemeData(hintColor: Colors.transparent),
                            child: GestureDetector(
                              onTap: () {
                                showKodeKendaraan();
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
                                    hintText: "Pilih Nama Kode",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  controller: kodeKendaraanCtrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //list stock ho view
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      child: BlocBuilder<CheckStockBloc, CheckStockState>(
                        builder: (context, state) {
                          if (state is CheckStockFailed) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context, rootNavigator: true).pop();
                            });
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 100),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset("assets/icons/no_data.png",
                                        height: 200),
                                  ],
                                ),
                              ),
                            );
                          }

                          if (state is CheckStockSuccess) {
                            print("DATA HO STOK BERHASIL");
                            return Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: state.value.data.isEmpty
                                  ? Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 100),
                                              child: Column(
                                                children: <Widget>[
                                                  Image.asset(
                                                      "assets/icons/no_data.png",
                                                      height: 200),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              "Data Stok Tidak Ditemukan!",
                                              style: TextStyle(
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                  )
                                  : Card(
                                      elevation: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        child: Text(
                                                          "Data Stok",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text("Tahun",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text("Warna",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                                "Warehouse",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text("Qty",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5),
                                                        child: Divider(
                                                          color:
                                                              Colors.grey[100],
                                                          thickness: 1,
                                                        ),
                                                      ),
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount: state
                                                            .value.data.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          var data = state.value
                                                              .data[index];
                                                          return Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                        "${data.tahunProduksi}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child: Text(
                                                                        "${data.namaWarna}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child: Text(
                                                                        "${data.whsName}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                        "  ${data.quantity}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5),
                                                                child: Divider(
                                                                  color: Colors
                                                                          .grey[
                                                                      100],
                                                                  thickness: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            );
                          }
                          if (state is CheckStockFailed) {
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
