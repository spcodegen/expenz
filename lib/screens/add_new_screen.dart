import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenz/constants/colors.dart';
import 'package:my_expenz/constants/constants.dart';
import 'package:my_expenz/models/expens_model.dart';
import 'package:my_expenz/models/income_model.dart';
import 'package:my_expenz/services/expnse_service.dart';
import 'package:my_expenz/services/income_service.dart';
import 'package:my_expenz/widgets/custom_button.dart';

class AddNewScreen extends StatefulWidget {
  final Function(Expense) addExpense;
  final Function(Income) addIncome;

  const AddNewScreen({
    super.key,
    required this.addExpense,
    required this.addIncome,
  });

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  int _selectedMethode = 0;
  //state to track the expence or income
  ExpenceCategory _expenceCategory = ExpenceCategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethode == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultpadding,
            ),
            child: Stack(
              children: [
                //expense and income toggle menu
                Padding(
                  padding: const EdgeInsets.all(kDefaultpadding),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethode = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 0 ? kRed : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 55,
                                vertical: 7,
                              ),
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      _selectedMethode == 0 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethode = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 1 ? kGreen : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 55,
                                vertical: 7,
                              ),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      _selectedMethode == 1 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //Amount feild
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultpadding,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How Much?",
                          style: TextStyle(
                            color: kLightGrey.withOpacity(0.8),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextField(
                          style: TextStyle(
                            fontSize: 60,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: kWhite,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //user data form
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3,
                  ),
                  decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultpadding),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          //category selector dropdown
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultpadding,
                                horizontal: 20,
                              ),
                            ),
                            items: _selectedMethode == 0
                                ? ExpenceCategory.values.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList()
                                : IncomeCategory.values.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList(),
                            value: _selectedMethode == 0
                                ? _expenceCategory
                                : _incomeCategory,
                            onChanged: (value) {
                              setState(() {
                                _selectedMethode == 0
                                    ? _expenceCategory =
                                        value as ExpenceCategory
                                    : _incomeCategory = value as IncomeCategory;

                                print(_selectedMethode == 0
                                    ? _expenceCategory.name
                                    : _incomeCategory.name);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          //title field
                          TextFormField(
                            controller: _titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter a Title!";
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultpadding,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          //description field
                          TextFormField(
                            controller: _descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter a Description!";
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultpadding,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          //amount field
                          TextFormField(
                            controller: _amountController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please Enter a amount";
                              }
                              double? amount = double.tryParse(value);
                              if (amount == null || amount <= 0) {
                                return "Please enter a valid amount";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultpadding,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          // Date selector
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2025),
                                  ).then(
                                    (value) {
                                      if (value != null) {
                                        setState(() {
                                          _selectedDate = value;
                                        });
                                      }
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kMainColor,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: kWhite,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select Date",
                                          style: TextStyle(
                                            color: kWhite,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(_selectedDate),
                                style: const TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // time piker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then(
                                    (value) {
                                      if (value != null) {
                                        setState(() {
                                          _selectedTime = DateTime(
                                            _selectedDate.year,
                                            _selectedDate.month,
                                            _selectedDate.day,
                                            value.hour,
                                            value.minute,
                                          );
                                        });
                                      }
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kYellow,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: kWhite,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select Time",
                                          style: TextStyle(
                                            color: kWhite,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(_selectedTime),
                                style: const TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: kLightGrey,
                            thickness: 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //submit button
                          GestureDetector(
                            onTap: () async {
                              //save the expense or the income data into shared pref
                              if (_formkey.currentState!.validate()) {
                                if (_selectedMethode == 0) {
                                  //adding expense
                                  List<Expense> loadedExpenses =
                                      await ExpnseService().loadExpenses();

                                  //create the expense to store
                                  Expense expense = Expense(
                                    id: loadedExpenses.length + 1,
                                    title: _titleController.text,
                                    amount: _amountController.text.isEmpty
                                        ? 0
                                        : double.parse(_amountController.text),
                                    category: _expenceCategory,
                                    date: _selectedDate,
                                    time: _selectedDate,
                                    description: _descriptionController.text,
                                  );

                                  // add expense
                                  widget.addExpense(expense);

                                  //clear the feilds
                                  _titleController.clear();
                                  _amountController.clear();
                                  _descriptionController.clear();
                                } else {
                                  //load incomes
                                  List<Income> loadedIncomes =
                                      await IncomeService().loadIncomes();

                                  //create the new income
                                  Income income = Income(
                                    id: loadedIncomes.length + 1,
                                    title: _titleController.text,
                                    amount: _amountController.text.isEmpty
                                        ? 0
                                        : double.parse(_amountController.text),
                                    category: _incomeCategory,
                                    date: _selectedDate,
                                    time: _selectedTime,
                                    description: _descriptionController.text,
                                  );

                                  //add income
                                  widget.addIncome(income);

                                  //clear the feilds
                                  _titleController.clear();
                                  _amountController.clear();
                                  _descriptionController.clear();
                                }
                              }
                            },
                            child: CustomButton(
                              buttonName: "Add",
                              buttonColor:
                                  _selectedMethode == 0 ? kRed : kGreen,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
