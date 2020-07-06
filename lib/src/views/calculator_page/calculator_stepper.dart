import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_event.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_state.dart';
import 'package:salles_tools/src/models/asset_price_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/models/simulation_model.dart' as simulation;
import 'package:salles_tools/src/utils/currency_format.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:native_pdf_renderer/native_pdf_renderer.dart' as npr;

class CalculatorStepperScreen extends StatefulWidget {
  @override
  _CalculatorStepperScreenState createState() =>
      _CalculatorStepperScreenState();
}

class _CalculatorStepperScreenState extends State<CalculatorStepperScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentStep = 0;

  List<List<String>> rowTenor = new List();

  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  var dpVehicleCtrl = MoneyMaskedTextController(
      leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');
  int priceSelection = -1;

  var methodeCtrl = new TextEditingController();
  String currentSelectMethode;
  List<String> methodeList = [
    "Down Payment",
    "Price List",
  ];

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
        if (dpVehicleCtrl.numberValue < 1 ||
            dpVehicleCtrl.numberValue <
                double.parse(dpMinimum.replaceAll(".", "")) ||
            dpVehicleCtrl.numberValue >
                double.parse(dpMaximum.replaceAll(".", ""))) {
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
          simulationBloc.add(FetchSimulationDownPayment(
              branchCode,
              "ASK01",
              "ASIPC",
              assetGroupCode,
              assetTypeCode,
              priceListId,
              priceOriginal,
              (dpVehicleCtrl.numberValue / 10).toString()));
        }
        break;
      case "Price List":
        if (priceListId == null || priceOriginal == null) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.info_outline),
                  ),
                  Expanded(
                    child: Text("Select Price List before Calculate!"),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // ignore: close_sinks
          final simulationBloc = BlocProvider.of<FinanceBloc>(context);
          simulationBloc.add(FetchSimulationPriceList(
              branchCode,
              "ASK01",
              "ASIPC",
              assetGroupCode,
              assetTypeCode,
              priceListId,
              priceOriginal));
          break;
        }
    }
  }

  void _showListPayment() {
    SelectDialog.showModal<String>(
      context,
      label: "Payment",
      selectedValue: currentSelectMethode,
      items: methodeList,
      showSearchBox: false,
      onChange: (String selected) {
        setState(() {
          currentSelectMethode = selected;
          methodeCtrl.text = selected;
        });
      },
    );
  }

  void _showListBranch() {
    SelectDialog.showModal<SelectorBranchModel>(
      context,
      label: "Nama Branch",
      selectedValue: currentSelectBranch,
      items: branchList,
      showSearchBox: false,
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
      label: "Nama Outlet",
      selectedValue: currentSelectOutlet,
      items: outletList,
      showSearchBox: false,
      onChange: (SelectorOutletModel selected) {
        setState(() {
          assetKindList = [];
          currentSelectOutlet = selected;
          outletNameCtrl.text = selected.outletName;
          outletCode = selected.id;

//          // ignore: close_sinks
//          final assetKindBloc = BlocProvider.of<FinanceBloc>(context);
//          assetKindBloc.add(FetchAssetKind(branchCode));

          // ignore: close_sinks
          final assetGroupBloc = BlocProvider.of<FinanceBloc>(context);
          assetGroupBloc.add(FetchAssetGroup(branchCode, "ASK01", "ASIPC"));
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
      showSearchBox: false,
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
      showSearchBox: false,
      onChange: (SelectorInsuranceTypeModel selected) {
        setState(() {
          assetGroupList = [];
          currentSelectInsuranceType = selected;
          insuranceTypeCtrl.text = selected.insuranceTypeName;
          insuranceTypeCode = selected.id;

          // ignore: close_sinks
          final assetGroupBloc = BlocProvider.of<FinanceBloc>(context);
          assetGroupBloc.add(FetchAssetGroup(branchCode, "ASK01", "ASIPC"));
        });
      },
    );
  }

  void _showListAssetGroup() {
    SelectDialog.showModal<SelectorAssetGroupModel>(
      context,
      label: "Kendaraan",
      selectedValue: currentSelectAssetGroup,
      items: assetGroupList,
      showSearchBox: false,
      onChange: (SelectorAssetGroupModel selected) {
        setState(() {
          assetTypeList = [];
          currentSelectAssetGroup = selected;
          assetGroupCtrl.text = selected.assetGroupCode;
          assetGroupCode = selected.assetGroupCode;

          // ignore: close_sinks
          final assetTypeBloc = BlocProvider.of<FinanceBloc>(context);
          assetTypeBloc.add(
              FetchAssetType(branchCode, "ASK01", "ASIPC", assetGroupCode));
        });
      },
    );
  }

  void _showListAssetType() {
    SelectDialog.showModal<SelectorAssetTypeModel>(
      context,
      label: "Tipe",
      selectedValue: currentSelectAssetType,
      items: assetTypeList,
      showSearchBox: false,
      onChange: (SelectorAssetTypeModel selected) {
        setState(() {
          _assetPriceModel = null;
          priceSelection = -1;
          currentSelectAssetType = selected;
          assetTypeCtrl.text = selected.assetTypeName;
          assetTypeCode = selected.assetTypeCode;

          // ignore: close_sinks
          final assetPriceBloc = BlocProvider.of<FinanceBloc>(context);
          assetPriceBloc.add(FetchAssetPrice(
              branchCode, "ASK01", "ASIPC", assetGroupCode, assetTypeCode));
        });
      },
    );
  }

  void exportPdf(List<simulation.Result> value) async {
    rowTenor.clear();
    final pdf = pw.Document();

    rowTenor.add(<String>[
      'Nama Tenor',
      'Lama Tenor',
      'Uang Muka',
      'Pembayaran Bulanan'
    ]);

    value.forEach((f) {
      List<String> tenor = <String>[
        f.tenorName,
        f.tenorVale.toString(),
        f.downPayment,
        'Rp ${f.installment} / Bulan'
      ];
      rowTenor.add(tenor);
    });

    ByteData bytes =
        await rootBundle.load('assets/icons/old_hasjrat_toyota_logo.png');
    File imgLogo;
    try {
      imgLogo = await writeToFile(bytes);
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
              'Tenor List',
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
                    pw.Text('Data Tenor', textScaleFactor: 2),
                    pw.Container(
                      height: 50,
                      width: 100,
                      child: pw.Image(image),
                    ),
                  ]),
            ),
            pw.Paragraph(text: 'Tenor List'),
            pw.Table.fromTextArray(context: context, data: rowTenor),
//            pw.ListView.builder(
//                itemBuilder: (pw.Context context, index) {
//                  return pw.Table.fromTextArray(
//                    context: context,
//                    data: <List<String>>[
//                      <String>['Nama Tenor', 'Lama Tenor', 'Uang Muka', 'Pembayaran Bulanan'],
//                      <String>['${value[index].tenorName}', '${value[index].tenorVale}', 'Rp ${value[index].downPayment}', 'Rp ${value[index].installment} / Bulan'],
//                    ],
//                  );
//                },
//                itemCount: value.length
//            ),
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

    final file = File('${directory.path}/tenor.pdf');
    file.writeAsBytesSync(pdf.save());

    OpenFile.open('${directory.path}/tenor.pdf');
  }

  void exportPdfToJpg(List<simulation.Result> value) async {
    rowTenor.clear();
    final pdf = pw.Document();

    rowTenor.add(<String>[
      'Nama Tenor',
      'Lama Tenor',
      'Uang Muka',
      'Pembayaran Bulanan'
    ]);

    value.forEach((f) {
      List<String> tenor = <String>[
        f.tenorName,
        f.tenorVale.toString(),
        f.downPayment,
        'Rp ${f.installment} / Bulan'
      ];
      rowTenor.add(tenor);
    });

    ByteData bytes =
    await rootBundle.load('assets/icons/old_hasjrat_toyota_logo.png');
    File imgLogo;
    try {
      imgLogo = await writeToFile(bytes);
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
              'Tenor List',
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
                    pw.Text('Data Tenor', textScaleFactor: 2),
                    pw.Container(
                      height: 50,
                      width: 100,
                      child: pw.Image(image),
                    ),
                  ]),
            ),
            pw.Paragraph(text: 'Tenor List'),
            pw.Table.fromTextArray(context: context, data: rowTenor),
//            pw.ListView.builder(
//                itemBuilder: (pw.Context context, index) {
//                  return pw.Table.fromTextArray(
//                    context: context,
//                    data: <List<String>>[
//                      <String>['Nama Tenor', 'Lama Tenor', 'Uang Muka', 'Pembayaran Bulanan'],
//                      <String>['${value[index].tenorName}', '${value[index].tenorVale}', 'Rp ${value[index].downPayment}', 'Rp ${value[index].installment} / Bulan'],
//                    ],
//                  );
//                },
//                itemCount: value.length
//            ),
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

    final file = File('${directory.path}/tenor.pdf');
    file.writeAsBytesSync(pdf.save());

    final document = await npr.PdfDocument.openFile(file.path);
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: page.height);

    final fileImg = File('${directory.path}/price-list.jpg');
    fileImg.writeAsBytesSync(pageImage.bytes);
    await page.close();

    OpenFile.open('${directory.path}/price-list.jpg');

//    OpenFile.open('${directory.path}/tenor.pdf');
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

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }

  void getPreferences() async {
    currentSelectBranch = await SharedPreferencesHelper.getSalesBrach();
    branchNameCtrl.text = currentSelectBranch;

    // ignore: close_sinks
    final branchBloc = BlocProvider.of<FinanceBloc>(context);
    branchBloc.add(FetchBranch());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor('#C61818'),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Kalkulator",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<FinanceBloc, FinanceState>(
        listener: (context, state) {
          if (state is BranchSuccess) {
            state.value.result.forEach((f) {
              if (f.text == currentSelectBranch) {
                branchCode = f.id;

                log.info("Branch Code : $branchCode");

                // ignore: close_sinks
                final branchBloc = BlocProvider.of<FinanceBloc>(context);
                branchBloc.add(FetchOutlet(branchCode));
              }
            });
          }

          if (state is OutletSuccess) {
            var newVal = state.value.result.map((data) {
              if (data.text == "Manado") {
                data.text = "Manado Sudirman";
              }
              if (data.text == "Tendean") {
                data.text = "Manado Tendean";
              }
              if (data.text == "Bitung 3S") {
                data.text = "Bitung";
              }
              if (data.text == "tyt limboto") {
                data.text = "Limboto";
              }
              if (data.text == "Palu") {
                data.text = "Palu Diponegoro";
              }
              if (data.text == "Mutiara") {
                data.text = "Palu Mutiara";
              }
              if (data.text == "TYT Limboto") {
                data.text = "Toyota Limboto";
              }

              return data;
            });
            newVal.forEach((f) {
              if (f.text == "Manado Sudirman" ||
                  f.text == "Manado Tendean" ||
                  f.text == "Bitung" ||
                  f.text == "Kotamobagu" ||
                  f.text == "Gorontalo" ||
                  f.text == "Kabila" ||
                  f.text == "Toyota Limboto" ||
                  f.text == "Kwandang" ||
                  f.text == "GTO Paguyaman" ||
                  f.text == "Marisa" ||
                  f.text == "Limboto" ||
                  f.text == "Palu Diponegoro" ||
                  f.text == "Parigi" ||
                  f.text == "Palu Mutiara" ||
                  f.text == "Luwuk" ||
                  f.text == "Toili" ||
                  f.text == "Ambon" ||
                  f.text == "Tual" ||
                  f.text == "Sorong" ||
                  f.text == "Jayapura" ||
                  f.text == "Merauke" ||
                  f.text == "Latumahina" ||
                  f.text == "Tual" ||
                  f.text == "Biak" ||
                  f.text == "Serui" ||
                  f.text == "Namlea" ||
                  f.text == "Timika" ||
                  f.text == "Nabire" ||
                  f.text == "Biak" ||
                  f.text == "Serui" ||
                  f.text == "Ternate" ||
                  f.text == "Sentani" ||
                  f.text == "Toyota Abepura" ||
                  f.text == "Aimas" ||
                  f.text == "Dumoga" ||
                  f.text == "Sorong" ||
                  f.text == "Kotamobagu" ||
                  f.text == "Mutiara" ||
                  f.text == "Parigi" ||
                  f.text == "Luwuk" ||
                  f.text == "Toili" ||
                  f.text == "Marisa" ||
                  f.text == "Tilamuta" ||
                  f.text == "Tobelo") {
                outletList
                    .add(SelectorOutletModel(id: f.id, outletName: f.text));
              }
            });
          }

          if (state is AssetKindSuccess) {
            state.value.result.forEach((f) {
              if (f.text == "Mobil") {
                assetKindList.add(
                  SelectorAssetKindModel(
                    id: f.id,
                    assetKindName: f.text,
                  ),
                );
              }
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
            Theme(
              data: ThemeData(
                canvasColor: HexColor('#C61818'),
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
                    isActive: _currentStep == 0 ? true : false,
                    title: Text(
                      "Kendaraan",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Branch",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            )),
                        formSelectBranch(),
                        Text("Outlet",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            )),
                        formSelectOutlet(),
//                        Text("Asset Kind", style: TextStyle(
//                          fontWeight: FontWeight.w700,
//                          letterSpacing: 1.0,
//                        )),
//                        formSelectAssetKind(),
//                        Text("Insurance", style: TextStyle(
//                          fontWeight: FontWeight.w700,
//                          letterSpacing: 1.0,
//                        )),
//                        formSelectInsuranceType(),
                        Text("Kendaraan",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            )),
                        formSelectAssetGroup(),
                        Text("Tipe",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            )),
                        formSelectAssetType(),
                      ],
                    ),
                  ),
                  Step(
                    isActive: _currentStep == 1 ? true : false,
                    title: Text(
                      "Kategori",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: stepCategory(),
                  ),
                  Step(
                    isActive: _currentStep == 2 ? true : false,
                    title: Text(
                      "Tenor",
                      style: TextStyle(color: Colors.white),
                    ),
                    state: StepState.complete,
                    content: stepTenor(),
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

  Widget formSelectBranch() {
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
//                  _showListBranch();
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
                        Icons.local_convenience_store,
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

  Widget formSelectOutlet() {
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
                  _showListOutlet();
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

  Widget formSelectAssetKind() {
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
                  _showListAssetKind();
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
                        Icons.merge_type,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Select Asset Kind",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: assetKindCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectInsuranceType() {
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
                  _showListInsuranceType();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 18),
                      prefixIcon: Icon(
                        Icons.invert_colors,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Select Insurance",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: insuranceTypeCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectAssetGroup() {
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
                  _showListAssetGroup();
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
                        Icons.group_work,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Kendaraan",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: assetGroupCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectAssetType() {
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
                  _showListAssetType();
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
                        Icons.directions_car,
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
                    controller: assetTypeCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget selectedMethode() {
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
                  _showListPayment();
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
                      hintText: "Pilih tipe Simulasi",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: methodeCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formDP() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Rp',
        labelText: 'Uang (DP)',
        labelStyle: TextStyle(
          color: HexColor('#C61818'),
          fontWeight: FontWeight.w400,
        ),
        hasFloatingPlaceholder: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#C61818'),
            width: 1,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#C61818'),
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#C61818'),
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
                        initiallyExpanded:
                            priceSelection == index ? true : false,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Start Date"),
                                Text("${value.startDate}"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("End Date"),
                                Text("${value.endDate}"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Minimum DP"),
                                Text(
                                    "Rp ${value.dpBottomLimit} (${value.dpBottomLimitPercentage} %)"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Maximum DP"),
                                Text(
                                    "Rp ${value.dpTopLimit} (${value.dpTopLimitPercentage} %)"),
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
                                        ? "Dipilih"
                                        : "Pilih",
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
                    padding: const EdgeInsets.only(right: 25, top: 10),
                    child: Text(
                      "Tipe Simulasi",
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
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                _onCalculateSimulator();
                              },
                              child: Text(
                                "Hitung",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: RaisedButton.icon(
                          onPressed: () {
                            exportPdf(state.value.result);
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
                            exportPdfToJpg(state.value.result);
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
                  SizedBox(
                    height: 30,
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
