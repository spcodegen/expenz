import 'package:flutter/material.dart';

//income category enum
enum IncomeCategory {
  freelance,
  salary,
  passive,
  sales,
}

//category images
final Map<IncomeCategory, String> incomeCategoryImages = {
  IncomeCategory.freelance: "assets/images/freelance.png",
  IncomeCategory.salary: "assets/images/health.png",
  IncomeCategory.passive: "assets/images/car.png",
  IncomeCategory.sales: "assets/images/salary.png",
};

//category colors
final Map<IncomeCategory, Color> incomeCategoryColor = {
  IncomeCategory.freelance: const Color(0xffE57373),
  IncomeCategory.salary: const Color(0xffFFD54F),
  IncomeCategory.passive: const Color(0xff81C784),
  IncomeCategory.sales: const Color(0xff64B5F6),
};

class Income {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });
}
