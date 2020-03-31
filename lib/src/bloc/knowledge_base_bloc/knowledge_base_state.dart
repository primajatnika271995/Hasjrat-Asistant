import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/knowledge_base_model.dart';
import 'package:salles_tools/src/models/sales_of_the_month_model.dart';

class KnowledgeBaseState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class KnowledgeBaseInitial extends KnowledgeBaseState {

}

class KnowledgeBaseLoading extends KnowledgeBaseState {

}

class KnowledgeBaseDisposeLoading extends KnowledgeBaseState {

}

class KnowledgeBaseSuccess extends KnowledgeBaseState {
  final _data;

  KnowledgeBaseSuccess(this._data);
  KnowladgeBaseModel get salesData => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class KnowledgeBaseFailed extends KnowledgeBaseState {

}

class KnowledgeBaseError extends KnowledgeBaseState {

}