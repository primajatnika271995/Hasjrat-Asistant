import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/class1_item_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/item_list_model.dart';
import 'package:salles_tools/src/models/item_model.dart';
import 'package:salles_tools/src/models/price_list_model.dart';
import 'package:salles_tools/src/models/program_penjualan_model.dart'
    as programPenjualan;
import 'package:salles_tools/src/models/prospect_model.dart' as prospect;

class DmsState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DmsInitial extends DmsState {}

class DmsLoading extends DmsState {}

class DmsDisposeLoading extends DmsState {}

class DmsFailed extends DmsState {}

class PriceListSuccess extends DmsState {
  final _data;

  PriceListSuccess(this._data);
  PriceListModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class Class1ItemSuccess extends DmsState {
  final _data;

  Class1ItemSuccess(this._data);
  Class1ItemModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class ItemModelSuccess extends DmsState {
  final _data;

  ItemModelSuccess(this._data);
  ItemModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class ItemTypeSuccess extends DmsState {
  final _data;

  ItemTypeSuccess(this._data);
  ItemModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class ItemListSuccess extends DmsState {
  final _data;

  ItemListSuccess(this._data);
  ItemListModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class ItemListFailed extends DmsState {}

class CreateProspectSuccess extends DmsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProspectSuccess extends DmsState {
  final List<prospect.Datum> prospects;
  final bool hasReachedMax;

  ProspectSuccess({this.prospects, this.hasReachedMax});

  ProspectSuccess copyWith(
      {List<prospect.Datum> prospect, bool hasReachedMax}) {
    return ProspectSuccess(
      prospects: prospect ?? this.prospects,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [prospects, hasReachedMax];

  @override
  String toString() =>
      'Prospect Loaded { prospect: ${prospects.length}, hasReachedMax: $hasReachedMax }';
}

class CreateProspectError extends DmsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DmsError extends DmsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ListProgramPenjualanError extends DmsState {}

class ListProgramPenjualanSuccess extends DmsState {
  final _data;

  ListProgramPenjualanSuccess(this._data);
  programPenjualan.ProgramPenjualanModel get value => _data;

  @override
  List<Object> get props => [_data];
}
