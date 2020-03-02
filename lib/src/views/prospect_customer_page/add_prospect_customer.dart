import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/regex_file.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class ProspectAddView extends StatefulWidget {
  @override
  _ProspectAddViewState createState() => _ProspectAddViewState();
}

class _ProspectAddViewState extends State<ProspectAddView> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  String _currentSelectContext;
  String _currentSelectColor;

  var customerNameCtrl = new TextEditingController();
  var customerNIKCtrl = new TextEditingController();

  File imageFile;
  final TextRecognizer textRecognizer =
      FirebaseVision.instance.textRecognizer();

  void _onPickImage() async {
    final scaffold = _scaffoldKey.currentState;

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
        imageFile = fileCropper;
      });

      final FirebaseVisionImage visionImage =
          FirebaseVisionImage.fromFile(fileCropper);
      final VisionText visionText =
          await textRecognizer.processImage(visionImage);

      String text = visionText.text;

      setState(() {
        customerNameCtrl.text = visionText.blocks[3].text;
      });

      for (TextBlock block in visionText.blocks) {

        for (TextLine line in block.lines) {
          for (TextElement element in line.elements) {
            setState(() {
              customerNIKCtrl.text = Regex.isValidationNIK(block.text);
            });
          }
        }
      }
    } catch (e) {
      scaffold.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
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
          "Add Prospect",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dropdownMenu(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Container(
                height: 180,
                width: screenWidth(context),
                child: imageFile == null
                    ? DottedBorder(
                        strokeWidth: 1,
                        color: Colors.grey,
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.add),
                            iconSize: 45,
                            color: HexColor('#E07B36'),
                            onPressed: () {
                              _onPickImage();
                            },
                          ),
                        ),
                      )
                    : Image.file(
                        imageFile,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            formNamaCusotmer(),
            formNIK(),
            formContact(),
            formEmail(),
            formAlamat(),
            formSelectVehicle(),
            formSelectVehicleType(),
            dropdownMenuColor(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 10),
              child: Container(
                width: screenWidth(context),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Create",
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

  Widget dropdownMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              hintText: 'Context Type',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              errorText: 'Context Type harus diisi',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentSelectContext,
                hint: Text('Context Type'),
                isDense: true,
                onChanged: (String newVal) {
                  setState(() {
                    _currentSelectContext = newVal;
                    state.didChange(newVal);
                  });
                },
                items: ["Context", "Prospect", "Hot Prospect"].map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(val),
                        Text(
                          " ● ",
                          style: TextStyle(color: val == "Context" ? Colors.orangeAccent : val == "Prospect" ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget dropdownMenuColor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              hintText: 'Warna',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              errorText: 'Warna harus diisi',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentSelectColor,
                hint: Text('Warna'),
                isDense: true,
                onChanged: (String newVal) {
                  setState(() {
                    _currentSelectColor = newVal;
                    state.didChange(newVal);
                  });
                },
                items: ["Merah", "Hitam", "Putih"].map((String val) {
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

  Widget formNamaCusotmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Nama Customer',
          errorText: 'Nama customer harus diisi',
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
        controller: customerNameCtrl,
      ),
    );
  }

  Widget formNIK() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'NIK',
          errorText: 'NIK 16 character',
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
        controller: customerNIKCtrl,
      ),
    );
  }

  Widget formContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'No. Telp',
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
      ),
    );
  }

  Widget formEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Email',
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
      ),
    );
  }

  Widget formAlamat() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Alamat',
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

  Widget formSelectVehicle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Vehicle',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
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

  Widget formSelectVehicleType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Vehicle Type',
          suffixIcon: Icon(Icons.navigate_next, color: Colors.red),
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
}
