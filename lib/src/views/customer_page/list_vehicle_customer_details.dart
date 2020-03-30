import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class VehicleCustomerDetailsListView extends StatefulWidget {
  final Datum datum;
  VehicleCustomerDetailsListView({this.datum});

  @override
  _VehicleCustomerDetailsListViewState createState() =>
      _VehicleCustomerDetailsListViewState();
}

class _VehicleCustomerDetailsListViewState
    extends State<VehicleCustomerDetailsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.datum.vins == null ? Center(
        child: Image.asset(
          "assets/icons/empty_icon.png",
          height: 100,
          color: HexColor('#C61818'),
        ),
      ) : ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey),
                  left: BorderSide(color: Colors.grey),
                  top: BorderSide(color: Colors.grey),
                  bottom: BorderSide(color: Colors.grey),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Image.network(
                            "https://m.toyota.astra.co.id/sites/default/files/2019-04/car-pearl.png",
                            height: 70,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${widget.datum.vins[index].itemName}',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${widget.datum.vins[index].whsCode}',
                              style: TextStyle(
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  vehicleColor(widget.datum.vins[index].namaWarna),
                  vehicleYear(widget.datum.vins[index].tahun),
                  vehicleChasis(widget.datum.vins[index].nomorRangka),
                  vehicleMachine(widget.datum.vins[index].nomorMesin),
                  vehicleExpire(widget.datum.vins[index].nomorRegister),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: widget.datum.vins.length,
      ),
    );
  }

  Widget vehicleColor(String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Warna",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "$data",
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicleYear(String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Tahun",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "$data",
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicleChasis(String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "No. Chasis",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "$data",
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicleMachine(String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "No. Mesin",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "$data",
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicleExpire(String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Nomor Regitrasi",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "$data",
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VehicleCostumer {
  String vehicleName;
  String vehiclePoliceNumber;
  String vehicleColor;
  String vehicleYear;
  String vehicleChasisNumber;
  String vehicleMachineNumber;
  String vehicleSTNKExpire;

  VehicleCostumer({
    this.vehicleName,
    this.vehiclePoliceNumber,
    this.vehicleColor,
    this.vehicleYear,
    this.vehicleChasisNumber,
    this.vehicleMachineNumber,
    this.vehicleSTNKExpire,
  });

  static List<VehicleCostumer> getVehicle() {
    return <VehicleCostumer>[
      VehicleCostumer(
        vehicleName: 'Camry LE Auto',
        vehiclePoliceNumber: 'DB 1234 AE',
        vehicleColor: 'Putih',
        vehicleYear: '2019',
        vehicleChasisNumber: '2910019182749182371',
        vehicleMachineNumber: '1101912815181031',
        vehicleSTNKExpire: '2022-09-01',
      ),
      VehicleCostumer(
        vehicleName: 'C-HR',
        vehiclePoliceNumber: 'DB 5912 ZA',
        vehicleColor: 'Merah Maroon',
        vehicleYear: '2018',
        vehicleChasisNumber: '9011781001819138191',
        vehicleMachineNumber: '99401918190301938',
        vehicleSTNKExpire: '2024-01-29',
      ),
      VehicleCostumer(
        vehicleName: 'Alphard',
        vehiclePoliceNumber: 'DB 5912 ZA',
        vehicleColor: 'Hitam',
        vehicleYear: '2017',
        vehicleChasisNumber: '9011781001819138191',
        vehicleMachineNumber: '99401918190301938',
        vehicleSTNKExpire: '2023-01-29',
      ),
    ];
  }
}
