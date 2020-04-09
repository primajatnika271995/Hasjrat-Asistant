import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/knowledge_base_bloc/knowledge_base_event.dart';
import 'package:salles_tools/src/bloc/knowledge_base_bloc/knowledge_base_state.dart';
import 'package:salles_tools/src/models/knowledge_base_model.dart';
import 'package:salles_tools/src/services/knowledge_base_service.dart';

class KnowledgeBaseBloc extends Bloc<KnowledgeBaseEvent, KnowledgeBaseState> {
  KnowledgeBaseService  _knowledgeBaseService;
  KnowledgeBaseBloc(this._knowledgeBaseService);

  @override
  // TODO: implement initialState
  KnowledgeBaseState get initialState => KnowledgeBaseInitial();

  @override
  Stream<KnowledgeBaseState> mapEventToState(KnowledgeBaseEvent event) async* {
    if (event is FetchKnowledgeBase) {
      yield KnowledgeBaseLoading();

      try {
        KnowladgeBaseModel value = await _knowledgeBaseService.questionAsk();

        if (value.data == null || value.data.isEmpty) {
          yield KnowledgeBaseFailed();
        } else {
          yield KnowledgeBaseDisposeLoading();
          yield KnowledgeBaseSuccess(value);
        }
      } catch(err) {
        yield KnowledgeBaseDisposeLoading();
        yield KnowledgeBaseError();
      }
    }

    if (event is SearchKnowledgeBase) {
      yield KnowledgeBaseLoading();

      try {
        KnowladgeBaseModel value = await _knowledgeBaseService.questionAsk();

        if (value.data == null || value.data.isEmpty) {
          yield KnowledgeBaseFailed();
        } else {

          yield KnowledgeBaseDisposeLoading();
          yield KnowledgeBaseSuccess(value);
        }
      } catch(err) {
        yield KnowledgeBaseDisposeLoading();
        yield KnowledgeBaseError();
      }
    }
  }
}