import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class ProfileEditView extends StatefulWidget {
  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  var namaCtrl = new TextEditingController();
  var tmptTglLahirCtrl = new TextEditingController();
  var jenisKelaminCtrl = new TextEditingController();
  var contactCtrl = new TextEditingController();
  var emailCtrl = new TextEditingController();
  var alamatCtrl = new TextEditingController();
  var dealerCtrl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    namaCtrl.text = 'Sales Name Example';
    tmptTglLahirCtrl.text = 'Bandung, 27 Desember 1995';
    jenisKelaminCtrl.text = 'Laki-Laki';
    contactCtrl.text = '085875074351';
    emailCtrl.text = 'sales@example.com';
    alamatCtrl.text = 'Jalan Cicalengka Raya 11, Antapani Bandung, Jawa Barat';
    dealerCtrl.text = 'Hasjrat Abadi Tandean';
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
          "Edit Profile",
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
            profileImage(),
            namaField(),
            tmptTglLahirField(),
            jenisKelaminField(),
            contactField(),
            emailField(),
            alamatField(),
            dealerField(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
              child: Container(
                width: screenWidth(context),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("Save", style: TextStyle(color: Colors.white),),
                  color: HexColor('#E07B36'),
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

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          children: <Widget>[
            Hero(
              tag: "profile-image",
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg"),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                "Change Profile Photo",
                style: TextStyle(
                  color: HexColor('#E07B36'),
                  letterSpacing: 0.5,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget namaField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Nama',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: namaCtrl,
      ),
    );
  }

  Widget tmptTglLahirField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Tempat Tanggal Lahir',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: tmptTglLahirCtrl,
      ),
    );
  }

  Widget jenisKelaminField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Jenis Kelamin',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: jenisKelaminCtrl,
      ),
    );
  }

  Widget contactField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'No. Telp',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: contactCtrl,
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: emailCtrl,
      ),
    );
  }

  Widget alamatField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Alamat',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: alamatCtrl,
        maxLines: null,
      ),
    );
  }

  Widget dealerField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        cursorColor: HexColor('#E07B36'),
        decoration: InputDecoration(
          labelText: 'Dealer',
          labelStyle: TextStyle(
            color: HexColor('#E07B36'),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#E07B36'),
            ),
          ),
        ),
        controller: dealerCtrl,
      ),
    );
  }
}
