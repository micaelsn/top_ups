import 'package:top_ups/core/returns/result_type.dart';

import '../entities/transition_entity.dart';

typedef SaveTransitionResult = Result<bool>;
typedef GetTransitionResult = Result<List<TransitionEntity>>;
