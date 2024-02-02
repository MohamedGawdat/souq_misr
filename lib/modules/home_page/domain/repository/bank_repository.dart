import '../entities/bank.dart';

abstract class BankRepository {
  Future<List<Bank>> getBanks();
}
