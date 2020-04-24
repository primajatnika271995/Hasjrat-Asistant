import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_event.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_state.dart';
import 'package:salles_tools/src/models/banner_model.dart';
import 'package:salles_tools/src/models/catalog_model.dart';
import 'package:salles_tools/src/models/detail_catalog_model.dart';
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
        List<CatalogModel> value = await _catalogService.fetchCatalogList();
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

    if (event is FetchCatalogByCategory) {
      yield CatalogLoading();

      try {
        List<CatalogModel> value = await _catalogService.fetchCatalogByCategoryList(event.value);
        if (value == null) {
          yield CatalogByCategoryFailed();
        } else {
          yield CatalogDisposeLoading();
          yield CatalogByCategorySuccess(value);
        }
      } catch (e) {
        log.warning("Error : ${e.toString()}");
        yield CatalogByCategoryFailed();
      }
    }

    if (event is FetchDetailCatalog) {
      yield CatalogLoading();

      try {
        DetailCatalogModel value = await _catalogService.detailCatalog(event.value);
        if (value == null) {
          yield CatalogDisposeLoading();
          yield DetailCatalogFailed();
        } else {
          yield CatalogDisposeLoading();
          yield DetailCatalogSuccess(value);
        }
      } catch (e) {
        log.warning("Error Bloc Detail Catalog : ${e.toString()}");
        yield DetailCatalogFailed();
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
