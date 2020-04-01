import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/models/customer_get_form_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/regex_file.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';

class ProspectContactAdd extends StatefulWidget {
  @override
  _ProspectContactAddState createState() => _ProspectContactAddState();
}

class _ProspectContactAddState extends State<ProspectContactAdd> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var nikScan, namaScan;
  int loopIndex = 0;
  Image currentPreviewImage;
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

  int _currentStep = 0;
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  var customerNameCtrl = new TextEditingController();
  var customerContactCtrl = new TextEditingController();
  var customerNIKCtrl = new TextEditingController();

  var customerGenderCtrl = new TextEditingController();
  var currentSelectGender;
  var genderValue;
  List<SelectorGenderModel> genderList = [];

  var customerGroupCtrl = new TextEditingController();
  var currentSelectGroup;
  var groupId;
  List<SelectorGroupModel> groupList = [];

  var customerProspectSourceCtrl = new TextEditingController();
  var currentSelectProspectSource;
  var prospectSourceId;
  List<SelectorProspectSourceModel> sourceList = [];

  var customerLocationCtrl = new TextEditingController();
  var currentSelectLocation;
  var locationValue;
  List<SelectorLocationModel> locationList = [];

  var customerJobCtrl = new TextEditingController();
  var currentSelectJob;
  var jobValue;
  List<SelectorJobModel> jobList = [];

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

  var customerNIKFocus = new FocusNode();
  var customerNameFocus = new FocusNode();
  var customerContactFocus = new FocusNode();
  var customerSumberContactFocus = new FocusNode();

  var _currentSelectFollowUp = "7 Hari";
  var followUpCtrl = new TextEditingController();
  List<String> followUpList = [
    "1 Hari",
    "2 Hari",
    "3 Hari",
    "4 Hari",
    "5 Hari",
    "5 Hari",
    "6 Hari",
    "7 Hari",
  ];

  void _showListFollowUp() {
    SelectDialog.showModal<String>(
      context,
      label: "Follow Up",
      selectedValue: _currentSelectFollowUp,
      items: followUpList,
      onChange: (String selected) {
        setState(() {
          _currentSelectFollowUp = selected;
          followUpCtrl.text = selected;
        });
      },
    );
  }

  void _showListGender() {
    SelectDialog.showModal<SelectorGenderModel>(
      context,
      label: "Gender",
      selectedValue: currentSelectGender,
      items: genderList,
      onChange: (SelectorGenderModel selected) {
        setState(() {
          currentSelectGender = selected;
          customerGenderCtrl.text = selected.description;
          genderValue = selected.fieldValue;
        });
      },
    );
  }

  void _showListGroup() {
    SelectDialog.showModal<SelectorGroupModel>(
      context,
      label: "Gender",
      selectedValue: currentSelectGroup,
      items: groupList,
      onChange: (SelectorGroupModel selected) {
        setState(() {
          currentSelectGroup = selected;
          customerGroupCtrl.text = selected.groupName;
          groupId = selected.groupId;
        });
      },
    );
  }

  void _showListSource() {
    SelectDialog.showModal<SelectorProspectSourceModel>(
      context,
      label: "Prospect Source",
      selectedValue: currentSelectProspectSource,
      items: sourceList,
      onChange: (SelectorProspectSourceModel selected) {
        setState(() {
          currentSelectProspectSource = selected;
          customerProspectSourceCtrl.text = selected.sourceName;
          prospectSourceId = selected.sourceId;
        });
      },
    );
  }

  void _showListLocation() {
    SelectDialog.showModal<SelectorLocationModel>(
      context,
      label: "Customer Location",
      selectedValue: currentSelectLocation,
      items: locationList,
      onChange: (SelectorLocationModel selected) {
        setState(() {
          currentSelectLocation = selected;
          customerLocationCtrl.text = selected.locationName;
          locationValue = selected.locationField;
        });
      },
    );
  }

  void _showListJob() {
    SelectDialog.showModal<SelectorJobModel>(
      context,
      label: "Customer Job",
      selectedValue: currentSelectJob,
      items: jobList,
      onChange: (SelectorJobModel selected) {
        setState(() {
          currentSelectJob = selected;
          customerJobCtrl.text = selected.jobName;
          jobValue = selected.jobField;
        });
      },
    );
  }

  void _showListProvince() {
    SelectDialog.showModal<SelectorProvinceModel>(
      context,
      label: "Province Name",
      selectedValue: currentSelectProvince,
      items: provinceList,
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
      onChange: (SelectorSubDistrictModel selected) {
        setState(() {
          currentSelectSubDistrict = selected;
          customerSubDistrictCtrl.text = selected.districtSubName;
          districtSubCode = selected.districtSubCode;
        });
      },
    );
  }

  void onCreateLead() {
    if (_formKey.currentState.validate()) {
      // ignore: close_sinks
      final customerBloc = BlocProvider.of<CustomerBloc>(context);
      customerBloc.add(CreateContact(ContactPost(
          customerName: customerNameCtrl.text,
          customerGroupId: int.parse(groupId),
          prospectSourceId: prospectSourceId,
          contact: customerContactCtrl.text,
          gender: genderValue,
          job: jobValue,
          location: locationValue,
          suspectDate: "2020-03-17",
          suspectFollowUp: 7,
          provinceName: customerProvinceCtrl.text,
          provinceCode: provinceCode,
          kabupatenName: customerDistrictCtrl.text,
          kabupatenCode: districtCode,
          kecamatanName: customerSubDistrictCtrl.text,
          kecamatanCode: districtSubCode,
          zipCode: "40287"
      )));
    } else {
      log.warning("Please Complete Form!");
    }
  }

  void onTakeOCR() async {
    final scaffold = _scaffoldKey.currentState;
    setState(() {
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
          toolbarTitle: 'Identity Card Cropper',
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          showCropGrid: true,
          toolbarColor: HexColor('#C61818'),
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );

      setState(() {
        currentPreviewImage = Image.file(File(fileCropper.path),
          fit: BoxFit.cover,
        );
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
            customerNIKCtrl.text = nikScan;
          });
        }

        if (loopIndex <= 4) {
          log.info(loopIndex);
          setState(() {
            loopIndex = loopIndex + 1;
            namaScan = block.text;
            customerNameCtrl.text = namaScan;
          });
        }

        log.info("NIK : $nikScan");
        log.info("Nama : $namaScan");
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

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }

  @override
  // ignore: must_call_super
  void initState() {
    followUpCtrl.text = "7 Hari";
    customerGroupList.forEach((f) {
      setState(() {
        groupList.add(SelectorGroupModel(
          groupId: f.customerGroupId,
          groupName: f.customerGroupName,
        ));
      });
    });

    prospectSourceList.forEach((f) {
      setState(() {
        sourceList.add(SelectorProspectSourceModel(
          sourceId: f.prospectSourceId,
          sourceName: f.prospectSourceName,
        ));
      });
    });

    // ignore: close_sinks
    final customerBloc = BlocProvider.of<CustomerBloc>(context);
    customerBloc.add(FetchGender(""));
    customerBloc.add(FetchLocation(""));
    customerBloc.add(FetchJob(""));
    customerBloc.add(FetchProvince());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Create Contact / Lead",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: BlocListener<CustomerBloc, CustomerState>(
          listener: (context, state) {
            if (state is GenderSuccess) {
              state.value.data.forEach((f) {
                genderList.add(SelectorGenderModel(
                  description: f.descr,
                  fieldValue: f.fldValue,
                ));
              });
            }

            if (state is LocationSuccess) {
              state.value.data.forEach((f) {
                locationList.add(SelectorLocationModel(
                  locationField: f.fldValue,
                  locationName: f.descr,
                ));
              });
            }

            if (state is JobSuccess) {
              state.value.data.forEach((f) {
                jobList.add(SelectorJobModel(
                  jobField: f.fldValue,
                  jobName: f.descr,
                ));
              });
            }

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

            if (state is CreateContactSuccess) {
              log.info("Success Create Lead");
              Alert(
                  context: context,
                  type: AlertType.success,
                  title: 'Success',
                  desc: "Created Lead!",
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
                  ]
              ).show();
            }

            if (state is CreateContactError) {
              log.warning("Fail Create Lead");
              Alert(
                context: context,
                type: AlertType.error,
                title: 'Error',
                desc: "Failed to Create Lead!",
                buttons: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: HexColor("#C61818"),
                  ),
                ]
              ).show();
            }

            if (state is CustomerLoading) {
              onLoading(context);
            }

            if (state is CustomerDisposeLoading) {
              Navigator.of(context, rootNavigator: false).pop();
            }
          },
          child: Stack(
            children: <Widget>[
              Theme(
                data: ThemeData(
                  primarySwatch: Colors.orange,
                  canvasColor: Colors.white,
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
                      title: Text("Form Identity"),
                      isActive: _currentStep == 0 ? true : false,
                      state: StepState.editing,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          currentPreviewImage == null ?
                          Card(
                            elevation: 3,
                            child: Container(
                              height: 170,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FloatingActionButton(
                                      onPressed: () {
                                        onTakeOCR();
                                      },
                                      heroTag: 'ocr-camera',
                                      child: Icon(Icons.camera_enhance,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text("Scan data Kartu Identitas / KTP",
                                        style: TextStyle(
                                          letterSpacing: 1.0
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ) :
                          Center(
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  child: currentPreviewImage,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Customer NIK (*)",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formCustomerNIK(),
                          Text(
                            "Customer Name (*)",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formCustomerName(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Customer Contact (*)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          formCustomerContact(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Group Customer (*)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          formSelectGroup(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Gender (*)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          formSelectGender(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Sumber Contact (*)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          formSelectProspectSource(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Follow Up Pertama (*)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          dropdownFollowUp(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Customer Job (*)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          formSelectJob(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Customer Location (*)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          formSelectLocation(),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Step(
                      title: Text("Location"),
                      isActive: _currentStep == 1 ? true : false,
                      state: StepState.editing,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Province (*)",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          formSelectProvince(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Kota / Kabupaten (*)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          formSelectDistrict(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Kecamatan (*)",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          formSelectSubDistrict(),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
                            child: Container(
                              width: screenWidth(context),
                              child: RaisedButton(
                                onPressed: () {
                                  onCreateLead();
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
                                'BACK',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                      _currentStep == 1
                          ? SizedBox()
                          : FlatButton(
                              onPressed: () => _onStepContinue(),
                              child: Text(
                                'NEXT',
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
      ),
    );
  }

  Widget formCustomerName() {
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
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 18),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: 'Input Name',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(customerContactFocus);
                },
                controller: customerNameCtrl,
                focusNode: customerNameFocus,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formCustomerNIK() {
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
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 17),
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: 'Input NIK',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(customerNameFocus);
                },
                controller: customerNIKCtrl,
                focusNode: customerNIKFocus,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formCustomerContact() {
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
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 18),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: 'Input Contact',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(customerSumberContactFocus);
                },
                controller: customerContactCtrl,
                focusNode: customerContactFocus,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectGroup() {
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
                  _showListGroup();
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
                      hintText: 'Select Customer Group',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerGroupCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectGender() {
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
                  _showListGender();
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
                      hintText: 'Gender',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerGenderCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectProspectSource() {
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
                  _showListSource();
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
                      hintText: 'Select Prospect Source',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerProspectSourceCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropdownFollowUp() {
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
                  _showListFollowUp();
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
                      hintText: "Select Follow Up",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: followUpCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectLocation() {
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
                  _showListLocation();
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
                      hintText: 'Select Customer Location',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerLocationCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectJob() {
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
                  _showListJob();
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
                      hintText: 'Select Customer Job',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerJobCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectProvince() {
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
                  _showListProvince();
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
                      hintText: 'Select Province',
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

  Widget formSelectDistrict() {
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
                  _showListDistrict();
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
                      hintText: 'Select District',
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

  Widget formSelectSubDistrict() {
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
                  _showListSubDistrict();
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
                      hintText: 'Select Sub District',
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
}
