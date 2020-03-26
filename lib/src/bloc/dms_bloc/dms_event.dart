import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/services/dms_service.dart';

import '../../services/dms_service.dart';

class DmsEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchPriceList extends DmsEvent {
  final PriceListPost value;

  FetchPriceList(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchClass1Item extends DmsEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchItemModel extends DmsEvent {
  final ItemModelPost value;

  FetchItemModel(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchItemType extends DmsEvent {
  final ItemModelPost value;

  FetchItemType(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchItemList extends DmsEvent {
  final ItemListPost value;

  FetchItemList(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class CreateProspect extends DmsEvent {
  final ProspectPost value;
  CreateProspect(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class ResetDms extends DmsEvent {}
