// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NumberDataStore on _NumberDataStoreBase, Store {
  Computed<RequestState> _$stateComputed;

  @override
  RequestState get state =>
      (_$stateComputed ??= Computed<RequestState>(() => super.state)).value;

  final _$_numberDataAtom = Atom(name: '_NumberDataStoreBase._numberData');

  @override
  ObservableFuture<NumberData> get _numberData {
    _$_numberDataAtom.context.enforceReadPolicy(_$_numberDataAtom);
    _$_numberDataAtom.reportObserved();
    return super._numberData;
  }

  @override
  set _numberData(ObservableFuture<NumberData> value) {
    _$_numberDataAtom.context.conditionallyRunInAction(() {
      super._numberData = value;
      _$_numberDataAtom.reportChanged();
    }, _$_numberDataAtom, name: '${_$_numberDataAtom.name}_set');
  }

  final _$numberAtom = Atom(name: '_NumberDataStoreBase.number');

  @override
  int get number {
    _$numberAtom.context.enforceReadPolicy(_$numberAtom);
    _$numberAtom.reportObserved();
    return super.number;
  }

  @override
  set number(int value) {
    _$numberAtom.context.conditionallyRunInAction(() {
      super.number = value;
      _$numberAtom.reportChanged();
    }, _$numberAtom, name: '${_$numberAtom.name}_set');
  }

  final _$factAtom = Atom(name: '_NumberDataStoreBase.fact');

  @override
  String get fact {
    _$factAtom.context.enforceReadPolicy(_$factAtom);
    _$factAtom.reportObserved();
    return super.fact;
  }

  @override
  set fact(String value) {
    _$factAtom.context.conditionallyRunInAction(() {
      super.fact = value;
      _$factAtom.reportChanged();
    }, _$factAtom, name: '${_$factAtom.name}_set');
  }

  final _$_NumberDataStoreBaseActionController =
      ActionController(name: '_NumberDataStoreBase');

  @override
  void getTriviaData(int num, String type) {
    final _$actionInfo = _$_NumberDataStoreBaseActionController.startAction();
    try {
      return super.getTriviaData(num, type);
    } finally {
      _$_NumberDataStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
