import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salles_tools/src/bloc/followup_bloc/followup_bloc.dart';
import 'package:salles_tools/src/bloc/followup_bloc/followup_event.dart';
import 'package:salles_tools/src/bloc/followup_bloc/followup_state.dart';
import 'package:salles_tools/src/models/prospect_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/services/followup_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';

class FollowUpUpdateView extends StatefulWidget {
  final Datum value;
  FollowUpUpdateView(this.value);

  @override
  _FollowUpUpdateViewState createState() => _FollowUpUpdateViewState();
}

class _FollowUpUpdateViewState extends State<FollowUpUpdateView> {

  var prospectFollowUpIdCtrl = new TextEditingController();
  var prospectIdCtrl = new TextEditingController();
  var prospectRemarkCtrl = new TextEditingController();

  var prospectClassificationNameCtrl = new TextEditingController();
  var currentSelectClassification;
  var classificationId;
  List<SelectorClassification> classificationList = [];

  var followUpMethodeNameCtrl = new TextEditingController();
  var currentSelectFollowUpMethode;
  var followUpMethodeId;
  List<SelectorFollowupMethode> followupMethodeList = [];

  void _showListClassification() {
    SelectDialog.showModal<SelectorClassification>(
      context,
      label: "Classification",
      selectedValue: currentSelectClassification,
      items: classificationList,
      onChange: (SelectorClassification selected) {
        setState(() {
          currentSelectClassification = selected;
          prospectClassificationNameCtrl.text = selected.classificationName;
          classificationId = selected.classificationId;
        });
      },
    );
  }

  void _showListFollowUpMethode() {
    SelectDialog.showModal<SelectorFollowupMethode>(
      context,
      label: "Follow-Up Methode",
      selectedValue: currentSelectFollowUpMethode,
      items: followupMethodeList,
      onChange: (SelectorFollowupMethode selected) {
        setState(() {
          currentSelectFollowUpMethode = selected;
          followUpMethodeNameCtrl.text = selected.followupName;
          followUpMethodeId = selected.followupId;
        });
      },
    );
  }

  void onUpdateFollowUp() {
    // ignore: close_sinks
    final followUpBloc = BlocProvider.of<FollowupBloc>(context);
    followUpBloc.add(UpdateFollowup(FollowUpParams(
      lineNum: 0,
      followUpNextDay: 5,
      prospectClassificationId: classificationId,
      prospectFollowUpId: widget.value.followups[0].prospectFollowupId,
      prospectFollowUpMethodeId: followUpMethodeId,
      prospectId: widget.value.followups[0].prospectId,
      prospectRemarks: prospectRemarkCtrl.text
    )));
  }

  @override
  void initState() {
    // TODO: implement initState

    prospectFollowUpIdCtrl.value = TextEditingValue(text: '${widget.value.followups[0].prospectFollowupId.toString()}');
    prospectIdCtrl.value = TextEditingValue(text: '${widget.value.followups[0].prospectId.toString()}');
    prospectRemarkCtrl.value = TextEditingValue(text: '${widget.value.followups[0].prospectRemarks}');

    // ignore: close_sinks
    final followUpBloc = BlocProvider.of<FollowupBloc>(context);
    followUpBloc.add(FetchClassificationFollowup());
    followUpBloc.add(FetchFollowupMethode());
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
          "Update Follow-Up",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<FollowupBloc, FollowupState>(
        listener: (context, state) {
          if (state is FollowupLoading) {
            onLoading(context);
          }

          if (state is FollowupDisposeLoading) {
            Navigator.of(context, rootNavigator: false).pop();
          }

          if (state is FollowupError) {
            Navigator.of(context, rootNavigator: false).pop();
          }

          if (state is ClassificationFollowupSuccess) {
            state.value.data.forEach((f) {
              classificationList.add(SelectorClassification(
                classificationId: f.prospectClassificationId,
                classificationName: f.prospectClassificationName,
              ));
            });
          }

          if (state is FollowupMethodeSuccess) {
            state.value.data.forEach((f) {
              followupMethodeList.add(SelectorFollowupMethode(
                followupId: f.followupMethodId,
                followupName: f.followupMethodName,
              ));
            });
          }

          if (state is UpdateFollowupSuccess) {
            log.info("Success Update Follow-UP");
            Alert(
                context: context,
                type: AlertType.success,
                title: 'Success',
                desc: "Updated Follow-UP!",
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
                      Navigator.pop(context, false);
                      Navigator.pop(context, false);
                    },
                    color: HexColor("#C61818"),
                  ),
                ]
            ).show();
          }

          if (state is UpdateFollowupError) {
            log.warning("Fail Updated Follow-UP");
            Alert(
                context: context,
                type: AlertType.error,
                title: 'Error',
                desc: "Failed to Update Follow-UP!",
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
                ]
            ).show();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  "Id Follow-Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                formProspectFollowUpId(),
                SizedBox(height: 5),
                Text(
                  "Id Prospect",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                formProspectId(),
                SizedBox(height: 5),
                Text(
                  "Classification",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                formSelectClassification(),
                SizedBox(height: 5),
                Text(
                  "Follow Up Methode",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                formSelectFollowupMethode(),
                SizedBox(height: 5),
                Text(
                  "Prospect Remark",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                formProspectRemark(),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
                  child: Container(
                    width: screenWidth(context),
                    child: RaisedButton(
                      onPressed: () {
                        onUpdateFollowUp();
                      },
                      child: Text(
                        "Update",
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

  Widget formProspectFollowUpId() {
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: 'Prospect Follow Up Id',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: prospectFollowUpIdCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formProspectId() {
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: 'Prospect Id',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: prospectIdCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formProspectRemark() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  hintText: 'Silahkan isi Remark',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: prospectRemarkCtrl,
                maxLines: null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectClassification() {
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
                  _showListClassification();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 16),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Classification",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: prospectClassificationNameCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectFollowupMethode() {
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
                  _showListFollowUpMethode();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 16),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Follow-UP Methode",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: followUpMethodeNameCtrl,
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
