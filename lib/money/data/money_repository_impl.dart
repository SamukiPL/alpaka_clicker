import 'package:alpaka_clicker/money/bank.dart';
import 'package:alpaka_clicker/money/currency_beautifier.dart';
import 'package:alpaka_clicker/money/domain/money_repository.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: MoneyRepository)
class MoneyRepositoryImpl implements MoneyRepository {
  final Bank _bank;
  final CurrencyBeautifier _beautifier;

  MoneyRepositoryImpl(this._bank, this._beautifier);

  final PublishSubject<void> _displaySubject = PublishSubject();

  @override
  Future<void> payInterest() async {
    _displaySubject.add(_bank.payInterest());
  }

  @override
  Future<void> paySalary() async {
    _displaySubject.add(_bank.paySalary());
  }

  @override
  Stream<Result<String>> getDisplayableMoney() {
    return _displaySubject.throttleTime(const Duration(milliseconds: 16), leading: false, trailing: true).map((_) {
      try {
        return Success(_beautifier.beautifyCurrency(_bank.getMoney()));
      } on Exception catch (e) {
        return Failure<String>(e);
      }
    }).cast();
  }
}
