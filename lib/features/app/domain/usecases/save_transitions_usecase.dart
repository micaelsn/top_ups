import '../../data/repositories/save_transitions_repository.dart';
import '../entities/transition_entity.dart';
import '../types/signatures.dart';

abstract class SaveTransitionsUsecase {
  Future<SaveTransitionResult> call(
      {required List<TransitionEntity> transitions});
}

class LocalSaveTransitionsUsecase implements SaveTransitionsUsecase {
  SaveTransitionsRepository repository;

  LocalSaveTransitionsUsecase({
    required this.repository,
  });

  @override
  Future<SaveTransitionResult> call(
          {required List<TransitionEntity> transitions}) =>
      repository(transitions);
}
