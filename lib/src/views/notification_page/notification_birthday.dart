import 'package:flutter/material.dart';

class NotificationBirthdayView extends StatefulWidget {
  @override
  _NotificationBirthdayViewState createState() => _NotificationBirthdayViewState();
}

class _NotificationBirthdayViewState extends State<NotificationBirthdayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Notification Birthday",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${CustomerBirthday.getData()[index].customerName}"),
            subtitle: Text("${CustomerBirthday.getData()[index].date}"),
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              foregroundColor: Colors.white,
              backgroundImage: NetworkImage(CustomerBirthday.getData()[index].urlProfile),
            ),
            trailing: IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {},
            ),
          );
        },
        itemCount: CustomerBirthday.getData().length,
      ),
    );
  }
}

class CustomerBirthday {
  String urlProfile;
  String customerName;
  String date;

  CustomerBirthday({this.urlProfile, this.customerName, this.date});

  static List<CustomerBirthday> getData() {
    return<CustomerBirthday>[
      CustomerBirthday(
        urlProfile: "https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg",
        customerName: "John Doe",
        date: "2 minutes Ago"
      ),
      CustomerBirthday(
          urlProfile: "https://keenthemes.com/preview/metronic/theme/assets/pages/media/profile/profile_user.jpg",
          customerName: "Bitna",
          date: "17 minutes Ago"
      ),
      CustomerBirthday(
          urlProfile: "https://lavinephotography.com.au/wp-content/uploads/2017/01/PROFILE-Photography-112.jpg",
          customerName: "Brenda",
          date: "3 days Ago"
      ),
      CustomerBirthday(
          urlProfile: "https://i.imgur.com/74sByqd.jpg",
          customerName: "Bayu Harsono",
          date: "5 days Ago"
      ),
    ];
  }
}
