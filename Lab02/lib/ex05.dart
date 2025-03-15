import 'package:flutter/material.dart';

class ex05 extends StatefulWidget {
  const ex05({super.key});

  @override
  _ex05 createState() => _ex05();
}

class _ex05 extends State<ex05> {
  String selectedLanguage = "English";
  String selectedEnvironment = "Production";
  String selectedPlatform = "Default";

  bool enableCustomTheme = false;
  bool lockApp = true;
  bool fingerPrint = true;
  bool changePW = true;
  bool enableNotification = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          buildSection("Common"),
          buildSetting(Icons.language, "Language", selectedLanguage),
          buildSetting(Icons.cloud, "Environment", selectedEnvironment),
          buildSetting(Icons.devices, "Platform", selectedPlatform),
          buildSwitch("Enable custom theme", enableCustomTheme, (val) {
            setState(() => enableCustomTheme = val);
          }),
          buildSection("Account"),
          buildSetting(Icons.phone, "Phone number"),
          buildSetting(Icons.email, "Email"),
          buildSetting(Icons.exit_to_app, "Sign out"),
          buildSection("Account"),
          buildSetting(Icons.phone, "Phone number"),
          buildSetting(Icons.email, "Email"),
          buildSetting(Icons.exit_to_app, "Sign out"),

          buildSection("Security"),
          buildSwitch("Lock app in background", lockApp, (val) {
            setState(() => lockApp = val);
          }),
          buildSwitch("Use fingerprint", fingerPrint, (val) {
            setState(() => fingerPrint = val);
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Allow application to access stored fingerprint IDs",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          buildSwitch("Change password", changePW, (val) {
            setState(() => changePW = val);
          }),
          buildSwitch("Enable notifications", enableNotification, (val) {
            setState(() => enableNotification = val);
          }),
        ],
      ),
    );
  }
  Widget buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget buildSetting(IconData icon, String title, [String ? subtitle]) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing: subtitle != null
        ? Text(subtitle, style: TextStyle(color: Colors.grey[600]))
          : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
  Widget buildSwitch(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
    );
  }



}