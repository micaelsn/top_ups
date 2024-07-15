import '../../data/repositories/get_transitions_repository.dart';
import '../types/signatures.dart';

abstract class GetTransitionsUsecase {
  Future<GetTransitionResult> call();
}

class LocalGetTransitionsUsecase implements GetTransitionsUsecase {
  GetTransitionsRepository repository;

  LocalGetTransitionsUsecase({
    required this.repository,
  });

  @override
  Future<GetTransitionResult> call() => repository();
}
