// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailUps_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailUpsStore on _DetailUpsStore, Store {
  late final _$upsDetailAtom =
      Atom(name: '_DetailUpsStore.upsDetail', context: context);

  @override
  UpsDetail? get upsDetail {
    _$upsDetailAtom.reportRead();
    return super.upsDetail;
  }

  @override
  set upsDetail(UpsDetail? value) {
    _$upsDetailAtom.reportWrite(value, super.upsDetail, () {
      super.upsDetail = value;
    });
  }

  late final _$_DetailUpsStoreActionController =
      ActionController(name: '_DetailUpsStore', context: context);

  @override
  void refreshController(UpsDetail updatedUpsDetail) {
    final _$actionInfo = _$_DetailUpsStoreActionController.startAction(
        name: '_DetailUpsStore.refreshController');
    try {
      return super.refreshController(updatedUpsDetail);
    } finally {
      _$_DetailUpsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
upsDetail: ${upsDetail}
    ''';
  }
}
