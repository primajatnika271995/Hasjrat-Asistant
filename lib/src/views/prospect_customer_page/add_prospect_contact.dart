import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class ProspectContactAdd extends StatefulWidget {
  @override
  _ProspectContactAddState createState() => _ProspectContactAddState();
}

class _ProspectContactAddState extends State<ProspectContactAdd> {
  var customerNameCtrl = new TextEditingController();
  var customerContactCtrl = new TextEditingController();

  var customerNameFocus = new FocusNode();
  var customerContactFocus = new FocusNode();
  var customerSumberContactFocus = new FocusNode();

  String _currentSelectGroup;
  String _currentSelectSumberContact;
  String _currentSelectFollowUp = "7 Hari";
  String _currentSelectLocation;

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
      body: SingleChildScrollView(
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
              dropdownGroup(),
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
              dropdownSumberContact(),
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
                  "Customer Location (*)",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              dropdownLocation(),
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

  Widget dropdownGroup() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: FormField(
          builder: (FormFieldState state) {
            return InputDecorator(
              decoration: InputDecoration(
                hintText: 'Group',
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
                  value: _currentSelectGroup,
                  hint: Text('Select Group'),
                  isDense: true,
                  onChanged: (String newVal) {
                    setState(() {
                      _currentSelectGroup = newVal;
                      state.didChange(newVal);
                    });
                  },
                  items: ['Retail', 'Corporation', 'Instansi', 'BUMN', 'Toko/SubDealer'].map((String val) {
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

  Widget dropdownSumberContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: FormField(
          builder: (FormFieldState state) {
            return InputDecorator(
              decoration: InputDecoration(
                hintText: 'Sumber Contact',
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
                  value: _currentSelectSumberContact,
                  hint: Text('Select Sumber Contact'),
                  isDense: true,
                  onChanged: (String newVal) {
                    setState(() {
                      _currentSelectSumberContact = newVal;
                      state.didChange(newVal);
                    });
                  },
                  items: ['Walk-In', 'Phone-In', 'Canvassing', 'Movex / Pameran', 'Mobex / Test Drive', 'Showroom Event', 'Customer Gethering', 'Big Day Event', 'Repeat Order', 'Reference', 'Media Online', 'Community Event'].map((String val) {
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

  Widget dropdownLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 40,
        child: FormField(
          builder: (FormFieldState state) {
            return InputDecorator(
              decoration: InputDecoration(
                hintText: 'Customer Location',
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
                  value: _currentSelectLocation,
                  hint: Text('Select Location'),
                  isDense: true,
                  onChanged: (String newVal) {
                    setState(() {
                      _currentSelectLocation = newVal;
                      state.didChange(newVal);
                    });
                  },
                  items: ['Dalam Kota', 'Luar Kota'].map((String val) {
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
}
