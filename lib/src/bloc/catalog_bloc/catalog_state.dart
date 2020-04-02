import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/catalog_model.dart';

class CatalogState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogDisposeLoading extends CatalogState {}

class CatalogListFailed extends CatalogState {}

class CatalogListSuccess extends CatalogState {
  final _data;

  CatalogListSuccess(this._data);
  List<CatalogModel> get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}
