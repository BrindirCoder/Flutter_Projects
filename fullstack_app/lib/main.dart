import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fullstack App',
          themeMode: currentMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
            scaffoldBackgroundColor: const Color(0xFFF1F5F9),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.indigo,
            scaffoldBackgroundColor: const Color(0xFF0F172A),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1E293B),
              foregroundColor: Colors.white,
            ),
          ),
          home: const AuthScreen(),
        );
      },
    );
  }
}

// ---------------------------------------------------
// 1. شاشەی چوونەژوورەوە و تۆمارکردن (Auth Screen)
// ---------------------------------------------------
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoginMode = true;
  bool isLoading = false;

  // بۆ ئاندڕۆید ئیمۆلایتەر 10.0.2.2 بەکاربهێنە، بۆ Windows App 127.0.0.1 بەکاربهێنە
  final String baseUrl = 'http://10.0.2.2:5000';

  Future<void> _submitAuth() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تکایە ناوی بەکارهێنەر و پاسۆرد بنووسە')),
      );
      return;
    }

    setState(() => isLoading = true);

    final endpoint = isLoginMode ? '/login' : '/register';
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      final resData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (isLoginMode) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  DashboardScreen(baseUrl: baseUrl, username: username),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resData['message'] ?? 'تۆمارکردن سەرکەوتوو بوو!'),
            ),
          );
          setState(() => isLoginMode = true);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resData['message'] ?? 'هەڵەیەک ڕوویدا')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('نەتتوانی بەستنەوە بە بەکئێند دروست بکەیت!'),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shield_outlined,
                size: 80,
                color: Colors.indigoAccent,
              ),
              const SizedBox(height: 16),
              Text(
                isLoginMode ? 'چوونەژوورەوە' : 'دروستکردنی ئەکاونتی نوێ',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'ناوی بەکارهێنەر',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'وشەی تێپەڕ',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _submitAuth,
                      child: Text(
                        isLoginMode ? 'بچۆ ژوورەوە' : 'تۆمار بە',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
              TextButton(
                onPressed: () => setState(() => isLoginMode = !isLoginMode),
                child: Text(
                  isLoginMode
                      ? 'ئەکاونتت نییە؟ ئێرە داگرە'
                      : 'ئەکاونتت هەیە؟ بچۆ ژوورەوە',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------
// 2. شاشەی سەرەکی (Dashboard Screen & CRUD)
// ---------------------------------------------------
class DashboardScreen extends StatefulWidget {
  final String baseUrl;
  final String username;
  const DashboardScreen({
    super.key,
    required this.baseUrl,
    required this.username,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    try {
      final response = await http.get(Uri.parse('${widget.baseUrl}/items'));
      if (response.statusCode == 200) {
        setState(() {
          items = jsonDecode(response.body);
          isLoading = false;
        });
      }
    } catch (_) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _showAddOrEditDialog({int? id, String? currentTitle}) async {
    final controller = TextEditingController(text: currentTitle ?? '');
    final isEdit = id != null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'دەستکاریکردنی تێبینی' : 'زیادکردنی تێبینی نوێ'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'دەقەکە لێرە بنووسە...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('پاشگەزبوونەوە'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) return;

              if (isEdit) {
                await http.put(
                  Uri.parse('${widget.baseUrl}/items/$id'),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({'title': controller.text.trim()}),
                );
              } else {
                await http.post(
                  Uri.parse('${widget.baseUrl}/items'),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({'title': controller.text.trim()}),
                );
              }
              _fetchItems();
              Navigator.pop(context);
            },
            child: Text(isEdit ? 'تۆمارکردن' : 'زیادکردن'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteItem(int id) async {
    await http.delete(Uri.parse('${widget.baseUrl}/items/$id'));
    _fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بەخێربێیت ${widget.username} 👋'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
          ? const Center(child: Text('هیچ داتایەک لە داتابەیسدا نییە!'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(item['title'] ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () => _showAddOrEditDialog(
                            id: item['id'],
                            currentTitle: item['title'],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => _deleteItem(item['id']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOrEditDialog(),
        backgroundColor: Colors.indigoAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// ---------------------------------------------------
// 3. شاشەی ڕێکخستنەکان (Settings & Dark Mode)
// ---------------------------------------------------
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('ڕێکخستنەکان')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('دۆخی تاریک (Dark Mode)'),
            subtitle: const Text('گۆڕینی ڕەنگی ئەپەکە بۆ Dark/Light'),
            value: isDark,
            onChanged: (val) {
              themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('چوونەدەرەوە (Logout)'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
