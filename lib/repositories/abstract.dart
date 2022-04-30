import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';

abstract class AbstractRepository<T, F extends AbstractFilter> {
  static const fetchSize = 20;

  final _frozenListBlocs = <String, FirestoreFrozenLazyLoadBloc<T>>{};

  LazyLoadBloc<T> frozenListBloc(F filter) {
    return _frozenListBlocs[filter.hash] ??
        _createAndCacheFrozenListBloc(filter);
  }

  QueryBuilder<T> createQueryBuilder(F filter);

  LazyLoadBloc<T> _createAndCacheFrozenListBloc(F filter) {
    final result = FirestoreFrozenLazyLoadBloc(
      query: createQueryBuilder(filter).query,
      fetchSize: fetchSize,
    );

    _frozenListBlocs[filter.hash] = result;
    return result;
  }
}
