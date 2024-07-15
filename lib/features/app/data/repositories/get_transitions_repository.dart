import 'package:top_ups/core/database/localstorage.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/features/app/data/dtos/transition_dto.dart';

import '../../domain/types/signatures.dart';

abstract class GetTransitionsRepository {
  Future<GetTransitionResult> call();
}

class LocalGetTransitionsRepository implements GetTransitionsRepository {
  LocalGetTransitionsRepository({
    required this.localStorage,
  });
  final LocalStorage localStorage;
  @override
  Future<GetTransitionResult> call() async {
    try {
      final response = await localStorage.get('transitions');
      final result = (response as List?)
              ?.map((item) =>
                  TransitionDTO.fromMap(Map<String, dynamic>.from(item)))
              .toList() ??
          [];

      return GetTransitionResult.right(result);
    } catch (error) {
      return GetTransitionResult.left(
        const ServerFailure(),
      );
    }
  }
}
