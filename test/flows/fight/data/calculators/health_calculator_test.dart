import 'package:alpaka_clicker/flows/fight/data/calculators/health_calculator.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("HealthCalculator accepts current health and returns HealthModel", () {
    const currentHealth = 123;
    const fullHealth = 60 * 21 + 37;
    final underTest = HealthCalculator();
    final returned = underTest.calculateHealth(damageTaken: currentHealth, fullHealth: fullHealth);
    // ignore: unnecessary_type_check
    assert(returned is HealthModel);
  });

  test("HealthCalculator returns model with percentage that is fullHealth minus damageTaken divided by fullHealth", () {
    const damageTaken = 123;
    const fullHealth = 60 * 21 + 37;
    const expectedPercentage = (fullHealth - damageTaken)/fullHealth;
    final underTest = HealthCalculator();
    final returned = underTest.calculateHealth(damageTaken: damageTaken, fullHealth: fullHealth);
    expect(returned.healthPercentage, expectedPercentage);
  });

  test("HealthCalculator returns model with displayable health as hour", () {
    const currentHealth = 123;
    const fullHealth = 60 * 21 + 37;
    final underTest = HealthCalculator();
    final returned = underTest.calculateHealth(damageTaken: currentHealth, fullHealth: fullHealth);
    expect(returned.displayableHealth, "2:03");
  });
}
