import 'package:mobx/mobx.dart';

import '../../model/controller.dart';

part 'controller_store.g.dart';

class ControllerStore = _ControllerStore with _$ControllerStore;

abstract class _ControllerStore with Store {
  @observable
  List<Controller> controllers = [];

  bool flagRequested = false;

  @action
  void refreshController(List<Controller> updatedController) {
    controllers = updatedController;
    if (controllers.isNotEmpty) {
      flagRequested = true;
    }
  }
}
