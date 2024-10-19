import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/transaction_data_source.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/transaction_repo.dart';

class TransactionRepoImpl implements TransactionRepo {
  final TransactionDataSource _transactionDataSource;
  TransactionRepoImpl(this._transactionDataSource);
  @override
  Future<DataState<List<TransactionsModel>>> fetchTransactions() async {
    final state = await _transactionDataSource.fetchTransactions();
    if (state is DataSuccess) {
      return state;
    } else {
      return state as DataFailed<List<TransactionsModel>>;
    }
  }

  @override
  Future<DataState<String?>> createTransaction(TransactionsModel txn) async {
    return _transactionDataSource.createTransaction(txn);
  }
}
