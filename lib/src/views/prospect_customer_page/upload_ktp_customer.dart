import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/regex_file.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/prospect_customer_page/add_prospect_customer.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';

class UploadKTPCustomerView extends StatefulWidget {
  @override
  _UploadKTPCustomerViewState createState() => _UploadKTPCustomerViewState();
}

class _UploadKTPCustomerViewState extends State<UploadKTPCustomerView> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  Image currentPreviewImage;
  String namaScan, nikScan, ttlScan, genderScan, alamatScan, agamaScan;

  int loopIndex = 0;

  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

  void _onAddProspectCustomer() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ProspectAddView(
          nameScan: namaScan,
          nikScan: nikScan,
        ),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  void _onSelectCamera() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Pilih Kamera'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _onManual();
              },
              child: Text('Manual Kamera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _onScanner();
              },
              child: Text('Scaner Camera'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        );
      },
    );
  }

  void _onManual() async {
    final scaffold = _scaffoldKey.currentState;
    setState(() {
      nikScan = null;
      namaScan = null;
      loopIndex = 0;
    });

    try {
      final file = await ImagePicker.pickImage(source: ImageSource.camera);
      if (file == null) {
        throw Exception('File is not available');
      }

      var fileCropper = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'KTP Cropper',
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          showCropGrid: true,
          toolbarColor: HexColor('#E07B36'),
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );

      setState(() {
        currentPreviewImage = Image.file(File(fileCropper.path));
      });

      final FirebaseVisionImage visionImage =
      FirebaseVisionImage.fromFile(fileCropper);
      final VisionText visionText =
      await textRecognizer.processImage(visionImage);

      String text = visionText.text;
      for (TextBlock block in visionText.blocks) {
        log.info("Block Data : ${block.text}");
        if (nikScan == null) {
          setState(() {
            nikScan = Regex.isValidationNIK(block.text);
          });
        }

        if (loopIndex <= 4) {
          log.info(loopIndex);
          setState(() {
            loopIndex = loopIndex + 1;
            namaScan = block.text;
          });
        }
        print("NIK : $nikScan");
        print("Nama : $namaScan");
        for (TextLine line in block.lines) {
          for (TextElement element in line.elements) {}
        }
      }
    } catch (e) {
      scaffold.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }

  }

  void _onScanner() async {
    setState(() {
      nikScan = null;
      namaScan = null;
      loopIndex = 0;
    });

    var config = DocumentScannerConfiguration(
      multiPageEnabled: false,
      bottomBarBackgroundColor: HexColor('#E07B36'),
      multiPageButtonHidden: true,
      cancelButtonTitle: "Cancel",
    );
    var result = await ScanbotSdkUi.startDocumentScanner(config);

    if (result.operationResult == OperationResult.SUCCESS) {
      setState(() {
        currentPreviewImage = Image.file(File.fromUri(result.pages[0].documentImageFileUri));
      });

      final FirebaseVisionImage visionImage =
      FirebaseVisionImage.fromFilePath(result.pages[0].documentImageFileUri.path);
      final VisionText visionText =
      await textRecognizer.processImage(visionImage);

      String text = visionText.text;
      for (TextBlock block in visionText.blocks) {
        log.info("Block Data : ${block.text}");
        if (nikScan == null) {
          setState(() {
            nikScan = Regex.isValidationNIK(block.text);
          });
        }

        if (loopIndex <= 4) {
          log.info(loopIndex);
          setState(() {
            loopIndex = loopIndex + 1;
            namaScan = block.text;
          });
        }
        print("NIK : $nikScan");
        print("Nama : $namaScan");
        for (TextLine line in block.lines) {
          for (TextElement element in line.elements) {
          }
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textRecognizer.close();
    super.dispose();
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
          "Upload KTP",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 180,
                    width: screenWidth(context),
                    child: currentPreviewImage == null
                        ? DottedBorder(
                      strokeWidth: 1,
                      color: Colors.grey,
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.add),
                          iconSize: 45,
                          color: HexColor('#E07B36'),
                          onPressed: () {
                            _onSelectCamera();
//                            _onPickImage();
                          },
                        ),
                      ),
                    )
                        : currentPreviewImage,
                  ),
                  currentPreviewImage == null ? SizedBox() : Positioned(
                    bottom: 0,
                    right: 0,
                    child: FloatingActionButton(
                      onPressed: () {
                        _onSelectCamera();
                      },
                      mini: true,
                      child: Icon(Icons.add),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Nama KTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      namaScan == null ? "-" : "$namaScan",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Nomor Induk KTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      nikScan == null ? "-" : "$nikScan",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Tempat, Tgl Lahir",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      ttlScan == null ? "-" : "$ttlScan",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Jenis Kelamin",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      genderScan == null ? "-" : "$genderScan",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Agama",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      agamaScan == null ? "-" : "$agamaScan",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Alamat KTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      alamatScan == null ? "-" : "$alamatScan",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            currentPreviewImage == null ? SizedBox() : Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 10),
              child: Container(
                width: screenWidth(context),
                child: RaisedButton(
                  onPressed: () {
                    _onAddProspectCustomer();
                  },
                  child: Text(
                    "NEXT",
                    style: TextStyle(color: Colors.white),
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
    );
  }
}
