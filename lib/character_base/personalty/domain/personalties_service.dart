import 'package:alpaka_clicker/character_base/personalty/models/personalty_fight_progress.dart';
import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';

abstract class PersonaltiesService {
  List<Personalty> get personalties;
  Stream<List<Personalty>> listenToPersonalties();
  Future<void> buyPersonaltyLevel(PersonaltyOffer offer);
  Future<void> addFightProgress(List<PersonaltyFightProgress> progress);
}
