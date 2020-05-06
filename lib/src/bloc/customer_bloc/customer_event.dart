import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/customer_service.dart';

class CustomerEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchCustomerBirthDay extends CustomerEvent {
  final CustomerPost value;

  FetchCustomerBirthDay(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
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

class FetchDistrict extends CustomerEvent {
  final String provinceCode;
  FetchDistrict(this.provinceCode);

  @override
  // TODO: implement props
  List<Object> get props => [provinceCode];
}

class FetchSubDistrict extends CustomerEvent {
  final String provinceCode;
  final String districtCode;
  FetchSubDistrict(this.provinceCode, this.districtCode);

  @override
  // TODO: implement props
  List<Object> get props => [provinceCode, districtCode];
}

class FetchStnkExpired extends CustomerEvent {

}

class CreateContact extends CustomerEvent {
  final ContactPost value;
  CreateContact(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class ResetCustomer extends CustomerEvent {}