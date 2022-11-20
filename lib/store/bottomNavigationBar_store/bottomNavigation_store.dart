import 'package:mobx/mobx.dart';

part 'bottomNavigation_store.g.dart';

class BottomNavigationStore = _BottomNavigationStore
    with _$BottomNavigationStore;

abstract class _BottomNavigationStore with Store {
  @observable
  int selectedIndex = 0;

  @action
  void setSelected(int value) {
    selectedIndex = value;
  }
}
