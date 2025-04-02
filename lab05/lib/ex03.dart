import 'package:flutter/material.dart';
import 'dart:async';

class ex03 extends StatefulWidget {
  const ex03({Key? key}) : super(key: key);

  @override
  State<ex03> createState() => _ex03State();
}

class _ex03State extends State<ex03> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController(text: '18');
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedCountry;
  final List<String> countries = ['Vietnam', 'Lao', 'Thailand', 'Cambodia'];

  bool _obscurePassword = true;
  bool _isLoading = false;
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate sending data to server
      Timer(const Duration(seconds: 3), () {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Server is busy, try again later"),
            duration: Duration(seconds: 3),
          ),
        );
      });
    }
  }
  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Basic Form'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Registering, please wait...'),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'User Registration',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                decoration: _inputDecoration(
                  label: 'Full Name',
                  hint: 'Enter your name',
                  prefixIcon: Icons.person,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your full name';
                  if (value.length < 6) return 'Name must be at least 6 characters long';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(
                  label: 'Email',
                  hint: 'Enter your email',
                  prefixIcon: Icons.email,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your email';
                  if (!value.contains('@')) return 'Email must contain "@"';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  label: 'Age',
                  hint: 'Enter your age',
                  prefixIcon: Icons.tag,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your age';
                  if (value.length > 2) return 'Age must be max 2 digits';
                  final int? age = int.tryParse(value);
                  if (age == null || age < 16 || age > 99) return 'Age must be between 16 and 99';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                decoration: _inputDecoration(
                  label: 'Country',
                  hint: 'Select your country',
                  prefixIcon: Icons.location_city,
                ),
                items: countries.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountry = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please select a country';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: _inputDecoration(
                  label: 'Password',
                  hint: 'Enter your password',
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your password';
                  if (value.length < 6) return 'Password must be at least 6 characters long';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
