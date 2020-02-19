import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          title: Text(
            "My Profile",
            style: TextStyle(
              color: HexColor('#E07B36'),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "{Sales Username}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          "{sales@example.com}",
                          style: TextStyle(
                            fontSize: 13,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: LinearPercentIndicator(
                            percent: 0.6,
                            width: 150,
                            lineHeight: 17,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            progressColor: HexColor('#E07B36'),
                          ),
                        ),
                        Text(
                          "60% Complete Profile",
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    profileImage(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            onTap: null,
            title: Text("Change Password"),
            leading: Icon(Icons.lock_outline),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.navigate_next),
            ),
          ),
          Divider(),
          ListTile(
            onTap: null,
            title: Text("Term of Service"),
            leading: Icon(Icons.info_outline),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.navigate_next),
            ),
          ),
          Divider(),
          ListTile(
            onTap: null,
            title: Text("Privacy Police"),
            leading: Icon(Icons.security),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.navigate_next),
            ),
          ),
          Divider(),
          ListTile(
            onTap: null,
            title: Text("About"),
            leading: Icon(Icons.format_color_text),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.navigate_next),
            ),
          ),
          Divider(),
          ListTile(
            onTap: null,
            title: Text("Rate App"),
            leading: Icon(Icons.star_border),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.navigate_next),
            ),
          ),
          Divider(),
          ListTile(
            onTap: null,
            title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 40),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            backgroundImage: NetworkImage(
                "https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg"),
          ),
          ButtonTheme(
            height: 20,
            child: OutlineButton(
              onPressed: () {},
              highlightElevation: 3,
              highlightedBorderColor: HexColor('#E07B36'),
              borderSide: BorderSide(
                color: HexColor('#E07B36'),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 12,
                  color: HexColor('#665C55'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
