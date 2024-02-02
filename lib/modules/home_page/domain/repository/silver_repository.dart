import '../entities/silver.dart';

abstract class SilverRepository {
  Future<List<Silver>> getSilverPrices();
}
