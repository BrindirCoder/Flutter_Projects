import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../widgets/balance_card.dart';

class ExpenseHomeScreen extends StatefulWidget {
  const ExpenseHomeScreen({super.key});

  @override
  State<ExpenseHomeScreen> createState() => _ExpenseHomeScreenState();
}

class _ExpenseHomeScreenState extends State<ExpenseHomeScreen> {
  // داتای بنەڕەتی بۆ تاقیکردنەوە
  final List<ExpenseModel> _transactions = [
    ExpenseModel(
      id: '1',
      title: 'کڕینی میوە و سەوزە',
      amount: 45.0,
      date: DateTime.now(),
      icon: Icons.shopping_bag_outlined,
      type: ExpenseType.expense,
    ),
    ExpenseModel(
      id: '2',
      title: 'مووچە',
      amount: 500.0,
      date: DateTime.now(),
      icon: Icons.attach_money_rounded,
      type: ExpenseType.income,
    ),
    ExpenseModel(
      id: '3',
      title: 'خواردنەوەی قاوە',
      amount: 5.5,
      date: DateTime.now(),
      icon: Icons.local_cafe_outlined,
      type: ExpenseType.expense,
    ),
  ];

  // هەژمارکردنی داھات و خەرجییەکان بە شێوەی داینامیکی
  double get _totalIncome => _transactions
      .where((item) => item.type == ExpenseType.income)
      .fold(0.0, (sum, item) => sum + item.amount);

  double get _totalExpenses => _transactions
      .where((item) => item.type == ExpenseType.expense)
      .fold(0.0, (sum, item) => sum + item.amount);

  double get _totalBalance => _totalIncome - _totalExpenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'بەڕێوەبەری دارایی',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            BalanceCard(
              totalBalance: _totalBalance,
              income: _totalIncome,
              expenses: _totalExpenses,
            ),
            const SizedBox(height: 24),
            const Text(
              'دواین مامەڵەکان',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final item = _transactions[index];
                  final isIncome = item.type == ExpenseType.income;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF334155),
                        child: Icon(item.icon, color: Colors.white),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        '${item.date.day}/${item.date.month}/${item.date.year}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        '${isIncome ? '+' : '-'}\$${item.amount}',
                        style: TextStyle(
                          color: isIncome
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
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
