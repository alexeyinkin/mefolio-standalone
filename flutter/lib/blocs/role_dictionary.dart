import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';

import '../models/role.dart';

class RoleDictionaryBloc extends FirestoreLiveSingleDocumentCollectionBloc<Role> {
  RoleDictionaryBloc() : super(
    documentReference: FirebaseFirestore.instance.doc('Dictionary/Role'),
    fromIdAndMap: Role.fromIdAndMap,
  );
}
