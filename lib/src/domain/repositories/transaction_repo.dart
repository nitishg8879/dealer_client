import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';

abstract class TransactionRepo {
  Future<DataState<List<TransactionsModel>>> fetchTransactions();
  Future<DataState<String?>> createTransaction(TransactionsModel txn);
}
