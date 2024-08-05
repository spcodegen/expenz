import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_expenz/models/expens_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpnseService {
  //Define the key for storing expenses in shared preferences
  static const String _expenseKey = 'expenses';

  //***Save the expense to shared preferences
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //Convert the existing expenses to a list of Expenses objects
      List<Expense> existingExpenseObjects = [];

      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      //Add the new expense to the list
      existingExpenseObjects.add(expense);

      //Convert the list of expense object back to a list of strings
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      //Save the updated list of expenses to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense added successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      //show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on Adding Expense!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //***Load the expenses from shared preferences
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(_expenseKey);

    //Convert the existing expenses to a list of Expense objects
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedExpenses;
  }

  //***Delete the expense from shared preferences from the id
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingExpenses = pref.getStringList(_expenseKey);

      //Convert the existing expenses to a list of Expense objects
      List<Expense> exsistingExpenseObjects = [];

      if (existingExpenses != null) {
        exsistingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      //Remove the expense with the specified id from the list
      exsistingExpenseObjects.removeWhere((expens) => expens.id == id);

      //Covert the list of Expense object back to a list of strings
      List<String> updatedExpenses =
          exsistingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      //Save the updated list of expenses to shared preferences
      await pref.setStringList(_expenseKey, updatedExpenses);

      //show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense delete Successfully!"),
          ),
        );
      }
    } catch (error) {
      print(error.toString());
      //show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error Deleting Expense!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //delete all expense from shared preferences
  Future<void> deleteAllExpenses(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_expenseKey);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("All Expenses Deleted!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error Deleting Expenses!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
