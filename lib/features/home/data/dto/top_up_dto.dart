import '../../domain/entities/top_up_entity.dart';

class TopUpDTO extends TopUpEntity {
  TopUpDTO({
    required super.currency,
    required super.value,
  });
}
