import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/sales_month_service.dart';

class SalesMonthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchSalesMonth extends SalesMonthEvent {
  final SalesMonthPost value;

  FetchSalesMonth(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}