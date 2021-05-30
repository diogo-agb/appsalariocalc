// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultado_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResultadoStore on _ResultadoStoreBase, Store {
  final _$valueAtom = Atom(name: '_ResultadoStoreBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$isLoadedAtom = Atom(name: '_ResultadoStoreBase.isLoaded');

  @override
  bool get isLoaded {
    _$isLoadedAtom.reportRead();
    return super.isLoaded;
  }

  @override
  set isLoaded(bool value) {
    _$isLoadedAtom.reportWrite(value, super.isLoaded, () {
      super.isLoaded = value;
    });
  }

  final _$_ResultadoStoreBaseActionController =
      ActionController(name: '_ResultadoStoreBase');

  @override
  dynamic setIsLoaded(bool value) {
    final _$actionInfo = _$_ResultadoStoreBaseActionController.startAction(
        name: '_ResultadoStoreBase.setIsLoaded');
    try {
      return super.setIsLoaded(value);
    } finally {
      _$_ResultadoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo = _$_ResultadoStoreBaseActionController.startAction(
        name: '_ResultadoStoreBase.increment');
    try {
      return super.increment();
    } finally {
      _$_ResultadoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
isLoaded: ${isLoaded}
    ''';
  }
}
