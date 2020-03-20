import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/models/lead_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/prospect_customer_page/add_prospect_customer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProspectContactDetailsView extends StatefulWidget {
  final Datum value;
  ProspectContactDetailsView(this.value);

  @override
  _ProspectContactDetailsViewState createState() => _ProspectContactDetailsViewState();
}

class _ProspectContactDetailsViewState extends State<ProspectContactDetailsView> {
  String _currentContextType = "Hot Prospect";

  void _onAddProspect() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => DmsBloc(DmsService()),
          child: ProspectAddView(value: widget.value),
        ),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
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
          "Contact Details",
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
            SizedBox(
              height: 30,
            ),
            leadCode(),
            Divider(),
            namaCustomer(),
            Divider(),
            nikCustomer(),
            Divider(),
            contactCustomer(),
            Divider(),
            alamatCustomer(),
            Divider(),
            locationCustomer(),
            Divider(),
            jobCustomer(),
            dropdownContext(),
            prospectButton(),
            callButton(),
          ],
        ),
      ),
    );
  }

  Widget ktpImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Container(
        height: 180,
        width: screenWidth(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://cdn2.tstatic.net/pontianak/foto/bank/images/jual-ktp-palsu_20150414_134332.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget namaCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Lead Name",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.cardName}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leadCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Lead Code",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.leadCode}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nikCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "NIK",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.noKtp}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "No. Telp",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.phone1}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Email",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "bayuharsono@gmail.com",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alamatCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Alamat",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.addresses[0].address1}, ${widget.value.addresses[0].kecamatanName}, ${widget.value.addresses[0].kabupatenName}, ${widget.value.addresses[0].provinsiName}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget locationCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Lokasi",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.locationName}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget jobCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Pekerjaan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.pekerjaanName}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropdownContext() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              hintText: 'Context Type',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentContextType,
                hint: Text('Context Type'),
                isDense: true,
                onChanged: (String newVal) {
                  setState(() {
                    _currentContextType = newVal;
                    state.didChange(newVal);
                  });
                },
                items: ["Prospect", "Hot Prospect", "Context"].map((String val) {
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
    );
  }

  Widget vehicleCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Vehicle",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "Cammry Auto",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget colorVehicleCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Warna",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "Putih",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prospectButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Container(
        width: screenWidth(context),
        child: RaisedButton(
          onPressed: () {
            _onAddProspect();
          },
          child: Text("Prospect", style: TextStyle(color: Colors.white),),
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget saveButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Container(
        width: screenWidth(context),
        child: RaisedButton(
          onPressed: () {},
          child: Text("Save", style: TextStyle(color: Colors.white),),
          color: HexColor('#C61818'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget callButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Container(
        width: screenWidth(context),
        child: RaisedButton(
          onPressed: () {
            launch('tel:${widget.value.phone1}');
          },
          child: Text("Call", style: TextStyle(color: Colors.white),),
          color: Colors.brown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
