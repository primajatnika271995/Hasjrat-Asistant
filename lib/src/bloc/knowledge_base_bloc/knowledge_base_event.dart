import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/sales_month_service.dart';

class KnowledgeBaseEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SearchKnowledgeBase extends KnowledgeBaseEvent {
  final String query;
  SearchKnowledgeBase(this.query);

  @override
  // TODO: implement props
  List<Object> get props => [query];
}

class FetchKnowledgeBase extends KnowledgeBaseEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
