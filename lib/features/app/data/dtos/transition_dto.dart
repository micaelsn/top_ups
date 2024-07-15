import '../../domain/entities/transition_entity.dart';

class TransitionDTO extends TransitionEntity {
  TransitionDTO({
    required super.type,
    required super.value,
    required super.date,
  });
}
