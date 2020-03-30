import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/sales_of_the_month_model.dart';

class SalesMonthState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SalesMonthInitial extends SalesMonthState {

}

class SalesMonthSuccess extends SalesMonthState {
  final _data;

  SalesMonthSuccess(this._data);
  SalesOfTheMonthModel get salesData => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class SalesMonthFailed extends SalesMonthState {

}

class SalesMonthError extends SalesMonthState {

}