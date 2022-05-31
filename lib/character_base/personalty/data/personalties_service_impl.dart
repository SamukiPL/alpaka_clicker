import 'package:alpaka_clicker/character_base/personalty/domain/personalties_service.dart';
import 'package:alpaka_clicker/character_base/personalty/models/personalty_fight_progress.dart';
import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';
import 'package:rxdart/rxdart.dart';

class PersonaltiesServiceImpl implements PersonaltiesService {
  final List<Personalty> _personalties;

  PersonaltiesServiceImpl(this._personalties);

  late final BehaviorSubject<List<Personalty>> _displaySubject = BehaviorSubject.seeded(_personalties);

  @override
  List<Personalty> get personalties => _personalties.toList();

  @override
  Stream<List<Personalty>> listenToPersonalties() => _displaySubject;

  @override
  Future<void> buyPersonaltyLevel(PersonaltyOffer offer) async {
    _personalties.firstWhere((element) => element.key == offer.key).levelUpExternally();
    _displaySubject.add(_personalties);
  }

  @override
  Future<void> addFightProgress(List<PersonaltyFightProgress> fightProgress) async {
    for (var progress in fightProgress) {
      _personalties.firstWhere((personality) => personality.key == progress.key).addExperience(progress.experience);
    }
  }

}
