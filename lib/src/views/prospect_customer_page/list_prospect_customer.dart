import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_state.dart';
import 'package:salles_tools/src/models/prospect_model.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/bottom_loader_content.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/prospect_customer_page/details_prospect_customer.dart';

class ProspectCustomerListView extends StatefulWidget {
  @override
  _ProspectCustomerListViewState createState() => _ProspectCustomerListViewState();
}

class _ProspectCustomerListViewState extends State<ProspectCustomerListView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  var searchCtrl = new TextEditingController();
  var _currentSelectFilter = "by Name";

  Completer<void> _refreshCompleter;

  void _onViewDetailsProspect(Datum value) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ProspectDetailsView(value),
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

  void onFilterLead() {
    switch (_currentSelectFilter) {
      case "by Name":
      // ignore: close_sinks
        final prospectBloc = BlocProvider.of<DmsBloc>(context);
        prospectBloc.add(FetchProspectFilter(ProspectGet(
          leadCode: "",
          leadName: searchCtrl.text,
        )));
        break;
      case "by Code":
      // ignore: close_sinks
        final prospectBloc = BlocProvider.of<DmsBloc>(context);
        prospectBloc.add(FetchProspectFilter(ProspectGet(
          leadCode: searchCtrl.text,
          leadName: "",
        )));
        break;
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      // ignore: close_sinks
      final leadBloc = BlocProvider.of<DmsBloc>(context);
      leadBloc.add(FetchProspect(ProspectGet(
        leadCode: "",
        leadName: "",
      )));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
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
          "Data Prospek Pelanggan",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: searchContent(),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<DmsBloc, DmsState>(
        listener: (context, state) {
          if (state is DmsLoading) {
            onLoading(context);
          }

          if (state is DmsDisposeLoading) {
            Navigator.of(context, rootNavigator: false).pop();
          }
        },
        child: RefreshIndicator(
          onRefresh: () {
            // ignore: close_sinks
            final leadBloc = BlocProvider.of<DmsBloc>(context);
            leadBloc.add(RefreshProspect(ProspectGet(
              leadCode: "",
              leadName: "",
            )));
            return _refreshCompleter.future;
          },
          child: BlocBuilder<DmsBloc, DmsState>(
            builder: (context, state) {
              if (state is DmsInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is DmsFailed) {
                Navigator.of(context, rootNavigator: true).pop();
                return Center(
                  child: Image.asset(
                    "assets/icons/empty_icon.png",
                    height: 100,
                    color: HexColor('#C61818'),
                  ),
                );
              }

              if (state is DmsError) {
                Navigator.of(context, rootNavigator: true).pop();
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: <Widget>[
                        Image.asset("assets/icons/error_banner.jpg", height: 200),
                        Text("502 Error Bad Gateway"),
                      ],
                    ),
                  ),
                );
              }

              if (state is ProspectSuccess) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();

                return ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return index >= state.prospects.length
                        ? BottomLoader()
                        : SlidableCustomerView(
                      index: index,
                      value: state.prospects[index],
                      callback: () {
                        _onViewDetailsProspect(state.prospects[index]);
                      },
                    );
                  },
                  itemCount: state.hasReachedMax
                      ? state.prospects.length
                      : state.prospects.length + 1,
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget searchContent() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
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
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabled: false,
                        contentPadding: EdgeInsets.only(bottom: 18),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF6991C7),
                          size: 24.0,
                        ),
                        hintText: "Cari",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      controller: searchCtrl,
                      onEditingComplete: () {
                        onFilterLead();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 40,
              child: FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      hintText: 'Filter',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      contentPadding:
                      EdgeInsets.only(bottom: 18, left: 18, right: 18),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentSelectFilter,
                        hint: Text('Filter'),
                        isDense: true,
                        onChanged: (String newVal) {
                          setState(() {
                            _currentSelectFilter = newVal;
                            state.didChange(newVal);
                          });
                        },
                        items: [
                          'by Name',
                          'by Code'
                        ].map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(val, style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),),
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
          ),
        ),
      ],
    );
  }
}

class SlidableCustomerView extends StatelessWidget {
  final Function callback;
  final Datum value;
  final int index;
  SlidableCustomerView({Key key, this.callback, this.value, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          elevation: 5,
          child: ListTile(
            onTap: () {
              this.callback();
            },
//            leading: CircleAvatar(
//              radius: 25,
//              backgroundColor: Colors.indigoAccent,
//              foregroundColor: Colors.white,
//              backgroundImage: NetworkImage(
//                  "https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg"),
//            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                "${value.leadCode}",
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${value.cardName.toUpperCase()}",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "${value.phone1}",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Container(
                        height: 18,
                        width: 80,
                        decoration: BoxDecoration(
                          color: value.docStatus == "Open" ? Colors.blue : Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "${value.docStatus}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      value.prospectDate == null
                          ? "No Date"
                          : "${DateTime.parse(value.prospectDate).day}/${DateTime.parse(value.prospectDate).month}/${DateTime.parse(value.prospectDate).year}",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
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
