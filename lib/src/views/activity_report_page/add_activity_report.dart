import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' as path;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_bloc.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_event.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_state.dart';
import 'package:salles_tools/src/services/activity_report_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:salles_tools/src/models/selector_model.dart';

class AddActivityReportView extends StatefulWidget {
  @override
  _AddActivityReportViewState createState() => _AddActivityReportViewState();
}

class _AddActivityReportViewState extends State<AddActivityReportView> {
  bool _hasSpeech = false;
  double level = 0.0;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "in_ID";
  final SpeechToText speech = SpeechToText();

  String branchCode;
  String outletCode;

  Location location = new Location();

  var _formKey = GlobalKey<FormState>();

  var titleCtrl = new TextEditingController();
  var dateSelected = new TextEditingController();
  var notesCtrl = new TextEditingController();
  var latitudeCtrl = new TextEditingController();
  var longitudeCtrl = new TextEditingController();
  var alamatCtrl = new TextEditingController();

  DateTime _dateTime = DateTime.now();

  var dateSelectedFocus = new FocusNode();
  var noteFocus = new FocusNode();

  File image1;
  File image2;
  File image3;
  File image4;
  List<SourceImg> uploadImgList = [];

  var customerProvinceCtrl = new TextEditingController();
  var currentSelectProvince;
  var provinceCode;
  List<SelectorProvinceModel> provinceList = [];

  var customerDistrictCtrl = new TextEditingController();
  var currentSelectDistrict;
  var districtCode;
  List<SelectorDistrictModel> districtList = [];

  var customerSubDistrictCtrl = new TextEditingController();
  var currentSelectSubDistrict;
  var districtSubCode;
  List<SelectorSubDistrictModel> districtSubList = [];

  Future selectFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    File croppedImg = await ImageCropper.cropImage(
        sourcePath: image.path, maxWidth: 512, maxHeight: 512);

    if (image1 == null) {
      image1 = croppedImg;
      uploadImgList
          .add(SourceImg(title: image1.path.split("/").last, size: "0MB"));
      setState(() {});
    } else if (image2 == null) {
      image2 = croppedImg;
      String dir = path.dirname(croppedImg.path);
      String rename = path.join(dir, 'file-upload-2.jpg');

      image2.renameSync(rename);
      uploadImgList
          .add(SourceImg(title: image2.path.split("/").last, size: "0MB"));
      setState(() {});
    } else if (image3 == null) {
      image3 = croppedImg;
      String dir = path.dirname(croppedImg.path);
      String rename = path.join(dir, 'file-upload-3.jpg');

      image3.renameSync(rename);
      uploadImgList
          .add(SourceImg(title: image3.path.split("/").last, size: "0MB"));
      setState(() {});
    } else if (image4 == null) {
      image4 = croppedImg;
      String dir = path.dirname(croppedImg.path);
      String rename = path.join(dir, 'file-upload-5.jpg');

      image4.renameSync(rename);
      uploadImgList
          .add(SourceImg(title: image4.path.split("/").last, size: "0MB"));
      setState(() {});
    }
  }

  Future selectFromVideo() async {
    var video = await ImagePicker.pickVideo(source: ImageSource.camera);

    if (image1 == null) {
      image1 = video;
      uploadImgList
          .add(SourceImg(title: image1.path.split("/").last, size: "0MB"));
      setState(() {});
    } else if (image2 == null) {
      image2 = video;
      String dir = path.dirname(video.path);
      String rename = path.join(dir, 'file-upload-2.jpg');

      image2.renameSync(rename);
      uploadImgList
          .add(SourceImg(title: image2.path.split("/").last, size: "0MB"));
      setState(() {});
    } else if (image3 == null) {
      image3 = video;
      String dir = path.dirname(video.path);
      String rename = path.join(dir, 'file-upload-3.jpg');

      image3.renameSync(rename);
      uploadImgList
          .add(SourceImg(title: image3.path.split("/").last, size: "0MB"));
      setState(() {});
    } else if (image4 == null) {
      image4 = video;
      String dir = path.dirname(video.path);
      String rename = path.join(dir, 'file-upload-5.jpg');

      image4.renameSync(rename);
      uploadImgList
          .add(SourceImg(title: image4.path.split("/").last, size: "0MB"));
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
        dateSelected.value = TextEditingValue(text: picked.toString());
      });
  }

  Future getCurrentLocation() async {
    location.getLocation().then((LocationData value) async {
      List<Placemark> placemark = await Geolocator()
          .placemarkFromCoordinates(value.latitude, value.longitude);

      var locationName = ""
          "${placemark[0].name}, "
          "${placemark[0].locality}, "
          "${placemark[0].subAdministrativeArea}, "
          "${placemark[0].administrativeArea}";

      latitudeCtrl.value = TextEditingValue(text: value.latitude.toString());
      longitudeCtrl.value = TextEditingValue(text: value.longitude.toString());
      alamatCtrl.value = TextEditingValue(text: locationName);

      log.info("Location : $locationName");

      setState(() {});
    });
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _currentLocaleId = "in_ID";
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} - ${result.finalResult}";
      notesCtrl.value = TextEditingValue(text: result.recognizedWords);
    });
  }

  void soundLevelListener(double level) {
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = "$status";
    });
  }

  void getPreferences() async {
    outletCode = await SharedPreferencesHelper.getSalesOutletId();
    branchCode = await SharedPreferencesHelper.getSalesBrachId();
    setState(() {});
  }

  void onCreateActivityReport() {
    if (_formKey.currentState.validate() || image1 == null) {
      DateTime parseDate = DateTime.parse(dateSelected.text);

      // ignore: close_sinks
      final activityReportBloc = BlocProvider.of<ActivityReportBloc>(context);
      activityReportBloc.add(UploadActivityReport(image1));
    } else {
      log.warning("Please Complete Form!");
    }
  }

  void getProvinceData() {
    final customerBloc = BlocProvider.of<CustomerBloc>(context);
    customerBloc.add(FetchProvince());
  }

  void _showListProvinsi() {
    SelectDialog.showModal<SelectorProvinceModel>(
      context,
      label: "Province Name",
      selectedValue: currentSelectProvince,
      items: provinceList,
      showSearchBox: false,
      onChange: (SelectorProvinceModel selected) {
        setState(() {
          currentSelectProvince = selected;
          customerProvinceCtrl.text = selected.provinceName;
          provinceCode = selected.provinceCode;

          // ignore: close_sinks
          final customerBloc = BlocProvider.of<CustomerBloc>(context);
          customerBloc.add(FetchDistrict(provinceCode));
        });
      },
    );
  }

  void _showListDistrict() {
    SelectDialog.showModal<SelectorDistrictModel>(
      context,
      label: "Kabupaten / Kota",
      selectedValue: currentSelectDistrict,
      items: districtList,
      showSearchBox: false,
      onChange: (SelectorDistrictModel selected) {
        setState(() {
          currentSelectDistrict = selected;
          customerDistrictCtrl.text = selected.districtName;
          districtCode = selected.districtCode;

          // ignore: close_sinks
          final customerBloc = BlocProvider.of<CustomerBloc>(context);
          customerBloc.add(FetchSubDistrict(provinceCode, districtCode));
        });
      },
    );
  }

  void _showListSubDistrict() {
    SelectDialog.showModal<SelectorSubDistrictModel>(
      context,
      label: "Kecamatan",
      selectedValue: currentSelectSubDistrict,
      items: districtSubList,
      showSearchBox: false,
      onChange: (SelectorSubDistrictModel selected) {
        setState(() {
          currentSelectSubDistrict = selected;
          customerSubDistrictCtrl.text = selected.districtSubName;
          districtSubCode = selected.districtSubCode;
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    getPreferences();
    getProvinceData();
    initSpeechState();
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
          "Tambah Laporan",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<ActivityReportBloc, ActivityReportState>(
        listener: (context, state) {
          if (state is CreateActivityReportSuccess) {
            log.info("Success Create Activity Report");
            Alert(
                context: context,
                type: AlertType.success,
                title: 'Success',
                desc: "Created Activity Report!",
                style: AlertStyle(
                  animationDuration: Duration(milliseconds: 500),
                  overlayColor: Colors.black54,
                  animationType: AnimationType.grow,
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                      Navigator.pop(context, true);
                    },
                    color: HexColor("#C61818"),
                  ),
                ]).show();
          }

          if (state is CreateActivityReportError) {
            log.warning("Fail Create Activity Report");
            Alert(
                context: context,
                type: AlertType.error,
                title: 'Error',
                desc: "Failed to Create Activity Report!",
                style: AlertStyle(
                  animationDuration: Duration(milliseconds: 500),
                  overlayColor: Colors.black54,
                  animationType: AnimationType.grow,
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: HexColor("#C61818"),
                  ),
                ]).show();
          }

          if (state is UploadActivityReportSuccess) {
            DateTime parseDate = DateTime.parse(dateSelected.text);
            // ignore: close_sinks
            final activityReportBloc =
                BlocProvider.of<ActivityReportBloc>(context);
            activityReportBloc.add(CreateActivityReport(ActivityReportPost(
              title: titleCtrl.text,
              alamat: alamatCtrl.text,
              description: notesCtrl.text,
              createdInMillisecond: parseDate.millisecondsSinceEpoch,
              idContent: state.value.id,
              outletCode: outletCode,
              branchCode: branchCode,
              provinceCode: provinceCode,
              kabCode: districtCode,
              kecCode: districtSubCode,
              provinceName: customerProvinceCtrl.text,
              kabName: customerDistrictCtrl.text,
              kecName: customerSubDistrictCtrl.text,
            )));
          }

          if (state is UploadActivityReportError) {
            log.warning("Fail Upload Media");
            Alert(
                context: context,
                type: AlertType.error,
                title: 'Error',
                desc: "Failed to Upload Media Content!",
                style: AlertStyle(
                  animationDuration: Duration(milliseconds: 500),
                  overlayColor: Colors.black54,
                  animationType: AnimationType.grow,
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: HexColor("#C61818"),
                  ),
                ]).show();
          }

          if (state is ActivityReportLoading) {
            onLoading(context);
          }

          if (state is ActivityReportDisposeLoading) {
            Navigator.of(context, rootNavigator: false).pop();
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                BlocListener<CustomerBloc, CustomerState>(
                    listener: (context, state) {
                      if (state is ProvinceSuccess) {
                        state.value.data.forEach((f) {
                          provinceList.add(SelectorProvinceModel(
                            provinceCode: f.provinsiCode,
                            provinceName: f.provinsiName,
                          ));
                        });
                      }

                      if (state is DistrictSuccess) {
                        state.value.data.forEach((f) {
                          districtList.add(SelectorDistrictModel(
                            districtCode: f.kabupatenCode,
                            districtName: f.kabupatenName,
                          ));
                        });
                      }

                      if (state is SubDistrictSuccess) {
                        state.value.data.forEach((f) {
                          districtSubList.add(SelectorSubDistrictModel(
                            districtSubCode: f.kecamatanCode,
                            districtSubName: f.kecamatanName,
                          ));
                        });
                      }

                      if (state is CustomerLoading) {
                        onLoading(context);
                      }

                      if (state is CustomerDisposeLoading) {
                        Navigator.of(context, rootNavigator: false).pop();
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Provinsi",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        formSelectProvince(),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Kota/Kabupaten",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        formSelectKota(),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Kecamatan",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        formSelectKecamatan(),
                      ],
                    )),
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
                formLatitude(),
                formLongitude(),
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
                speech.isListening
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text("I'm listening..."),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    width: screenWidth(context),
                    child: RaisedButton(
                      onPressed: image1 == null
                          ? null
                          : () {
                              onCreateActivityReport();
                            },
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
        ),
      ),
    );
  }

  Widget formTitle() {
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
                  hintText: "Masukan Judul Aktivitas",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: titleCtrl,
                maxLines: null,
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

  Widget formLatitude() {
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
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 17),
                  hintText: "Latitude Kejadian",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: latitudeCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formLongitude() {
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
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 17),
                  hintText: "Longitude Kejadian",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: longitudeCtrl,
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
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Alamat Kejadian",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: alamatCtrl,
                maxLines: null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectProvince() {
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
              child: GestureDetector(
                onTap: () {
                  _showListProvinsi();
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
                      hintText: 'Pilih Provinsi',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerProvinceCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectKota() {
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
              child: GestureDetector(
                onTap: () {
                  _showListDistrict();
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
                      hintText: 'Pilih Kota/Kabupaten',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerDistrictCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectKecamatan() {
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
              child: GestureDetector(
                onTap: () {
                  _showListSubDistrict();
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
                      hintText: 'Pilih Kecamatan',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerSubDistrictCtrl,
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
    return Stack(
      children: <Widget>[
        Padding(
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
        ),
        Positioned(
          right: 15,
          bottom: 10,
          child: IconButton(
            onPressed:
                !_hasSpeech || speech.isListening ? null : startListening,
            icon: Icon(Icons.mic),
          ),
        ),
        speech.isListening
            ? Positioned(
                right: 15,
                bottom: 40,
                child: IconButton(
                  onPressed: cancelListening,
                  icon: Icon(Icons.mic_off),
                ),
              )
            : SizedBox(),
      ],
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
                    onPressed: _uploadImage,
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            uploadImgList.removeAt(index);
                          });
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
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

  Future<ImageSource> _uploadImage() {
    return showDialog<ImageSource>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: const Text('Pilih File '),
          children: <Widget>[
            
            SimpleDialogOption(
              onPressed: selectFromCamera,
              child: const Text('Kamera', style: TextStyle(fontSize: 18)),
            ),
            SimpleDialogOption(
              onPressed: selectFromVideo,
              child: const Text('Video', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }
}

class SourceImg {
  String title;
  String size;

  SourceImg({this.title, this.size});
}
