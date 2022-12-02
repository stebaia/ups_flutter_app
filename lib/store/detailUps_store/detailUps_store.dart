import 'package:mobx/mobx.dart';

import '../../model/controller.dart';
import '../../model/upsDetail.dart';

part 'detailUps_store.g.dart';

class DetailUpsStore = _DetailUpsStore with _$DetailUpsStore;

abstract class _DetailUpsStore with Store {
  @observable
  UpsDetail? upsDetail = null;

  bool flagRequested = false;

  @action
  void refreshController(UpsDetail updatedUpsDetail) {
    upsDetail = updatedUpsDetail;
    if (upsDetail != null) {
      flagRequested = true;
    }
  }
}
