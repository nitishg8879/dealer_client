import 'dart:convert';

import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/model/payment_verify_model.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionDataSource {
  Future<DataState<bool>> createTransaction(TransactionsModel txn) async {
    if (!getIt.get<AppLocalService>().isLoggedIn || getIt.get<AppLocalService>().currentUser?.id == null) {
      return const DataFailed(false, 400, "User is not logged in.");
    }
    try {
      await getIt.get<AppFireBaseLoc>().transactions.add(txn.toJson()).catchError((error) => throw error);
      return const DataFailed(true, 200, "Transaction Added");
    } catch (e) {
      return DataFailed(false, 400, e.toString());
    }
  }

  Future<DataState<PaymentVerifyModel?>> verifyPayment({required String paymentId}) async {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('${getIt.get<AppFireBaseLoc>().razorKey}:${getIt.get<AppFireBaseLoc>().razorValue}'))}';
    try {
      final resp = await http.get(
        Uri.parse("https://api.razorpay.com/v1/payments/$paymentId"),
        headers: <String, String>{
          'Authorization': basicAuth,
        },
      ).catchError((error) => throw error);
      if (resp.statusCode == 200) {
        return DataSuccess(PaymentVerifyModel.fromJson(jsonDecode(resp.body)));
      } else {
        return DataFailed(null, 500, resp.body);
      }
    } catch (e) {
      return DataFailed(null, 500, e.toString());
    }
  }

  Future<DataState<List<TransactionsModel>>> fetchTransactions() async {
    if (!getIt.get<AppLocalService>().isLoggedIn || getIt.get<AppLocalService>().currentUser?.id == null) {
      return const DataFailed(<TransactionsModel>[], 400, "User is not logged in.");
    }
    try {
      final resp = await getIt
          .get<AppFireBaseLoc>()
          .transactions
          .where(
            'userId',
            isEqualTo: getIt.get<AppLocalService>().currentUser!.id,
          )
          .orderBy(
            'txnDateTime',
            descending: true,
          )
          .get()
          .catchError((error) {
        throw error;
      });
      return DataSuccess(resp.docs.map((e) => TransactionsModel.fromJson(e.data())).toList());
    } catch (e) {
      return DataFailed(<TransactionsModel>[], 400, e.toString());
    }
  }
}
