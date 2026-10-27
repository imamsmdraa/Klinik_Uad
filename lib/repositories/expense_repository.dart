/// Model data transaksi / pengeluaran operasional (baseline template M01).
class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    String? category,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }
}

/// Antarmuka abstraksi data (Repository Pattern) sesuai ketentuan M01.
abstract class ExpenseRepository {
  Future<List<Expense>> getExpenses();
  Future<void> addExpense(Expense expense);
  Future<void> deleteExpense(String id);
}

/// Implementasi in-memory repository untuk fase M01 (data di memori HP).
class InMemoryExpenseRepository implements ExpenseRepository {
  final List<Expense> _expenses = [];

  InMemoryExpenseRepository() {
    _seedData();
  }

  void _seedData() {
    _expenses.addAll([
      Expense(
        id: 'exp-1',
        title: 'Pengadaan Obat Paracetamol',
        amount: 250000,
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Farmasi',
      ),
      Expense(
        id: 'exp-2',
        title: 'Alat Kesehatan & Masker Medis',
        amount: 120000,
        date: DateTime.now(),
        category: 'Perlengkapan',
      ),
    ]);
  }

  @override
  Future<List<Expense>> getExpenses() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return List.unmodifiable(_expenses);
  }

  @override
  Future<void> addExpense(Expense expense) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _expenses.add(expense);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _expenses.removeWhere((item) => item.id == id);
  }
}
