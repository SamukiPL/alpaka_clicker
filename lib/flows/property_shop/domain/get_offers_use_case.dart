import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/properties_repository.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOffersUseCase {
  final PropertiesRepository _repository;

  GetOffersUseCase(this._repository);

  Stream<Result<List<PropertyModel>>> call() => _repository.getPropertiesList();
}
