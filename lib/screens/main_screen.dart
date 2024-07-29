import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_expenz/constants/colors.dart';
import 'package:my_expenz/screens/add_new_screen.dart';
import 'package:my_expenz/screens/budget_screen.dart';
import 'package:my_expenz/screens/home_screen.dart';
import 'package:my_expenz/screens/profile_screen.dart';
import 'package:my_expenz/screens/transactions_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current page index
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
//screens list
    final List<Widget> pages = [
      AddNewScreen(),
      HomeScreen(),
      TransactionScreen(),
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
