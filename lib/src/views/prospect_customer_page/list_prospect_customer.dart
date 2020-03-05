import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/prospect_customer_page/add_prospect_customer.dart';
import 'package:salles_tools/src/views/prospect_customer_page/details_prospect_customer.dart';
import 'package:salles_tools/src/views/prospect_customer_page/upload_ktp_customer.dart';

class ProspectCustomerListView extends StatefulWidget {
  @override
  _ProspectCustomerListViewState createState() => _ProspectCustomerListViewState();
}

class _ProspectCustomerListViewState extends State<ProspectCustomerListView> {

  void _onAddProspectCustomer() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => UploadKTPCustomerView(),
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

  void _onViewDetailsProspectCustomer() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ProspectDetailsView(),
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
        elevation: 3,
        titleSpacing: 0,
        title: Text(
          "Prospect Customer",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SlidableCustomerView(
            index: index,
            callback: () {
              _onViewDetailsProspectCustomer();
            },
          );
        },
        itemCount: ProspectCustomer.getProspect().length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onAddProspectCustomer();
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: HexColor('#E07B36'),
      ),
    );
  }
}

class SlidableCustomerView extends StatelessWidget {
  final Function callback;
  final int index;
  SlidableCustomerView({Key key, this.callback, this.index}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          elevation: 3,
          child: ListTile(
            onTap: () {
              this.callback();
            },
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              foregroundColor: Colors.white,
              backgroundImage: NetworkImage(ProspectCustomer.getProspect()[index].urlProfile),
            ),
            title: Text("Customer $index"),
            subtitle: Padding(
              padding: const EdgeInsets.only(right: 230),
              child: Container(
                height: 18,
                width: 50,
                decoration: BoxDecoration(
                  color: ProspectCustomer.getProspect()[index].colors,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "${ProspectCustomer.getProspect()[index].contextType}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}


class ProspectCustomer {
  String urlProfile;
  String customerName;
  String contextType;
  Color colors;

  ProspectCustomer({this.urlProfile, this.customerName, this.contextType, this.colors});

  static List<ProspectCustomer> getProspect() {
    return <ProspectCustomer>[
      ProspectCustomer(
        urlProfile: "https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg",
        customerName: "",
        contextType: "Context",
        colors: Colors.orangeAccent,
      ),
      ProspectCustomer(
        urlProfile: "https://keenthemes.com/preview/metronic/theme/assets/pages/media/profile/profile_user.jpg",
        customerName: "",
        contextType: "Prospect",
        colors: Colors.green,
      ),
      ProspectCustomer(
        urlProfile: "https://i.imgur.com/74sByqd.jpg",
        customerName: "",
        contextType: "Context",
        colors: Colors.orangeAccent,
      ),
      ProspectCustomer(
        urlProfile: "https://lavinephotography.com.au/wp-content/uploads/2017/01/PROFILE-Photography-112.jpg",
        customerName: "",
        contextType: "Hot Prospect",
        colors: Colors.red,
      ),
    ];
  }
}
