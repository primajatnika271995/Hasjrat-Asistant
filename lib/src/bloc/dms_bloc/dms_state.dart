import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/class1_item_model.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/item_list_model.dart';
import 'package:salles_tools/src/models/item_model.dart';
import 'package:salles_tools/src/models/price_list_model.dart';

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

class ItemListFailed extends DmsState {

}

class CreateProspectSuccess extends DmsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CreateProspectError extends DmsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DmsError extends DmsState {
  final _data;

  DmsError(this._data);
  ErrorModel get error => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

