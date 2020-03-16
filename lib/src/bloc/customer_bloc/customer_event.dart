import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/customer_service.dart';

class CustomerEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchCustomer extends CustomerEvent {
  final CustomerPost value;

  FetchCustomer(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchGender extends CustomerEvent {
  final String value;
  FetchGender(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchLocation extends CustomerEvent {
  final String value;
  FetchLocation(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchJob extends CustomerEvent {
  final String value;
  FetchJob(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchProvince extends CustomerEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ResetCustomer extends CustomerEvent {}