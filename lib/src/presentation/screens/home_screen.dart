import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/config/themes/app_theme.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/category_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/widgets/category_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final category = <CategoryModel>[
    CategoryModel(
      name: "Sports Bike",
      url:
          "https://s3-alpha-sig.figma.com/img/4d3b/a655/0ff0c971c0313662e6934e300f33aa3b?Expires=1726444800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=dPTqtYnCGeRBeIgyM8jBpwwacH8ioCyjciSxlB85LqxLpDkNKnRFpkA9iIAl1B0txCpJI9~xKTC1J5uSs~csSucWm5KjA9x4Ms53ytNr4OoFKSRJ7OZPhxIh8xZek2oW2nJAgjVAhuGYJflkXesyK9NYjfkIK4UdBNIEZDeykNjPo~~DGkIpzStTmhxIey7xpAH62Jq5ioUytdqIPwt6a1Dc70je9kstfcrySJuRibq1GfNtEoGCPiY0Vv~0jwQzvKRZRp23tbNhRwwh3I05P1Nq1sOw0F09LBdKa1U5aYVg1cilloRO8LILRziB1mdg9btt7zytz1cuDT1I3GBxwg__",
    ),
    CategoryModel(
      name: "Scooter",
      url:
          "https://s3-alpha-sig.figma.com/img/716a/8167/e312326673548fb33982359e61d5ec4e?Expires=1726444800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=h5545GD8~iNBWWWeog7tjKb6DM4CHCq~bE95FX4Y32066t9g8MOWNtlocrjwIiTEXE1sfQPHhZITk1GF-xaXaHaeLr8TLHLes5iT1T9BTsINSB~0pIrdqULHs2Kzl8JEQYSlDnWTLjXiDdN7cPVyNxWTPaoXh3s2~wqL--GXhB9LLLVg0apd9gfuyRV3E1PZPZKpx6dyjqWJoLsL7w8PNOPm5EdyfQ5o9mNPEDpoK~Hguk3HLICIAMOYtHcEsmYVV3rNHXptr9hDNkNc1r0ip5f7lPclxFW3IkSl8dZLSx5xXQDJX3lgxZGFnK7nZaI8mVn-MCEbVMA~3n7CczjYvA__",
    ),
    CategoryModel(
      name: "Cruiser",
      url:
          "https://s3-alpha-sig.figma.com/img/1673/2fdc/036350d7e963fff0950fd5bfa6ca4471?Expires=1726444800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qKhNn2D8wm1Q4EGwWFijTyLOJXSSr5Cr~JHwC6JHxmfmMwdsoKFw0r8hS4rSyMNzOhYnwBQe3QObhOXvjoTcsIjh-F4In-IBk3TJ48iu0MX7kSZEAKReGUMb-22JG-SHsoQjmRMEkxLRDucCpMLWqgblYu1Ti-DCwsbhMybInkMSUNyNpWF45C5~QRBKatnt~JAIOzrvV6fVPv7F9~lhIhK2840kjxHgy9Edn3-nYftwTAUKBlkYTQITmHzs74UoFMdS8-LRn6nlbFSIkNbOUZatXnrjL0L6Bdw9NnJJdjlngxTfTSHY~gpevAmzkYShc3IscPwWkGQs3qS8QuOZGw__",
    ),
    CategoryModel(
      name: "Cruiser",
      url:
          "https://s3-alpha-sig.figma.com/img/1673/2fdc/036350d7e963fff0950fd5bfa6ca4471?Expires=1726444800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qKhNn2D8wm1Q4EGwWFijTyLOJXSSr5Cr~JHwC6JHxmfmMwdsoKFw0r8hS4rSyMNzOhYnwBQe3QObhOXvjoTcsIjh-F4In-IBk3TJ48iu0MX7kSZEAKReGUMb-22JG-SHsoQjmRMEkxLRDucCpMLWqgblYu1Ti-DCwsbhMybInkMSUNyNpWF45C5~QRBKatnt~JAIOzrvV6fVPv7F9~lhIhK2840kjxHgy9Edn3-nYftwTAUKBlkYTQITmHzs74UoFMdS8-LRn6nlbFSIkNbOUZatXnrjL0L6Bdw9NnJJdjlngxTfTSHY~gpevAmzkYShc3IscPwWkGQs3qS8QuOZGw__",
    ),
    CategoryModel(
      name: "Cruiser",
      url:
          "https://s3-alpha-sig.figma.com/img/1673/2fdc/036350d7e963fff0950fd5bfa6ca4471?Expires=1726444800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qKhNn2D8wm1Q4EGwWFijTyLOJXSSr5Cr~JHwC6JHxmfmMwdsoKFw0r8hS4rSyMNzOhYnwBQe3QObhOXvjoTcsIjh-F4In-IBk3TJ48iu0MX7kSZEAKReGUMb-22JG-SHsoQjmRMEkxLRDucCpMLWqgblYu1Ti-DCwsbhMybInkMSUNyNpWF45C5~QRBKatnt~JAIOzrvV6fVPv7F9~lhIhK2840kjxHgy9Edn3-nYftwTAUKBlkYTQITmHzs74UoFMdS8-LRn6nlbFSIkNbOUZatXnrjL0L6Bdw9NnJJdjlngxTfTSHY~gpevAmzkYShc3IscPwWkGQs3qS8QuOZGw__",
    ),
  ];
  // final homeBloc = HomeCubit(ProductFetchUsecases(getIt()));
  final scroController = ScrollController();
  final products = <ProductModel>[
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      // getIt<HomeCubit>().getAllPost();
    });
  }

  String dummyImage = "https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          controller: scroController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            12.spaceH,
            Row(
              children: [
                Ink(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: 50.borderRadius,
                    boxShadow: AppTheme.boxShadows,
                  ),
                  child: ClipRRect(
                    borderRadius: 50.borderRadius,
                    child: Image.network(
                      dummyImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Spacer(),
                Ink(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: 50.borderRadius,
                    border: Border.all(
                      color: AppColors.kborderColor,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CustomSvgIcon(
                      assetName: AppAssets.notification,
                      color: AppColors.kBlack900,
                    ),
                  ),
                ),
                16.spaceW,
                Ink(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: 50.borderRadius,
                    border: Border.all(
                      color: AppColors.kborderColor,
                    ),
                    // boxShadow: AppTheme.boxShadows,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CustomSvgIcon(
                      assetName: AppAssets.search,
                      color: AppColors.kBlack900,
                    ),
                  ),
                ),
              ],
            ),
            16.spaceH,
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  10,
                  (index) => Container(
                    height: 200,
                    width: context.width - 64,
                    decoration: BoxDecoration(
                      boxShadow: AppTheme.boxShadows,
                    ),
                    margin: const EdgeInsets.only(right: 16, bottom: 2),
                    child: ClipRRect(
                      borderRadius: 16.borderRadius,
                      child: Image.network(
                        dummyImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            16.spaceH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category",
                  style: context.textTheme.labelLarge,
                ),
                Row(
                  children: [
                    Text(
                      "View All",
                      style: context.textTheme.displaySmall?.copyWith(
                        color: AppColors.kFoundatiionPurple800,
                      ),
                    ),
                    4.spaceW,
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.kFoundatiionPurple800,
                    )
                  ],
                )
              ],
            ),
            8.spaceH,
            SizedBox(
              height: 100,
              child: ListView.separated(
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CategoryView(
                      category: category[index],
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) {
                  return 16.spaceW;
                },
              ),
            ),
            16.spaceH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most Popular",
                  style: context.textTheme.labelLarge,
                ),
                Row(
                  children: [
                    Text(
                      "View All",
                      style: context.textTheme.displaySmall?.copyWith(
                        color: AppColors.kFoundatiionPurple800,
                      ),
                    ),
                    4.spaceW,
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.kFoundatiionPurple800,
                    )
                  ],
                ),
              ],
            ),
            8.spaceH,
            SizedBox(
              height: context.height,
              child: ListView.separated(
                controller: scroController,
                itemBuilder: (context, index) {
                  return ProductView(product: products[index]);
                },
                separatorBuilder: (context, index) {
                  return 10.spaceH;
                },
                itemCount: products.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
