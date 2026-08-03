import 'package:flutter/material.dart';
import '../models/shopping_item_model.dart';

class ShoppingHomeScreen extends StatefulWidget {
  const ShoppingHomeScreen({super.key});

  @override
  State<ShoppingHomeScreen> createState() => _ShoppingHomeScreenState();
}

class _ShoppingHomeScreenState extends State<ShoppingHomeScreen> {
  final List<ShoppingItemModel> _items = [
    ShoppingItemModel(id: '1', name: 'شیر', category: 'خواردەمەنی'),
    ShoppingItemModel(id: '2', name: 'سێوی سور', category: 'سەوزە و میوە'),
    ShoppingItemModel(id: '3', name: 'سابوون', category: 'پاککەرەوە'),
    ShoppingItemModel(
      id: '4',
      name: 'نان',
      category: 'خواردەمەنی',
      isBought: true,
    ),
  ];

  final TextEditingController _nameController = TextEditingController();
  String _selectedCategory = 'خواردەمەنی';

  void _toggleBought(ShoppingItemModel item) {
    setState(() {
      item.isBought = !item.isBought;
    });
  }

  void _addItem() {
    if (_nameController.text.trim().isEmpty) return;

    setState(() {
      _items.add(
        ShoppingItemModel(
          id: DateTime.now().toString(),
          name: _nameController.text.trim(),
          category: _selectedCategory,
        ),
      );
      _nameController.clear();
    });
    Navigator.pop(context);
  }

  void _deleteItem(String id) {
    setState(() {
      _items.removeWhere((item) => item.id == id);
    });
  }

  void _showAddItemDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'زیادکردنی کاڵای نوێ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'ناوی کاڵاکە بنووسە...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF0F172A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['خواردەمەنی', 'سەوزە و میوە', 'پاککەرەوە'].map((
                  cat,
                ) {
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF10B981),
                    backgroundColor: const Color(0xFF0F172A),
                    onSelected: (selected) {
                      if (selected) {
                        setModalState(() {
                          _selectedCategory = cat;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _addItem,
                child: const Text(
                  'زیادکردن بۆ لیست',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int remainingItems = _items.where((i) => !i.isBought).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'لیستی کڕینی بازاڕ 🛒',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'کاڵا نەبووەکان (ماوەتەوە):',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$remainingItems کاڵا',
                    style: const TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _items.isEmpty
                ? const Center(
                    child: Text(
                      'لیستەکە بەتاڵە!',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: item.isBought,
                            activeColor: const Color(0xFF10B981),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onChanged: (_) => _toggleBought(item),
                          ),
                          title: Text(
                            item.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              decoration: item.isBought
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          subtitle: Text(
                            item.category,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _deleteItem(item.id),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF10B981),
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
