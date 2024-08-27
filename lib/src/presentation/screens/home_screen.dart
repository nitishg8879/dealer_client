import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product_fetch_usecases.dart';
import 'package:bike_client_dealer/src/presentation/cubit/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final homeBloc = HomeCubit(ProductFetchUsecases(getIt()));
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      getIt<HomeCubit>().getAllPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return SizedBox();
    return Scaffold(
      body: BlocBuilder(
        bloc: getIt<HomeCubit>(),
        builder: (context, state) {
          return switch (state) {
            HomeLoading _ => const Center(
                child: CircularProgressIndicator(),
              ),
            HomeLoaded _ => _buildProductList(state),
            HomeHasError _ => const Center(
                child: Text('Error happen!!'),
              ),
            _ => const Center(
                child: Text('Something went wrong'),
              )
          };
        },
      ),
    );
  }

  Widget _buildProductList(HomeLoaded state) {
    if (state.products.isEmpty) {
      return const Center(
        child: Text("No Data"),
      );
    } else {
      return ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(state.products[index].name ?? "-"),
            subtitle: Image.network(state.products[index].images!.first),
          );
        },
      );
    }
  }
}
