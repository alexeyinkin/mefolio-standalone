import 'package:get_it/get_it.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';

import '../models/global.dart';
import '../repositories/global.dart';

class GlobalBloc extends FirestoreLiveByIdBloc<Global> {
  GlobalBloc()
      : super(
          collectionReference: GetIt.instance
              .get<GlobalRepository>()
              .getCollection()
              .withConverter(
                fromFirestore: GlobalRepository.fromFirestoreStatic,
                toFirestore: (_, __) => throw UnimplementedError(),
              ),
          id: Global.singleId,
        );
}
