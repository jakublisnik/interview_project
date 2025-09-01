import '../../../../core/error/failure.dart';
import '../entities/position_entity.dart';

typedef PositionResult = ({PositionEntity? data, Failure? failure});

abstract interface class LocationRepository {
  Future<PositionResult> getCurrentPosition();
}