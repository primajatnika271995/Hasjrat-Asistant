import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/models/activity_report_model.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class ActivityReportDetailsView extends StatefulWidget {
  final Datum data;
  ActivityReportDetailsView({this.data});

  @override
  _ActivityReportDetailsViewState createState() =>
      _ActivityReportDetailsViewState();
}

class _ActivityReportDetailsViewState extends State<ActivityReportDetailsView> {
  var dateFormat = DateFormat("yyyy/MM/dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Laporan Kegiatan",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.data.files.isNotEmpty
              ? Image.network(
                  "${widget.data.files[0].url}",
                  height: 250,
                  fit: BoxFit.cover,
                  width: screenWidth(context),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "${widget.data.title}",
              style: TextStyle(
                letterSpacing: 1.0,
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 20),
            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.data.provinceCode != null ||
                        widget.data.provinceName != null ||
                        widget.data.kabupatenCode != null ||
                        widget.data.kabupatenName != null ||
                        widget.data.kecamatanCode != null ||
                        widget.data.kecamatanName != null
                    ? Text(
                        "${widget.data.provinceName}, ${widget.data.kecamatanName}, ${widget.data.kecamatanName}",
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : SizedBox(),
                Text(
                  "${widget.data.alamat}",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 2),
                child: Icon(Icons.date_range, size: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 5),
                child: Text(
                  "Dibuat tanggal ${dateFormat.format(DateTime.parse(widget.data.createdDate.toString()))}",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${widget.data.description}",
                  style: TextStyle(
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
