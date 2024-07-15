import 'package:top_ups/core/database/localstorage.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/features/app/data/dtos/transition_dto.dart';

import '../../domain/entities/transition_entity.dart';
import '../../domain/types/signatures.dart';

abstract class SaveTransitionsRepository {
  Future<SaveTransitionResult> call(List<TransitionEntity> transitions);
}

class LocalSaveTransitionsRepository implements SaveTransitionsRepository {
  LocalSaveTransitionsRepository({
    required this.localStorage,
  });
  final LocalStorage localStorage;
  @override
  Future<SaveTransitionResult> call(List<TransitionEntity> transitions) async {
    try {
      await localStorage.insert(
          'transitions',
          transitions
              .map(
                (e) => (e as TransitionDTO).toMap(),
              )
              .toList());
      return SaveTransitionResult.right(true);
    } catch (error) {
      return SaveTransitionResult.left(
        const ServerFailure(),
      );
    }
  }
}
