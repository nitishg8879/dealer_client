import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/transaction_repo.dart';

class TransactionFetchUseCase {
  TransactionRepo _transactionRepo;
  TransactionFetchUseCase(this._transactionRepo);

  Future<DataState<List<TransactionsModel>>> call() async {
    return _transactionRepo.fetchTransactions();
  }
}

class TransactionCreateUseCase {
  TransactionRepo _transactionRepo;
  TransactionCreateUseCase(this._transactionRepo);

  Future<DataState<bool>> call({TransactionsModel? txn}) async {
    if (txn == null) {
      throw Exception("Txn can't be empty");
    }
    return _transactionRepo.createTransaction(txn);
  }
}
