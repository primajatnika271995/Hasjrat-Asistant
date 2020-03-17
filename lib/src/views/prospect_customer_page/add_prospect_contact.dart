import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/models/customer_get_form_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';

class ProspectContactAdd extends StatefulWidget {
  @override
  _ProspectContactAddState createState() => _ProspectContactAddState();
}

class _ProspectContactAddState extends State<ProspectContactAdd> {
  var customerNameCtrl = new TextEditingController();
  var customerContactCtrl = new TextEditingController();

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

  var customerNameFocus = new FocusNode();
  var customerContactFocus = new FocusNode();
  var customerSumberContactFocus = new FocusNode();

  String _currentSelectFollowUp = "7 Hari";

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

  @override
  void initState() {
    // TODO: implement initState
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
          "Create Contact / Lead",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<CustomerBloc, CustomerState>(
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

          if (state is CustomerLoading) {
            onLoading(context);
          }

          if (state is CustomerDisposeLoading) {
            Navigator.of(context, rootNavigator: false).pop();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Customer Name (*)",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
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

  Widget formCustomerName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18, left: 18),
            hintText: 'Input Name',
            hasFloatingPlaceholder: false,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(customerContactFocus);
          },
          controller: customerNameCtrl,
          focusNode: customerNameFocus,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formCustomerContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18, left: 18),
            hintText: 'Input Contact',
            hasFloatingPlaceholder: false,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(customerSumberContactFocus);
          },
          controller: customerContactCtrl,
          focusNode: customerContactFocus,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formSelectGroup() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Select Customer Group',
            contentPadding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
            suffixIcon: IconButton(
              onPressed: () {
                _showListGroup();
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: customerGroupCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formSelectGender() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Gender',
            contentPadding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
            suffixIcon: IconButton(
              onPressed: () {
                _showListGender();
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: customerGenderCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formSelectProspectSource() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Select Prospect Source',
            contentPadding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
            suffixIcon: IconButton(
              onPressed: () {
                _showListSource();
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: customerProspectSourceCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget dropdownFollowUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: FormField(
          builder: (FormFieldState state) {
            return InputDecorator(
              decoration: InputDecoration(
                hintText: 'Follow Up',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                contentPadding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentSelectFollowUp,
                  hint: Text('Follow UP'),
                  isDense: true,
                  onChanged: (String newVal) {
                    setState(() {
                      _currentSelectFollowUp = newVal;
                      state.didChange(newVal);
                    });
                  },
                  items: ['1 Hari', '2 Hari', '3 Hari', '4 Hari', '5 Hari', '6 Hari', '7 Hari'].map((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(val),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget formSelectLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Select Customer Location',
            contentPadding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
            suffixIcon: IconButton(
              onPressed: () {
                _showListLocation();
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: customerLocationCtrl,
          maxLines: null,
        ),
      ),
    );
  }

  Widget formSelectJob() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Select Customer Job',
            contentPadding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
            suffixIcon: IconButton(
              onPressed: () {
                _showListJob();
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          controller: customerJobCtrl,
          maxLines: null,
        ),
      ),
    );
  }
}
