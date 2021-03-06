import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/district_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/gender_model.dart';
import 'package:salles_tools/src/models/job_model.dart';
import 'package:salles_tools/src/models/location_model.dart';
import 'package:salles_tools/src/models/national_holiday_model.dart';
import 'package:salles_tools/src/models/province_model.dart';
import 'package:salles_tools/src/models/stnk_expired_model.dart';
import 'package:salles_tools/src/models/sub_district_model.dart';

class CustomerState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerDisposeLoading extends CustomerState {}

class CustomerFailed extends CustomerState {}

class CustomerSuccess extends CustomerState {
  final _data;

  CustomerSuccess(this._data);
  CustomerModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class GenderSuccess extends CustomerState {
  final _data;

  GenderSuccess(this._data);
  GenderModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class LocationSuccess extends CustomerState {
  final _data;

  LocationSuccess(this._data);
  LocationModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class JobSuccess extends CustomerState {
  final _data;

  JobSuccess(this._data);
  JobModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class ProvinceSuccess extends CustomerState {
  final _data;

  ProvinceSuccess(this._data);
  ProvinceModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class DistrictSuccess extends CustomerState {
  final _data;

  DistrictSuccess(this._data);
  DistrictModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class SubDistrictSuccess extends CustomerState {
  final _data;

  SubDistrictSuccess(this._data);
  SubDistrictModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CreateContactSuccess extends CustomerState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CreateContactError extends CustomerState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StnkExpiredSuccess extends CustomerState {
  final _data;

  StnkExpiredSuccess(this._data);
  List<StnkExpiredModel> get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class StnkExpiredFailed extends CustomerState {}

class NationalHolidaySuccess extends CustomerState {
  final _data;

  NationalHolidaySuccess(this._data);
  List<NationalHolidayModel> get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CustomerError extends CustomerState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}