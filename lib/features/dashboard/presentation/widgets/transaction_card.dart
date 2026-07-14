import 'package:fintech_dark/common/common.dart';
import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

const Map<TransactionType, String> _typeIcons = {
  TransactionType.eWallet: AppAssets.eWallet,
  TransactionType.onlineShopping: AppAssets.onlineShopping,
  TransactionType.bankingFee: AppAssets.bankFee,
  TransactionType.saving: AppAssets.bankFee,
  TransactionType.transfer: AppAssets.bankFee,
};

class TransactionListItem extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionListItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spaceXS),
      child: Row(
        children: [
          CircularSvgIcon(
            assetName: _typeIcons[transaction.type] ?? AppAssets.bankFee,
            size: 52,
            iconSize: 24,
            borderColor: AppColors.surfaceCard,
          ),
          const SizedBox(width: AppDimens.spaceS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                ),
                Text(
                  Formatters.date(transaction.dateTime),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Text(
            Formatters.signedAmount2(
              transaction.isCredit ? transaction.amount : -transaction.amount,
            ),
            style: transaction.isCredit
                ? AppTextStyles.amountPositive.copyWith(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                : AppTextStyles.amountNegative.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ],
      ),
    );
  }
}

enum TransactionFilter { weekly, monthly, today }

class TransactionHistorySection extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final TransactionFilter selectedFilter;
  final ValueChanged<TransactionFilter> onFilterChanged;
  final VoidCallback onSeeAll;

  const TransactionHistorySection({
    super.key,
    required this.transactions,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.transactionHistory,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: const Text(
                AppStrings.seeAll,
                style: TextStyle(color: AppColors.primaryLight, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spaceS),
        Row(
          children: TransactionFilter.values.map((filter) {
            final selected = filter == selectedFilter;
            return Padding(
              padding: const EdgeInsets.only(right: AppDimens.spaceS),
              child: ChoiceChip(
                label: Text(_filterLabel(filter)),
                selected: selected,
                onSelected: (_) => onFilterChanged(filter),
                showCheckmark: false,

                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),

                labelStyle: AppTextStyles.caption.copyWith(
                  color: selected
                      ? AppColors.textOnPrimary
                      : AppColors.textSecondary,
                ),

                selectedColor: AppColors.surfaceCard,
                backgroundColor: AppColors.surfaceElevated,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),

                side: BorderSide(
                  color: selected ? AppColors.primary : Colors.transparent,
                  width: selected ? 1.5 : 0,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppDimens.spaceS),
        if (transactions.isEmpty)
          const DashboardEmptyView(
            title: 'No transactions yet',
            subtitle: 'Your activity will show up here.',
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) => TransactionListItem(
              key: ValueKey(transactions[index].id),
              transaction: transactions[index],
            ),
            separatorBuilder: (context, index) =>
                const Divider(color: AppColors.divider, height: 1),
          ),
      ],
    );
  }

  String _filterLabel(TransactionFilter filter) {
    switch (filter) {
      case TransactionFilter.weekly:
        return 'Weekly';
      case TransactionFilter.monthly:
        return 'Monthly';
      case TransactionFilter.today:
        return 'Today';
    }
  }
}
