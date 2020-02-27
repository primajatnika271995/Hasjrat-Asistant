import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';

class ProfileEditView extends StatefulWidget {
  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  static const String CAMERA_SOURCE = 'CAMERA_SOURCE';
  static const String GALLERY_SOURCE = 'GALLERY_SOURCE';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var namaCtrl = new TextEditingController();
  var tglLahirCtrl = new TextEditingController();
  var jenisKelaminCtrl = new TextEditingController();
  var branchCtrl = new TextEditingController();
  var outletCtrl = new TextEditingController();
  var sectionCtrl = new TextEditingController();

  File _imageSelect;

  void _onPickImageSelected(String source) async {
    var imageSource;
    if (source == CAMERA_SOURCE) {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final scaffold = _scaffoldKey.currentState;

    try {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file == null) {
        throw Exception('File is not available');
      }

      final fileCropper = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Profile Image Cropper',
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            showCropGrid: true,
            toolbarColor: HexColor('#E07B36'),
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );

      setState(() {
        _imageSelect = fileCropper;
      });
    } catch (e) {
      scaffold.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  void getPreferences() async {
      namaCtrl.text = await SharedPreferencesHelper.getSalesName();
      tglLahirCtrl.text = await SharedPreferencesHelper.getSalesBirthday();
      jenisKelaminCtrl.text = await SharedPreferencesHelper.getSalesGender();
      branchCtrl.text = await SharedPreferencesHelper.getSalesBrach();
      outletCtrl.text = await SharedPreferencesHelper.getSalesOutlet();
      sectionCtrl.text = await SharedPreferencesHelper.getSalesJob();
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
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Edit Profile",
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
            profileImage(),
            namaField(),
            tmptTglLahirField(),
            jenisKelaminField(),
            contactField(),
            emailField(),
            alamatField(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 50, bottom: 10),
              child: Container(
                width: screenWidth(context),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
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

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          children: <Widget>[
            Hero(
              tag: "profile-image",
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: _imageSelect == null
                    ? NetworkImage(
                        "https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg")
                    : FileImage(_imageSelect),
              ),
            ),
            FlatButton(
              onPressed: () {
                _onPickImageSelected(GALLERY_SOURCE);
              },
              child: Text(
                "Change Profile Photo",
                style: TextStyle(
                  color: HexColor('#E07B36'),
                  letterSpacing: 0.5,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget namaField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Nama',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: namaCtrl,
      ),
    );
  }

  Widget tmptTglLahirField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Tanggal Lahir',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: tglLahirCtrl,
      ),
    );
  }

  Widget jenisKelaminField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Jenis Kelamin',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: jenisKelaminCtrl,
      ),
    );
  }

  Widget contactField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Nama Branch',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: branchCtrl,
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Lokasi Penempatan',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: outletCtrl,
      ),
    );
  }

  Widget alamatField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Posisi',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: sectionCtrl,
      ),
    );
  }
}
