import '../entities/gold.dart';

abstract class GoldRepository {
  Future<List<Gold>> getGoldPrices();
}
