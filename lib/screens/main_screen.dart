import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_expenz/constants/colors.dart';
import 'package:my_expenz/models/expens_model.dart';
import 'package:my_expenz/models/income_model.dart';
import 'package:my_expenz/screens/add_new_screen.dart';
import 'package:my_expenz/screens/budget_screen.dart';
import 'package:my_expenz/screens/home_screen.dart';
import 'package:my_expenz/screens/profile_screen.dart';
import 'package:my_expenz/screens/transactions_screen.dart';
import 'package:my_expenz/services/expnse_service.dart';
import 'package:my_expenz/services/income_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current page index
  int _currentPageIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  //Function to fetch all Incomes

  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
    });
  }

  //Function to fetch expenses
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpnseService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  //Function to add a new expense
  void addNewExpense(Expense newExpense) {
    ExpnseService().saveExpenses(newExpense, context);

    //Update the list of expenses
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // function to add new income
  void addNewIncome(Income newIncome) {
    IncomeService().saveIncome(newIncome, context);

    //update the income list
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
  }

  //function to remove a expense
  void removeExpense(Expense expense) {
    ExpnseService().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  //function to remove an income
  void removeIncome(Income income) {
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  @override
  Widget build(BuildContext context) {
//screens list
    final List<Widget> pages = [
      HomeScreen(
        expenseList: expenseList,
        incomeList: incomeList,
      ),
      TransactionScreen(
        expensesList: expenseList,
        incomesList: incomeList,
        onDismissedExpense: removeExpense,
        onDismissedIncome: removeIncome,
      ),
      AddNewScreen(
        addExpense: addNewExpense,
        addIncome: addNewIncome,
      ),
      BudgetScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            print(_currentPageIndex);
          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: [
          const BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          const BottomNavigationBarItem(
            label: "Transactions",
            icon: Icon(Icons.list_rounded),
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: kWhite,
                size: 30,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            label: "Budget",
            icon: Icon(Icons.rocket),
          ),
          const BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
