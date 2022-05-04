import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';

import '../filters/project.dart';
import '../models/project.dart';
import 'abstract.dart';

class ProjectRepository
    extends AbstractFirestoreRepository<Project, ProjectFilter> {
  @override
  CollectionReference<Map<String, dynamic>> getCollection() {
    return FirebaseFirestore.instance.collection('projects');
  }

  @override
  ProjectQueryBuilder createQueryBuilder(ProjectFilter filter) {
    return ProjectQueryBuilder(filter);
  }

  static Project fromFirestoreStatic(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Project.fromIdAndMap(snapshot.id, snapshot.data() ?? {});
  }

  @override
  Project fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return fromFirestoreStatic(snapshot, options);
  }
}

class ProjectQueryBuilder extends QueryBuilder<Project> {
  final ProjectFilter filter;

  Query<Project> _query = _createEmptyQuery();

  @override
  Query<Project> get query => _query;

  ProjectQueryBuilder(this.filter) {
    // TODO: Add filter conditions.
  }

  static Query<Project> _createEmptyQuery() {
    return FirebaseFirestore.instance.collection('projects').withConverter(
          fromFirestore: ProjectRepository.fromFirestoreStatic,
          toFirestore: (_, __) => throw UnimplementedError(),
        );
  }
}
