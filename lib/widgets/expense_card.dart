import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenz/constants/colors.dart';
import 'package:my_expenz/models/expens_model.dart';

class ExpenseCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final double amount;
  final ExpenceCategory category;
  final String description;
  final DateTime time;

  const ExpenseCard({
    super.key,
    required this.title,
    required this.time,
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: expenseCategoriesColors[category]?.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                expenseCategoriesImages[category]!,
                width: 15,
                height: 15,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack.withOpacity(0.8),
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: kGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "-\$${amount.toStringAsFixed(2)} ",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kRed,
                ),
              ),
              Text(
                DateFormat.jm().format(date),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: kGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
