import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/district_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/gender_model.dart';
import 'package:salles_tools/src/models/job_model.dart';
import 'package:salles_tools/src/models/location_model.dart';
import 'package:salles_tools/src/models/province_model.dart';
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

class CustomerProvince extends CustomerState {
  final _data;

  CustomerProvince(this._data);
  ProvinceModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CustomerDistrict extends CustomerState {
  final _data;

  CustomerDistrict(this._data);
  DistrictModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CustomerSubDistrict extends CustomerState {
  final _data;

  CustomerSubDistrict(this._data);
  SubDistrictModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CustomerError extends CustomerState {
  final _data;

  CustomerError(this._data);
  ErrorModel get error => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}