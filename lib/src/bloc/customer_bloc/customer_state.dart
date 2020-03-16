import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/district_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/gender_model.dart';
import 'package:salles_tools/src/models/job_model.dart';
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

class CustomerGender extends CustomerState {
  final _data;

  CustomerGender(this._data);
  GenderModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CustomerLocation extends CustomerState {
  final _data;

  CustomerLocation(this._data);
  GenderModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CustomerJob extends CustomerState {
  final _data;

  CustomerJob(this._data);
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