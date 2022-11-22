import 'package:mobx/mobx.dart';

import '../../model/controller.dart';

part 'detailController_store.g.dart';

class DetailControllerStore = _DetailControllerStore
    with _$DetailControllerStore;

abstract class _DetailControllerStore with Store {
  @observable
  Controller? controller = null;

  bool flagRequested = false;

  @action
  void refreshController(Controller updatedController) {
    controller = updatedController;
    if (controller != null) {
      flagRequested = true;
    }
  }
}
