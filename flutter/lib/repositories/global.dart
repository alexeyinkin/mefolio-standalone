import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';

import '../models/global.dart';
import 'abstract.dart';

class GlobalRepository
    extends AbstractFirestoreRepository<Global, AbstractFilter> {
  @override
  CollectionReference<Map<String, dynamic>> getCollection() {
    return FirebaseFirestore.instance.collection('Global');
  }

  @override
  QueryBuilder<Global> createQueryBuilder(AbstractFilter filter) {
    throw UnimplementedError();
  }

  static Global fromFirestoreStatic(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Global.fromMap(snapshot.data() ?? {});
  }

  @override
  Global fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return fromFirestoreStatic(snapshot, options);
  }
}
