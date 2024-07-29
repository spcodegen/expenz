import 'package:flutter/material.dart';
import 'package:my_expenz/constants/colors.dart';
import 'package:my_expenz/constants/constants.dart';
import 'package:my_expenz/services/user_services.dart';
import 'package:my_expenz/widgets/income_expence_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//for store the username
  String username = "";

  @override
  void initState() {
    //get the user name form the shared pref
    UserServices.getUserData().then(
      (value) {
        if (value["username"] != null) {
          setState(() {
            username = value['username']!;
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //main col
          child: Column(
            children: [
              //bg color col
              Container(
                height: MediaQuery.of(context).size.height * 0.37,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.15),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultpadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kMainColor,
                              border: Border.all(
                                color: kMainColor,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Welcome $username",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              size: 30,
                              color: kMainColor,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenceCard(
                            title: "Income",
                            amount: 5000,
                            bgColor: kGreen,
                            imageUrl: "assets/images/income.png",
                          ),
                          IncomeExpenceCard(
                            title: "Expenses",
                            amount: 1200,
                            bgColor: kRed,
                            imageUrl: "assets/images/expense.png",
                          ),
                        ],
                      ),
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
