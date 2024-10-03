import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<TransactionsModel> txn = [
    TransactionsModel(
      amount: 31232,
      label: 'Booked',
      transactionID: '2174385463526754',
      transactionsType: TransactionsType.success,
      failedReason: 'fail for some reason',
    ),
    TransactionsModel(
      amount: 31232,
      label: 'Failed',
      transactionID: '2174385463526754',
      transactionsType: TransactionsType.fail,
      failedReason: 'fail for some reason',
    ),
    TransactionsModel(
      amount: 31232,
      label: 'Refunded',
      transactionID: '2174385463526754',
      transactionsType: TransactionsType.refund,
      failedReason: 'fail for some reason',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        onback: context.pop,
        pageName: "Transaction",
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: txn.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TransactionCard(txn: txn[index]),
            );
          }
          return TransactionCard(txn: txn[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return 16.spaceH;
        },
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final TransactionsModel txn;
  const TransactionCard({super.key, required this.txn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: AppColors.kWhite,
        shape: SmoothRectangleBorder(
          borderRadius: 22.smoothBorderRadius,
          side: const BorderSide(
            color: Color(0xffE0E8F2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: ShapeDecoration(
              color: AppColors.blueColor.withOpacity(.3),
              shape: SmoothRectangleBorder(
                borderRadius: 12.smoothBorderRadius,
                side: const BorderSide(
                  color: Color(0xffE0E8F2),
                ),
              ),
            ),
            child: icon,
          ),
          10.spaceW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.label,
                  style: context.textTheme.headlineSmall,
                ),
                // 3.spaceH,
                // Text(
                //   txn.description ?? '-',
                //   style: context.textTheme.titleMedium,
                // ),
                5.spaceH,
                Text(
                  'Transaction ID',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Color(0xff26273A).withOpacity(.4),
                  ),
                ),
                3.spaceH,
                Text(
                  txn.transactionID,
                  style: context.textTheme.titleSmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$ ${txn.amount}",
                style: context.textTheme.headlineSmall,
              ),
              5.spaceH,
              DecoratedBox(
                decoration: BoxDecoration(
                  color: txn.transactionsType.color.withOpacity(.3),
                  borderRadius: 4.borderRadius,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    txn.transactionsType.name ?? '-',
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: txn.transactionsType.color,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              5.spaceH,
              Text(
                DateFormat('dd MMM yyyy\nhh:mm a').format(txn.txnDateTime),
                textAlign: TextAlign.end,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget get icon => switch (txn.transactionsType) {
        TransactionsType.success => Icon(
            Icons.arrow_outward_rounded,
            // color: txn.transactionsType.color,
          ),
        TransactionsType.fail => Icon(
            Icons.cancel,
            // color: txn.transactionsType.color,
          ),
        TransactionsType.refund => Transform.rotate(
            angle: -1,
            child: Icon(
              Icons.arrow_back,
              // color: txn.transactionsType.color,
            ),
          ),
      };
}
