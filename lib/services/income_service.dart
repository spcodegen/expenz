import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_expenz/models/income_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //Define the key for storing incomes in shared preferences
  static const String _incomeKey = 'income';

  //***Save the income to shared preferences
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //Covert the existing incomes to a list of Income objects
      List<Income> existingIncomeObjects = [];

      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      //Add the new income to the list
      existingIncomeObjects.add(income);

      //Convert the list of income objects back to a list of strings
      List<String> updatedIncome =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      //Save the updated list of incomes to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncome);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Income added Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on Adding Income!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //***load the income from shared prefrences
  Future<List<Income>> loadIncomes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingIncomes = pref.getStringList(_incomeKey);

    //Convert the existing incomes to a list of income object
    List<Income> loadedIncomes = [];

    if (existingIncomes != null) {
      loadedIncomes =
          existingIncomes.map((e) => Income.fromJSON(json.decode(e))).toList();
    }

    return loadedIncomes;
  }
}
