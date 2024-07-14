import 'package:fpdart/fpdart.dart';
import 'package:top_ups/core/errors/failure.dart';

typedef Result<E> = Either<Failure, E>;
