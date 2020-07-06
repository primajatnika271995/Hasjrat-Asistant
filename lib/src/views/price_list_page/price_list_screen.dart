import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:native_pdf_renderer/native_pdf_renderer.dart' as npr;

class PriceListView extends StatefulWidget {
  @override
  _PriceListViewState createState() => _PriceListViewState();
}

class _PriceListViewState extends State<PriceListView> {
  var _formKey = GlobalKey<FormState>();

  List<List<String>> rowPrice = new List();
  List<List<String>> rowStock = new List();

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
      showSearchBox: false,
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
      label: "Model Kendaraan",
      selectedValue: currentSelectItemModel,
      showSearchBox: false,
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
      showSearchBox: false,
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

  void exportPdf(Datum value) async {
    rowPrice.clear();
    rowStock.clear();

    final pdf = pw.Document();
    rowPrice.add(
      <String>[
        'Kode Item',
        'Model Kendaraan',
        'Dalam Kota',
        'Tanggal',
        'Harga'
      ],
    );
    rowStock.add(<String>['Tahun', 'Jumlah', 'Warna', 'Warehouse']);

    value.pricelists.forEach((f) {
      List<String> price = <String>[
        f.itemCode,
        f.itemModel,
        f.dalamKota,
        f.pricelistTanggal.toString(),
        CurrencyFormat().data.format(f.ontr)
      ];
      rowPrice.add(price);
    });

    value.stocks.forEach((f) {
      List<String> stock = <String>[
        f.tahun,
        f.quantity.toString(),
        f.namaWarna,
        f.whsName,
      ];
      rowStock.add(stock);
    });

    ByteData bytes =
        await rootBundle.load('assets/icons/old_hasjrat_toyota_logo.png');
    File imgLogo;
    try {
      imgLogo = await writeToFile(bytes); // <= returns File
    } catch (e) {
      // catch errors here
    }

    final image = PdfImage.file(
      pdf.document,
      bytes: imgLogo.readAsBytesSync(),
    );

    pdf.addPage(pw.MultiPage(
        pageFormat:
            PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
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
            child: pw.Text(
              'Price List',
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
                    pw.Text(' Data Price List & Stock', textScaleFactor: 2),
                    pw.Container(
                      height: 50,
                      width: 100,
                      child: pw.Image(image),
                    ),
                  ]),
            ),
            pw.Paragraph(text: 'Price List'),
            pw.Table.fromTextArray(context: context, data: rowPrice),
//          pw.ListView.builder(
//            itemBuilder: (pw.Context context, index) {
//              return pw.Table.fromTextArray(
//                context: context,
//                data: <List<String>>[
//                  <String>['Kode Item', 'Model Kendaraan', 'Dalam Kota', 'Tanggal', 'Harga'],
//                  <String>['${value.pricelists[index].itemCode}', '${value.pricelists[index].itemModel}', '${value.pricelists[index].dalamKota}', '${value.pricelists[index].pricelistTanggal}', 'Rp ${CurrencyFormat().data.format(value.pricelists[index].ontr)}'],
//                ],
//              );
//            },
//           itemCount: value.pricelists.length
//          ),
            pw.Padding(padding: const pw.EdgeInsets.all(10)),
            pw.Paragraph(text: 'Stock'),
            pw.Table.fromTextArray(context: context, data: rowStock),
//          pw.ListView.builder(
//              itemBuilder: (pw.Context context, index) {
//                return pw.Table.fromTextArray(
//                  context: context,
//                  data: <List<String>>[
//                    <String>['Tahun', 'Jumlah', 'Warna'],
//                    <String>['${value.stocks[index].tahun}', '${value.stocks[index].quantity}', '${value.stocks[index].namaWarna}'],
//                  ],
//                );
//              },
//              itemCount: value.stocks.length
//          ),
            pw.Padding(padding: const pw.EdgeInsets.all(10)),
            pw.Text(
              '*Harga tidak terikat, sewaktu-waktu dapat berubah.',
              style: pw.TextStyle(
                fontSize: 5,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ];
        }));
    final directory = await getExternalStorageDirectory();
    log.info(directory.path);

    final file = File('${directory.path}/price-list.pdf');
    file.writeAsBytesSync(pdf.save());

    OpenFile.open('${directory.path}/price-list.pdf');
  }

  void exportPdfToImage(Datum value) async {
    rowPrice.clear();
    rowStock.clear();

    final pdf = pw.Document();
    rowPrice.add(
      <String>[
        'Kode Item',
        'Model Kendaraan',
        'Dalam Kota',
        'Tanggal',
        'Harga'
      ],
    );
    rowStock.add(<String>['Tahun', 'Jumlah', 'Warna', 'Warehouse']);

    value.pricelists.forEach((f) {
      List<String> price = <String>[
        f.itemCode,
        f.itemModel,
        f.dalamKota,
        f.pricelistTanggal.toString(),
        CurrencyFormat().data.format(f.ontr)
      ];
      rowPrice.add(price);
    });

    value.stocks.forEach((f) {
      List<String> stock = <String>[
        f.tahun,
        f.quantity.toString(),
        f.namaWarna,
        f.whsName,
      ];
      rowStock.add(stock);
    });

    ByteData bytes =
    await rootBundle.load('assets/icons/old_hasjrat_toyota_logo.png');
    File imgLogo;
    try {
      imgLogo = await writeToFile(bytes); // <= returns File
    } catch (e) {
      // catch errors here
    }

    final image = PdfImage.file(
      pdf.document,
      bytes: imgLogo.readAsBytesSync(),
    );

    pdf.addPage(pw.MultiPage(
        pageFormat:
        PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
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
            child: pw.Text(
              'Price List',
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
                    pw.Text(' Data Price List & Stock', textScaleFactor: 2),
                    pw.Container(
                      height: 50,
                      width: 100,
                      child: pw.Image(image),
                    ),
                  ]),
            ),
            pw.Paragraph(text: 'Price List'),
            pw.Table.fromTextArray(context: context, data: rowPrice),
//          pw.ListView.builder(
//            itemBuilder: (pw.Context context, index) {
//              return pw.Table.fromTextArray(
//                context: context,
//                data: <List<String>>[
//                  <String>['Kode Item', 'Model Kendaraan', 'Dalam Kota', 'Tanggal', 'Harga'],
//                  <String>['${value.pricelists[index].itemCode}', '${value.pricelists[index].itemModel}', '${value.pricelists[index].dalamKota}', '${value.pricelists[index].pricelistTanggal}', 'Rp ${CurrencyFormat().data.format(value.pricelists[index].ontr)}'],
//                ],
//              );
//            },
//           itemCount: value.pricelists.length
//          ),
            pw.Padding(padding: const pw.EdgeInsets.all(10)),
            pw.Paragraph(text: 'Stock'),
            pw.Table.fromTextArray(context: context, data: rowStock),
//          pw.ListView.builder(
//              itemBuilder: (pw.Context context, index) {
//                return pw.Table.fromTextArray(
//                  context: context,
//                  data: <List<String>>[
//                    <String>['Tahun', 'Jumlah', 'Warna'],
//                    <String>['${value.stocks[index].tahun}', '${value.stocks[index].quantity}', '${value.stocks[index].namaWarna}'],
//                  ],
//                );
//              },
//              itemCount: value.stocks.length
//          ),
            pw.Padding(padding: const pw.EdgeInsets.all(10)),
            pw.Text(
              '*Harga tidak terikat, sewaktu-waktu dapat berubah.',
              style: pw.TextStyle(
                fontSize: 5,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ];
        }));
    final directory = await getExternalStorageDirectory();
    log.info(directory.path);

    final file = File('${directory.path}/price-list.pdf');
    file.writeAsBytesSync(pdf.save());

    final document = await npr.PdfDocument.openFile(file.path);
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: page.height);

    final fileImg = File('${directory.path}/price-list.jpg');
    fileImg.writeAsBytesSync(pageImage.bytes);
    await page.close();

    OpenFile.open('${directory.path}/price-list.jpg');
//    OpenFile.open('${directory.path}/price-list.pdf');
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath +
        '/file_logo.tmp'; // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
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
          "Harga & Stok",
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "List Stock",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              state.value.data[0].stocks.isEmpty
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text("Tidak Tersedia"),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text("Tahun",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text("Warna",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text("Warehouse",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                              "Qty",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                      ],
                                                    ),
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: state
                                                          .value
                                                          .data[0]
                                                          .stocks
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Column(
                                                          children: <Widget>[
                                                            Row(
                                                              children: <Widget>[
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                      "${state.value.data[0].stocks[index].tahun}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: Text(
                                                                      "${state.value.data[0].stocks[index].namaWarna}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: Text(
                                                                      "${state.value.data[0].stocks[index].whsName}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                      "  ${state.value.data[0].stocks[index].quantity}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                              ],
                                                            ),
                                                             Padding(
                                                                padding:
                                                                    const EdgeInsets.only(bottom: 5),
                                                                child: Divider(
                                                                  color: Colors.grey[100],
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Divider(
                                            color: Colors.grey[100],
                                            thickness: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Jumlah Stock = ${state.value.data[0].stocks.length} Unit",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: RaisedButton.icon(
                          onPressed: () {
                            exportPdf(state.value.data[0]);
                          },
                          icon: Icon(
                            Icons.file_download,
                            color: Colors.white,
                          ),
                          color: HexColor('#C61818'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          label: Text(
                            "Export PDF",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: RaisedButton.icon(
                          onPressed: () {
                            exportPdfToImage(state.value.data[0]);
                          },
                          icon: Icon(
                            Icons.file_download,
                            color: Colors.white,
                          ),
                          color: HexColor('#C61818'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          label: Text(
                            "Export JPG",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
