import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_state.dart';
import 'package:salles_tools/src/models/item_list_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/utils/currency_format.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PriceListView extends StatefulWidget {
  @override
  _PriceListViewState createState() => _PriceListViewState();
}

class _PriceListViewState extends State<PriceListView> {
  var _formKey = GlobalKey<FormState>();

  var leadCodeCtrl = new TextEditingController();
  var leadNameCtrl = new TextEditingController();
  var prospectDateCtrl = new TextEditingController();
  var salesNameCtrl = new TextEditingController();

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
          dmsBloc.add(FetchItemModel(ItemModelPost(itemType: "", itemModel: "", itemClass1: class1Ctrl.text, itemClass: "")));
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
              itemClass: "")));
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

  void _showListItemCode() {
    SelectDialog.showModal<SelectorPriceListModel>(
      context,
      label: "Nama Kode",
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
            subtitle: Text("Item Code : ${item.itemCode}"),
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

  void exportPdf(List<Pricelist> value) async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (pw.Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const pw.BoxDecoration(
                border: pw.BoxBorder(
                    bottom: true, width: 0.5, color: PdfColors.grey)),
            child: pw.Text('Price List',
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey),
            ),
        );
      },
      footer: (pw.Context context) {
        return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey),
            ),
        );
      },
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('Price List & Stock', textScaleFactor: 2),
                  ]),
          ),
          pw.ListView.builder(
            itemBuilder: (pw.Context contex, index) {
              return pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Kode Item', 'Model Kendaraan', 'Dalam Kota', 'Tanggal', 'Harga'],
                  <String>['${value[index].itemCode}', '${value[index].itemModel}', '${value[index].dalamKota}', '${value[index].pricelistTanggal}', 'Rp ${CurrencyFormat().data.format(value[index].ontr)}'],
                ],
              );
            },
           itemCount: value.length
          ),
        ];
    }
    ));
    final directory = await getExternalStorageDirectory();
    log.info(directory.path);

    final file = File('${directory.path}/price-list.pdf');
    file.writeAsBytesSync(pdf.save());

    OpenFile.open('${directory.path}/price-list.pdf');
  }

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final dmsBloc = BlocProvider.of<DmsBloc>(context);
    dmsBloc.add(FetchClass1Item());
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
          "Price List & Stock",
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Jenis Kendaraan (*)",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  formSelectItemClass1(),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Model Kendaraan (*)",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  formSelectItemModel(),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Tipe Kendaraan (*)",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  formSelectItemType(),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Nama Kode",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  formSelectItemCode(),
                  itemList(),
                  SizedBox(height: 10),
                ],
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 18),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 18),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 18),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 18),
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
        child: BlocBuilder<DmsBloc, DmsState>(
          builder: (context, state) {
            if (state is ItemListFailed) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context, rootNavigator: true).pop();
              });
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icons/no_data.png", height: 200),
                    ],
                  ),
                ),
              );
            }

            if (state is ItemListSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "Data Price List",
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
                      var value = state.value.data[0].pricelists[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text("${state.value.data[0].itemName}"),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Kode Item"),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Model Kendaraan"),
                                    Text("${state.value.data[0].itemModel}"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "Rp ${CurrencyFormat().data.format(value.ontr)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.0,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Data Stock",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              state.value.data[0].stocks.isEmpty
                                  ? Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text("Tidak Tersedia"),
                                  )
                                  : ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: (BuildContext context, int index) => Divider(),
                                      itemBuilder: (context, iStock) {
                                        var stock = state.value.data[0].stocks[iStock];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text("Nomor Rangka"),
                                                  Text(
                                                    "${stock.nomorRangka}",
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
                                                  Text("Tahun Pembuatan"),
                                                  Text("${stock.tahun}"),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text("Warna"),
                                                  Text("${stock.namaWarna}"),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text("Quantity"),
                                                  Text("${stock.quantity}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      itemCount: state.value.data[0].stocks.length,
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.value.data[0].pricelists.length,
                  ),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        exportPdf(state.value.data[0].pricelists);
                      },
                      icon: Icon(Icons.file_download),
                    ),
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
      ),
    );
  }
}
