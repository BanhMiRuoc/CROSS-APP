import 'package:flutter/material.dart';

class ex04 extends StatefulWidget {
  const ex04({super.key});

  @override
  _ex04 createState() => _ex04();
}

class _ex04 extends State<ex04> {
  String selectedGender = "FEMALE";
  double height = 169;
  int weight = 67;
  int age = 28;

  void updateGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void updateWeight(int value) {
    setState(() {
      weight += value;
    });
  }

  void updateAge(int value) {
    setState(() {
      age += value;
    });
  }

  void resetValues() {
    setState(() {
      height = 169;
      weight = 67;
      age = 28;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GFG Custom Widget"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Gender Selection using BoxButton
            Row(
              children: [
                Expanded(
                  child: BoxButton(
                    label: "FEMALE",
                    isSelected: selectedGender == "FEMALE",
                    onTap: () => updateGender("FEMALE"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BoxButton(
                    label: "MALE",
                    isSelected: selectedGender == "MALE",
                    onTap: () => updateGender("MALE"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Height Slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "HEIGHT ${height.toInt()} cm",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Slider(
                    value: height,
                    min: 100,
                    max: 220,
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Weight & Age Controls using CounterBox
            Row(
              children: [
                Expanded(child: CounterBox(label: "WEIGHT", value: weight, onUpdate: updateWeight)),
                const SizedBox(width: 10),
                Expanded(child: CounterBox(label: "AGE", value: age, onUpdate: updateAge)),
              ],
            ),
            const SizedBox(height: 20),

            // Clear & Get BMI Buttons
            Row(
              children: [
                Expanded(
                  child: BoxButton(
                    label: "CLEAR",
                    isSelected: false,
                    onTap: resetValues,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BoxButton(
                    label: "GET BMI",
                    isSelected: true,
                    backgroundColor: Colors.green,
                    onTap: () {
                      double bmi = weight / ((height / 100) * (height / 100));
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("BMI Result"),
                          content: Text("Your BMI is ${bmi.toStringAsFixed(2)}"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BoxButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color backgroundColor;

  const BoxButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.backgroundColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? backgroundColor : Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      child: Text(label),
    );
  }
}

class CounterBox extends StatelessWidget {
  final String label;
  final int value;
  final Function(int) onUpdate;

  const CounterBox({
    super.key,
    required this.label,
    required this.value,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            "$label $value",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[700],
                ),
                child: IconButton(
                  onPressed: () => onUpdate(-1),
                  icon: const Icon(Icons.arrow_downward, color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[700], // Màu nhạt hơn
                ),
                child: IconButton(
                  onPressed: () => onUpdate(1),
                  icon: const Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}