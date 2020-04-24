import 'package:equatable/equatable.dart';

import '../../services/catalog_service.dart';

class CatalogEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchCatalogList extends CatalogEvent {
  @override
  List<Object> get props => [];
}

class FetchCatalogByCategory extends CatalogEvent {
  final CategoryCatalogPost value;

  FetchCatalogByCategory(this.value);
  @override
  List<Object> get props => [value];
}

class FetchDetailCatalog extends CatalogEvent {
  final DetailCatalogPost value;

  FetchDetailCatalog(this.value);
  @override
  List<Object> get props => [value];
}

class FetchBannerPromotionList extends CatalogEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
