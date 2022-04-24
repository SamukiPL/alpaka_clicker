import 'dart:async';

import 'package:alpaka_clicker/clicker_base/buying/domain/buy_property_use_case.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/get_displayable_interest_per_second_use_case.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/get_offers_use_case.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'property_shop_controller.g.dart';

@injectable
class PropertyShopController = PropertyShopControllerBase with _$PropertyShopController;

abstract class PropertyShopControllerBase with Store {
  final GetOffersUseCase _offersUseCase;
  final BuyPropertyUseCase _buyPropertyUseCase;
  final GetDisplayableInterestPerSecondUseCase _interestPerSecondUseCase;

  late final StreamSubscription _offersSubscription;

  PropertyShopControllerBase(this._offersUseCase, this._buyPropertyUseCase, this._interestPerSecondUseCase);

  @observable
  List<PropertyModel> models = List.empty();

  @observable
  String interestPerSecond = "0,0/s";

  Future<void> initializeController() async {
    _offersSubscription = _offersUseCase().listen((event) {
      event.onSuccess((value) => models = value);
      updateInterestPerSecond();
    });
  }

  Future<void> updateInterestPerSecond() async {
    (await _interestPerSecondUseCase()).onSuccess((value) => interestPerSecond = value);
  }

  Future<void> buyProperty(PropertyOffer offer) async {
    //TODO handle success and error for better UX
    await _buyPropertyUseCase(offer);
  }

  Future<void> dispose() async {
    _offersSubscription.cancel();
  }
}
