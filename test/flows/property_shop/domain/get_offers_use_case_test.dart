import 'package:alpaka_clicker/flows/property_shop/domain/get_offers_use_case.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../testUtils/expect_throw.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  setUpAll(() {
    resetMockitoState();
  });
  final propertiesRepository = MockPropertiesRepository();

  test("GetOffersUseCase return success without any change", () async {
    final subject = PublishSubject<Result<List<PropertyModel>>>();
    when(propertiesRepository.getPropertiesList()).thenAnswer((realInvocation) => subject.stream);
    final success = Result.success(List<PropertyModel>.empty());

    final underTest = GetOffersUseCase(propertiesRepository);
    underTest().listen(expectAsync1((result) {
      expect(result, success);
    }));
    subject.add(success);
  });

  test("GetOffersUseCase returns failure without any change", () async {
    final subject = PublishSubject<Result<List<PropertyModel>>>();
    when(propertiesRepository.getPropertiesList()).thenAnswer((realInvocation) => subject.stream);
    final failure = Result<List<PropertyModel>>.failure(const FormatException());

    final underTest = GetOffersUseCase(propertiesRepository);
    underTest().listen(expectAsync1((result) {
      expect(result, failure);
    }));
    subject.add(failure);
  });

  test("GetOffersUseCase throws if repository throws", () async {
    when(propertiesRepository.getPropertiesList()).thenThrow(const FormatException());
    final underTest = GetOffersUseCase(propertiesRepository);
    expectThrow(() => underTest(), FormatException);
  });
}
