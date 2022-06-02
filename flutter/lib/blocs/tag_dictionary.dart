import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';

import '../models/tag.dart';

class TagDictionaryBloc extends FirestoreLiveSingleDocumentCollectionBloc<Tag> {
  TagDictionaryBloc() : super(
    documentReference: FirebaseFirestore.instance.doc('Dictionary/Tag'),
    fromIdAndMap: Tag.fromIdAndMap,
  );
}
