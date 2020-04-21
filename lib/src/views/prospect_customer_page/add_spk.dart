import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_bloc.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_event.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_state.dart';
import 'package:salles_tools/src/models/prospect_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:select_dialog/select_dialog.dart';

class SpkAddView extends StatefulWidget {
  final Datum value;
  SpkAddView(this.value);

  @override
  _SpkAddViewState createState() => _SpkAddViewState();
}

class _SpkAddViewState extends State<SpkAddView> {

  int _currentStep = 0;
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  var spkNumberCtrl = new TextEditingController();
  var currentSelectSpkNumber;
  var spkBlanko;
  var spkBlankoCtrl = new TextEditingController();
  List<SelectorSpkNumber> spkNumberList = [];

  void _showListSpkNumber() {
    SelectDialog.showModal<SelectorSpkNumber>(
      context,
      label: "SPK Number",
      selectedValue: currentSelectSpkNumber,
      items: spkNumberList,
      onChange: (SelectorSpkNumber selected) {
        setState(() {
          currentSelectSpkNumber = selected;
          spkNumberCtrl.text = selected.spkNumber;
          spkBlanko = selected.spkBlanko;
          spkBlankoCtrl.text = selected.spkBlanko;
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final spkBloc = BlocProvider.of<SpkBloc>(context);
    spkBloc.add(FetchSpkNumber());
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
          "Copy to SPK",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<SpkBloc, SpkState>(
        listener: (context, state) {
          if (state is SpkLoading) {
            onLoading(context);
          }

          if (state is SpkDisposeLoading) {
            Navigator.of(context, rootNavigator: false).pop();
          }

          if (state is SpkNumberSuccess) {
            state.value.data.forEach((f) {
              spkNumberList.add(SelectorSpkNumber(
                spkBlanko: f.spkBlanko,
                spkNumber: f.spkNum,
              ));
            });
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
                    title: Text("SPK Baru"),
                    isActive: _currentStep == 0 ? true : false,
                    state: StepState.editing,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nomor SPK",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formSelectSpkNumber(),
                        spkBlanko != null ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "SPK Blanko",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                            formSpkBlanko(),
                          ],
                        ) : SizedBox(),
                      ],
                    ),
                  ),
                  Step(
                    title: Text("Info STNK"),
                    isActive: _currentStep == 1 ? true : false,
                    state: StepState.editing,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
    );
  }

  Widget _createEventControlBuilder(BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }

  Widget formSelectSpkNumber() {
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
                  _showListSpkNumber();
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
                      hintText: "Pilih Nomor SPK",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: spkNumberCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSpkBlanko() {
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
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 17),
                  hintText: "Spk Blanko",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: spkBlankoCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
