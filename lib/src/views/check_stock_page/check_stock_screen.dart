import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_bloc.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_event.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_state.dart';

class CheckStockScreen extends StatefulWidget {
  CheckStockScreen({Key key}) : super(key: key);

  @override
  _CheckStockScreenState createState() => _CheckStockScreenState();
}

class _CheckStockScreenState extends State<CheckStockScreen> {

  @override
  void initState() {
    // TODO: implement initState
    final checkStockBloc = BlocProvider.of<CheckStockBloc>(context);
    checkStockBloc.add(FetchStockHo());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is page check Stock\nTBD MOCKUP!"),
      ),
    );
  }
}
