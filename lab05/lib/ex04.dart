import 'package:flutter/material.dart';

class ex04 extends StatefulWidget {
  const ex04({Key? key}) : super(key: key);

  @override
  State<ex04> createState() => _ex04();
}

class _ex04 extends State<ex04> {
  int _currentStep = 0;
  final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  bool _isCompleted = false;

  void _nextStep() {
    if (_currentStep < 2) {
      if (_formKeys[_currentStep].currentState!.validate()) {
        setState(() {
          _currentStep++;
        });
      }
    } else {
      setState(() {
        _isCompleted = true;
      });
    }
  }

  void _backStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _resetForm() {
    setState(() {
      _isCompleted = false;
      _currentStep = 0;
      _nameController.clear();
      _lastNameController.clear();
      _addressController.clear();
      _postalCodeController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi-Step Form')),
      body: _isCompleted
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Thank You!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetForm,
              child: const Text('RESET'),
            ),
          ],
        ),
      )
          : Stepper(
        currentStep: _currentStep,
        onStepContinue: _nextStep,
        onStepCancel: _backStep,
        controlsBuilder: (context, details) {
          return Row(
            children: [
              if (_currentStep > 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: details.onStepContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentStep == 2 ? Colors.green : Colors.blue,
                ),
                child: Text(_currentStep == 2 ? 'Finish' : 'Next'),
              ),
            ],
          );
        },
        steps: [
          Step(
            title: const Text('Personal Info'),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: Form(
              key: _formKeys[0],
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter first name' : null,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter last name' : null,
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Shipping Address'),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: Form(
              key: _formKeys[1],
              child: Column(
                children: [
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Shipping Address'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter shipping address' : null,
                  ),
                  TextFormField(
                    controller: _postalCodeController,
                    decoration: const InputDecoration(labelText: 'Postal Code'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter postal code' : null,
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Confirm'),
            isActive: _currentStep >= 2,
            state: _currentStep == 2 ? StepState.indexed : StepState.complete,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('First Name: ${_nameController.text}'),
                Text('Last Name: ${_lastNameController.text}'),
                Text('Address: ${_addressController.text}'),
                Text('Postal Code: ${_postalCodeController.text}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
