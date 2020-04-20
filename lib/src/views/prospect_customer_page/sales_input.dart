import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_bloc.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_event.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_bloc.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_event.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/services/spk_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/prospect_customer_page/list_prospect_contact.dart';
import 'package:salles_tools/src/views/prospect_customer_page/list_prospect_customer.dart';
import 'package:salles_tools/src/views/prospect_customer_page/list_spk.dart';

class SalesInputView extends StatefulWidget {
  @override
  _SalesInputViewState createState() => _SalesInputViewState();
}

class _SalesInputViewState extends State<SalesInputView> {

  void _onViewContact() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => LeadBloc(CustomerService())..add(FetchLead(LeadPost(
            leadCode: "",
            leadName: "",
            ))),
          child: ProspectContactListView(),
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

  void _onViewProspect() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => DmsBloc(DmsService())..add(FetchProspect(ProspectGet(
            leadCode: "",
            leadName: "",
          ))),
          child: ProspectCustomerListView(),
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

  void _onViewSpk() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => SpkBloc(SpkService())..add(FetchSpk(SpkFilterPost(
            cardCode: "",
            cardName: "",
            endDate: "",
            spkBlanko: "",
            spkNum: "",
            startDate: "",
          ))),
          child: SpkListView(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Input Penjualan",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 4,
            child: ListTile(
              dense: true,
              onTap: () {
                _onViewContact();
              },
              leading: Icon(Icons.contact_mail,
                size: 35,
                color: HexColor("#C61818"),
              ),
              title: Text("Tambah Contact Baru"),
              subtitle: Text("Hot Prospect"),
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              dense: true,
              onTap: () {
                _onViewProspect();
              },
              leading: Icon(Icons.alternate_email,
                size: 35,
                color: HexColor("#C61818"),
              ),
              title: Text("Data Prospect"),
              subtitle: Text("List Customer yang telah di Prospect"),
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              dense: true,
              onTap: () {
                _onViewSpk();
              },
              leading: Icon(Icons.note,
                size: 35,
                color: HexColor("#C61818"),
              ),
              title: Text("Data SPK"),
              subtitle: Text("List SPK Mobil"),
            ),
          ),
        ],
      ),
    );
  }
}
