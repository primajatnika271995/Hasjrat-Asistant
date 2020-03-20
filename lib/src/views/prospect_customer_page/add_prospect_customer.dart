import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/models/customer_get_form_model.dart';
import 'package:salles_tools/src/models/lead_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:select_dialog/select_dialog.dart';

class ProspectAddView extends StatefulWidget {
  final Datum value;
  ProspectAddView({this.value});

  @override
  _ProspectAddViewState createState() => _ProspectAddViewState();
}

class _ProspectAddViewState extends State<ProspectAddView> {
  var _formKey = GlobalKey<FormState>();

  int _currentStep = 0;
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  final dateFormat = DateFormat("yyyy-MM-dd");

  var _currentSelectFollowUp = "7 Hari";

  var leadCodeCtrl = new TextEditingController();
  var leadNameCtrl = new TextEditingController();
  var prospectDateCtrl = new TextEditingController();
  var salesNameCtrl = new TextEditingController();

  var customerProspectSourceCtrl = new TextEditingController();
  var currentSelectProspectSource;
  var prospectSourceId;
  List<SelectorProspectSourceModel> sourceList = [];

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

  @override
  void initState() {
    // TODO: implement initState
    leadCodeCtrl.text = widget.value.leadCode;
    leadNameCtrl.text = widget.value.cardName;
    prospectDateCtrl.value = TextEditingValue(text: dateFormat.format(DateTime.now()).toString());
    salesNameCtrl.text = widget.value.salesName;

    prospectSourceList.forEach((f) {
      sourceList.add(SelectorProspectSourceModel(
        sourceId: f.prospectSourceId,
        sourceName: f.prospectSourceName,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    title: Text("Prospect Info"),
                    isActive: _currentStep == 0 ? true : false,
                    state: StepState.editing,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Prospect Date",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formDateProspect(),
                        Text(
                          "Lead Code",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formLeadCode(),
                        Text(
                          "Lead Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formLeadName(),
                        Text(
                          "Sales Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formSalesName(),
                        Text(
                          "Prospect Source (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formSelectProspectSource(),
                        Text(
                          "Follow Up (*)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        dropdownFollowUp(),
                      ],
                    ),
                  ),
                  Step(
                    title: Text("Data Model"),
                    isActive: _currentStep == 1 ? true : false,
                    state: StepState.editing,
                    content: Column(),
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
    );
  }

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }

  Widget formDateProspect() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        width: 150,
        color: Colors.grey.withOpacity(0.3),
        child: TextField(
          textInputAction: TextInputAction.next,
          enabled: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18, left: 18),
            hintText: 'Prospect Date',
            prefixIcon: Icon(Icons.date_range),
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
          controller: prospectDateCtrl,
        ),
      ),
    );
  }

  Widget formLeadCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        color: Colors.grey.withOpacity(0.3),
        child: TextField(
          textInputAction: TextInputAction.next,
          enabled: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18, left: 18),
            hintText: 'Lead Code',
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
          controller: leadCodeCtrl,
        ),
      ),
    );
  }

  Widget formLeadName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        color: Colors.grey.withOpacity(0.3),
        child: TextField(
          textInputAction: TextInputAction.next,
          enabled: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18, left: 18),
            hintText: 'Lead Name',
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
          controller: leadNameCtrl,
        ),
      ),
    );
  }

  Widget formSalesName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        color: Colors.grey.withOpacity(0.3),
        child: TextField(
          textInputAction: TextInputAction.next,
          enabled: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 18, left: 18),
            hintText: 'Sales Name',
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
          controller: salesNameCtrl,
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
                contentPadding:
                EdgeInsets.only(bottom: 18, left: 18, right: 18),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentSelectFollowUp,
                  hint: Text('Follow Up'),
                  isDense: true,
                  onChanged: (String newVal) {
                    setState(() {
                      _currentSelectFollowUp = newVal;
                      state.didChange(newVal);
                    });
                  },
                  items: [
                    '1 Hari',
                    '2 Hari',
                    '3 Hari',
                    '4 Hari',
                    '5 Hari',
                    '6 Hari',
                    '7 Hari'
                  ].map((String val) {
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
}
