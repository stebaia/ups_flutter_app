// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControllerStore on _ControllerStore, Store {
  late final _$controllersAtom =
      Atom(name: '_ControllerStore.controllers', context: context);

  @override
  List<Controller> get controllers {
    _$controllersAtom.reportRead();
    return super.controllers;
  }

  @override
  set controllers(List<Controller> value) {
    _$controllersAtom.reportWrite(value, super.controllers, () {
      super.controllers = value;
    });
  }

  late final _$_ControllerStoreActionController =
      ActionController(name: '_ControllerStore', context: context);

  @override
  void refreshController(List<Controller> updatedController) {
    final _$actionInfo = _$_ControllerStoreActionController.startAction(
        name: '_ControllerStore.refreshController');
    try {
      return super.refreshController(updatedController);
    } finally {
      _$_ControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
controllers: ${controllers}
    ''';
  }
}
