import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'alternating_controller.g.dart';

@injectable
class AlternatingController = _AlternatingControllerBase with _$AlternatingController;

abstract class _AlternatingControllerBase with Store {

  bool _alternating = true;

  @observable
  CurrentAlternatingWidget currentVisible = CurrentAlternatingWidget.first;

  @action
  void initialize() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 5));
      currentVisible = CurrentAlternatingWidget.values[(currentVisible.index + 1) % CurrentAlternatingWidget.values.length];
      return _alternating;
    });
  }

  @action
  void dispose() {
    _alternating = false;
  }

}

enum CurrentAlternatingWidget {
  first, second
}
