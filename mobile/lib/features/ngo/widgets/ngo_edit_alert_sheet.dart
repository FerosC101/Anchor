import 'package:flutter/material.dart';
import '../core/ngo_theme.dart';
import '../models/ngo_models.dart';

void showEditAlertSheet(BuildContext context, NgoAlert alert) {
  final titleController =
      TextEditingController(text: '${alert.title} ${alert.employerName}');
  final employerController = TextEditingController(text: alert.employerName);
  final countryController = TextEditingController(text: alert.country);
  final descriptionController = TextEditingController(text: alert.description);
  String selectedAlertType = alert.alertType;
  String selectedSeverity = alert.severity;

  final mq = MediaQuery.of(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.white,
    constraints: BoxConstraints(
      maxWidth: mq.size.width,
      maxHeight: mq.size.height,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setModalState) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.65,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (_, scroll) {
              return SingleChildScrollView(
                controller: scroll,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Drag handle ──
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Header ──
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Edit Alert',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(ctx),
                          child: const Icon(Icons.close_rounded,
                              color: Color(0xFF94A3B8), size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Update the alert details below',
                      style:
                          TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 20),

                    // ── Alert Title ──
                    _fieldLabel('Alert Title', required: true),
                    const SizedBox(height: 6),
                    _textField(titleController),
                    const SizedBox(height: 16),

                    // ── Alert Type + Severity row ──
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _fieldLabel('Alert Type', required: true),
                              const SizedBox(height: 6),
                              _dropdown(
                                value: selectedAlertType,
                                items: const [
                                  'Employer Warning',
                                  'Safety Alert',
                                  'Travel Advisory',
                                ],
                                onChanged: (v) => setModalState(
                                    () => selectedAlertType = v!),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _fieldLabel('Severity', required: true),
                              const SizedBox(height: 6),
                              _dropdown(
                                value: selectedSeverity,
                                items: const ['High', 'Medium', 'Low'],
                                onChanged: (v) => setModalState(
                                    () => selectedSeverity = v!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── Employer Name + Country row ──
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _fieldLabel('Employer Name'),
                              const SizedBox(height: 6),
                              _textField(employerController),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _fieldLabel('Country'),
                              const SizedBox(height: 6),
                              _textField(countryController),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── Description ──
                    _fieldLabel('Description', required: true),
                    const SizedBox(height: 6),
                    TextField(
                      controller: descriptionController,
                      maxLines: 5,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText:
                            'Provide detailed information about this alert...',
                        hintStyle: const TextStyle(
                            fontSize: 13, color: Color(0xFFADB5BD)),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: NgoTheme.purple),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Action buttons ──
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF0F172A),
                                side: const BorderSide(
                                    color: Color(0xFFE2E8F0)),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10)),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF3D3790),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Update Alert',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  ).then((_) {
    titleController.dispose();
    employerController.dispose();
    countryController.dispose();
    descriptionController.dispose();
  });
}

// ── Helpers ───────────────────────────────────────────────────────────────────

Widget _fieldLabel(String text, {bool required = false}) {
  return RichText(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),
      children: required
          ? const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Color(0xFFF4A261)),
              ),
            ]
          : null,
    ),
  );
}

Widget _textField(TextEditingController controller) {
  return TextField(
    controller: controller,
    style: const TextStyle(fontSize: 14),
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      border: UnderlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(0),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: NgoTheme.purple),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      isDense: true,
    ),
  );
}

Widget _dropdown({
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Container(
    height: 44,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F0F5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF64748B), size: 20),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0F172A),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    ),
  );
}
