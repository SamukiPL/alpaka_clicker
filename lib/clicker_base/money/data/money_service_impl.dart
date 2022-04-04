import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/currency_beautifier.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/money_service.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: MoneyService)
class MoneyServiceImpl implements MoneyService {
  final Bank _bank;
  final CurrencyBeautifier _beautifier;

  MoneyServiceImpl(this._bank, this._beautifier);

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
  Stream<Currency> getDepositedMoney() {
    return _displaySubject
        .throttleTime(const Duration(milliseconds: 16), leading: false, trailing: true)
        .map((_) => _bank.getMoney())
        .cast();
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

  @override
  Future<Result<String>> getDisplayableInterestPerSecond() async {
    try {
      return Success(_beautifier.beautifyCurrencyPerSecond(_bank.getInterest()));
    } on Exception catch (e) {
      return Failure<String>(e);
    }
  }
}
