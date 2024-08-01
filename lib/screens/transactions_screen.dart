import 'package:flutter/material.dart';
import 'package:my_expenz/constants/colors.dart';
import 'package:my_expenz/constants/constants.dart';
import 'package:my_expenz/models/expens_model.dart';
import 'package:my_expenz/widgets/expense_card.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final void Function(Expense) onDismissedExpense;
  const TransactionScreen({
    super.key,
    required this.expensesList,
    required this.onDismissedExpense,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "See your financial report",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kMainColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //show all the expenses
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.expensesList.length,
                        itemBuilder: (context, index) {
                          final expense = widget.expensesList[index];

                          return Dismissible(
                            key: ValueKey(expense),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDismissedExpense(expense);
                              });
                            },
                            child: ExpenseCard(
                              title: expense.title,
                              time: expense.time,
                              amount: expense.amount,
                              category: expense.category,
                              date: expense.date,
                              description: expense.description,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
