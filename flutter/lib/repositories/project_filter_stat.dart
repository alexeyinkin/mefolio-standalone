import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';

import '../models/project_filter_stat.dart';
import 'abstract.dart';

class ProjectFilterStatRepository extends AbstractFirestoreRepository<ProjectFilterStat, AbstractFilter> {
  @override
  CollectionReference<Map<String, dynamic>> getCollection() {
    return FirebaseFirestore.instance.collection('ProjectFilterStat');
  }

  @override
  QueryBuilder<ProjectFilterStat> createQueryBuilder(AbstractFilter filter) {
    throw UnimplementedError();
  }

  static ProjectFilterStat fromFirestoreStatic(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return ProjectFilterStat.fromIdAndMap(snapshot.id, snapshot.data() ?? {});
  }

  @override
  ProjectFilterStat fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    return fromFirestoreStatic(snapshot, options);
  }
}
