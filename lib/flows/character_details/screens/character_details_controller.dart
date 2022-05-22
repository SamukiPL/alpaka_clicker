import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'character_details_controller.g.dart';

@injectable
class CharacterDetailsController = _CharacterDetailsControllerBase with _$CharacterDetailsController;

abstract class _CharacterDetailsControllerBase with Store {

}
