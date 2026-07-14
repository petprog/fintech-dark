import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../features.dart';

@injectable
class ToggleFreezeCardUsecase {
  final DashboardRepository repository;

  const ToggleFreezeCardUsecase(this.repository);

  Future<Either<Failure, CardEntity>> call({
    required String cardId,
    required bool freeze,
  }) {
    return repository.toggleFreezeCard(cardId: cardId, freeze: freeze);
  }
}
