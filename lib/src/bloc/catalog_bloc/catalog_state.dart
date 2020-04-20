import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/banner_model.dart';
import 'package:salles_tools/src/models/catalog_model.dart';
import 'package:salles_tools/src/models/detail_catalog_model.dart';

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

class DetailCatalogFailed extends CatalogState {}

class DetailCatalogSuccess extends CatalogState {
  final _data;

  DetailCatalogSuccess(this._data);
  DetailCatalogModel get value => _data;

  @override
  List<Object> get props => [_data];
}

class BannerPromotionFailed extends CatalogState {}

class BannerPromotionError extends CatalogState {}

class BannerPromotionSuccess extends CatalogState {
  final _data;

  BannerPromotionSuccess(this._data);
  BannerModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [this._data];
}
