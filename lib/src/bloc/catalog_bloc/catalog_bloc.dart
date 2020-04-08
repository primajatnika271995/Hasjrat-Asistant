import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_event.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_state.dart';
import 'package:salles_tools/src/models/banner_model.dart';
import 'package:salles_tools/src/models/catalog_model.dart';
import 'package:salles_tools/src/services/catalog_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogService _catalogService;
  CatalogBloc(this._catalogService);
  @override
  // TODO: implement initialState
  CatalogState get initialState => CatalogInitial();

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {
    if (event is FetchCatalogList) {
      yield CatalogLoading();

      try {
        CatalogModel value = await _catalogService.fetchCatalogList();
        if (value == null) {
          yield CatalogListFailed();
        } else {
          yield CatalogDisposeLoading();
          yield CatalogListSuccess(value);
        }
      } catch (e) {
        log.warning("Error : ${e.toString()}");
        yield CatalogListFailed();
      }
    }

    if (event is FetchBannerPromotionList) {
      yield CatalogLoading();

      try {
        BannerModel value = await _catalogService.bannerPromotion();

        if (value.data.isEmpty || value.data == null) {
          yield CatalogListFailed();
        } else {
          yield CatalogDisposeLoading();
          yield BannerPromotionSuccess(value);
        }
      } catch (err) {
        log.warning("Error : ${err.toString()}");
        yield CatalogListFailed();
      }
    }
  }
}
