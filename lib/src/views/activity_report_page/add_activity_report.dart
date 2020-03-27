import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class AddActivityReportView extends StatefulWidget {
  @override
  _AddActivityReportViewState createState() => _AddActivityReportViewState();
}

class _AddActivityReportViewState extends State<AddActivityReportView> {
  var titleCtrl = new TextEditingController();

  final dateFormat = DateFormat("dd MMMM yyyy");
  DateTime _dateTime = DateTime.now();

  var dateSelected = new TextEditingController();
  var notesCtrl = new TextEditingController();

  var dateSelectedFocus = new FocusNode();
  var noteFocus = new FocusNode();

  File image1;
  File image2;
  File image3;
  File image4;
  List<SourceImg> uploadImgList = [];

  Future selectFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    File croppedImg = await ImageCropper.cropImage(sourcePath: image.path, maxWidth: 512, maxHeight: 512);

    if (image1 == null) {
      image1 = croppedImg;
      String dir = path.dirname(image1.path);
      String rename = path.join(dir, 'file-upload-1.jpg');

      image1.renameSync(rename);
      uploadImgList.add(SourceImg(title: image1.path.split("/").last, size: "0MB"));
      setState(() {});
    } else if (image2 == null) {
      image2 = croppedImg;
      String dir = path.dirname(croppedImg.path);
      String rename = path.join(dir, 'file-upload-2.jpg');

      image2.renameSync(rename);
      uploadImgList.add(SourceImg(title: image2.path.split("/").last, size: "0MB"));
      setState(() {});
    } else if (image3 == null) {
      image3 = croppedImg;
      String dir = path.dirname(croppedImg.path);
      String rename = path.join(dir, 'file-upload-3.jpg');

      image3.renameSync(rename);
      uploadImgList.add(SourceImg(title: image3.path.split("/").last, size: "0MB"));
      setState(() {});
    } else if (image4 == null) {
      image4 = croppedImg;
      String dir = path.dirname(croppedImg.path);
      String rename = path.join(dir, 'file-upload-5.jpg');

      image4.renameSync(rename);
      uploadImgList.add(SourceImg(title: image4.path.split("/").last, size: "0MB"));
      setState(() {});
    }
  }

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100),
    );

    if (picked != null)
      setState(() {
        _dateTime = picked;
        dateSelected.value =
            TextEditingValue(text: dateFormat.format(picked).toString());
      });
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
          "Add Activity Report",
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
            SizedBox(
              height: 15,
            ),
            selectPhoto(),
            uploadImgList.length < 1 ? SizedBox() : listPhoto(),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Judul",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            formTitle(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Tanggal",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            formDatePicker(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Lokasi Kejadian",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            formLocation(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Deskripsi",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            formNote(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: screenWidth(context),
                child: RaisedButton(
                  onPressed: () {},
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
          ],
        ),
      ),
    );
  }

  Widget formTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 17),
                  hintText: "Tulis Judul",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: titleCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
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
                  _selectedDate(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 18),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Tanggal",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: dateSelected,
                    focusNode: dateSelectedFocus,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 17),
                  hintText: "Masukan Lokasi",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formNote() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Notes",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: notesCtrl,
                maxLines: 6,
                focusNode: noteFocus,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget selectPhoto() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: DottedBorder(
          color: HexColor("#C61818"),
          strokeWidth: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.cloud_upload,
                        color: HexColor("#C61818"),
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Upload Foto Kejadian',
                          style: TextStyle(
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: selectFromCamera,
                    child: Text(
                      'BROWSE IMG',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: HexColor("#C61818"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listPhoto() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
            top: BorderSide(color: Colors.grey),
            left: BorderSide(color: Colors.grey),
            right: BorderSide(color: Colors.grey),
          ),
        ),
        child: ListView.builder(
          itemCount: uploadImgList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var value = uploadImgList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${value.title}'),
                            Text('${value.size}'),
                          ],
                        ),
                      ),
                      Icon(Icons.cancel, color: Colors.red),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SourceImg {
  String title;
  String size;

  SourceImg({this.title, this.size});
}
