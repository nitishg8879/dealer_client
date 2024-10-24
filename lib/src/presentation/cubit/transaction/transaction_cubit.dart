import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/transaction_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionFetchUseCase _transactionFetchUseCase;
  TransactionCubit(this._transactionFetchUseCase) : super(TransactionLoading());


  @override
  void emit(TransactionState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> fetchData() async {
    emit(TransactionLoading());
    final resp = await _transactionFetchUseCase.call();
    if (resp is DataSuccess) {
      emit(TransactionLoaded(resp.data));
    }

    if (resp is DataFailed) {
      emit(TransactionError(resp.message ?? "Something went wonrg."));
    }
  }
}
