import 'package:flutter/material.dart';

class SettingsToggle extends StatefulWidget {
  const SettingsToggle({
    super.key,
    required this.label,
    required this.icon,
    this.defaultValue = false,
  });

  final String label;
  final IconData icon;
  final bool defaultValue;

  @override
  State<SettingsToggle> createState() => _SettingsToggleState();
}

class _SettingsToggleState extends State<SettingsToggle> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFDFEDFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          widget.icon,
          color: const Color(0xFF003696),
          size: 20,
        ),
      ),
      title: Text(
        widget.label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF0F172A),
        ),
      ),
      value: _value,
      onChanged: (value) {
        setState(() => _value = value);
      },
      activeColor: const Color(0xFF003696),
      activeTrackColor: const Color(0xFFDFEDFF),
    );
  }
}
