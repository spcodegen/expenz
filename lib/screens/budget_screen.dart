import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_expenz/constants/colors.dart';
import 'package:my_expenz/constants/constants.dart';
import 'package:my_expenz/models/expens_model.dart';
import 'package:my_expenz/models/income_model.dart';
import 'package:my_expenz/widgets/category_card.dart';
import 'package:my_expenz/widgets/pie_chart.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenceCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  const BudgetScreen({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  //method to find the category color from the category
  Color getCategoryColor(dynamic category) {
    if (category is ExpenceCategory) {
      return expenseCategoriesColors[category]!;
    } else {
      return incomeCategoryColor[category]!;
    }
  }

  int _selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    final data = _selectedOption == 0
        ? widget.expenseCategoryTotals
        : widget.incomeCategoryTotals;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Financial Report",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultpadding,
                vertical: kDefaultpadding / 2,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: kBlack.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: _selectedOption == 0 ? kRed : kWhite,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 55,
                          ),
                          child: Text(
                            "Expense",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _selectedOption == 0 ? kWhite : kBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: _selectedOption == 1 ? kGreen : kWhite,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 55,
                          ),
                          child: Text(
                            "Income",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _selectedOption == 1 ? kWhite : kBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //pie chart
            Chart(
              expenseCategoryTotals: widget.expenseCategoryTotals,
              incomeCategoryTotals: widget.incomeCategoryTotals,
              isExpense: _selectedOption == 0,
            ),
            const SizedBox(
              height: 20,
            ),

            //list of categories
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final category = data.keys.toList()[index];
                  final total = data.values.toList()[index];
                  return CategoryCard(
                    title: category.name,
                    amount: total,
                    total:
                        data.values.reduce((value, element) => value + element),
                    progressColor: getCategoryColor(category),
                    isExpense: _selectedOption == 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
