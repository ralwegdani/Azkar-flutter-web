import 'package:flutter/material.dart';

void main() {
  runApp(const AzkarApp());
}

class AzkarApp extends StatelessWidget {
  const AzkarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const AzkarHome(),
    );
  }
}

class AzkarHome extends StatefulWidget {
  const AzkarHome({super.key});

  @override
  State<AzkarHome> createState() => _AzkarHomeState();
}

class _AzkarHomeState extends State<AzkarHome> {
  final int target = 33;

  List<Map<String, dynamic>> azkar = [
    {"text": "سبحان الله", "count": 0},
    {"text": "الحمدلله", "count": 0},
    {"text": "الله أكبر", "count": 0},
    {"text": "لا إله إلا الله", "count": 0},
  ];

  void increment(int index) {
    setState(() {
      if (azkar[index]["count"] < target) {
        azkar[index]["count"]++;
      }
    });

    checkCompletion();
  }

  void reset(int index) {
    setState(() {
      azkar[index]["count"] = 0;
    });
  }

  void checkCompletion() {
    bool allCompleted =
        azkar.every((zikr) => zikr["count"] == target);

    if (allCompleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🌟 بارك الله فيك، أحسنت!"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📿 Azkar App"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: azkar.length,
        itemBuilder: (context, index) {
          double progress = azkar[index]["count"] / target;
          bool completed = azkar[index]["count"] == target;

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        azkar[index]["text"],
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      if (completed)
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 28)
                    ],
                  ),

                  const SizedBox(height: 15),

                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${azkar[index]["count"]} / $target",
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => increment(index),
                        icon: const Icon(Icons.add),
                        label: const Text("إضافة"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => reset(index),
                        icon: const Icon(Icons.refresh),
                        label: const Text("تصفير"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}