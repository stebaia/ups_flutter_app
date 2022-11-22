// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailController_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailControllerStore on _DetailControllerStore, Store {
  late final _$controllerAtom =
      Atom(name: '_DetailControllerStore.controller', context: context);

  @override
  Controller? get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(Controller? value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  late final _$_DetailControllerStoreActionController =
      ActionController(name: '_DetailControllerStore', context: context);

  @override
  void refreshController(Controller updatedController) {
    final _$actionInfo = _$_DetailControllerStoreActionController.startAction(
        name: '_DetailControllerStore.refreshController');
    try {
      return super.refreshController(updatedController);
    } finally {
      _$_DetailControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
controller: ${controller}
    ''';
  }
}
