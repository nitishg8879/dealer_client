import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/domain/repositories/product_repo.dart';

class CompanyFetchUsecase {
  ProductRepo _productRepo;
  CompanyFetchUsecase(this._productRepo);

  Future<DataState<List<CompanyModel>?>> call() async {
    return _productRepo.fetchCompany();
  }
}