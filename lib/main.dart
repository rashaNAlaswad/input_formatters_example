import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Input Comparison', home: const ExamplePage());
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _formKey = GlobalKey<FormState>();

  final _typeOnlyController = TextEditingController();
  final _validationController = TextEditingController();
  final _combinedController = TextEditingController();

  @override
  void dispose() {
    _typeOnlyController.dispose();
    _validationController.dispose();
    _combinedController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isValid ? 'Form is valid' : 'Fix errors first')),
    );
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }

    if (value.length != 10) {
      return 'Enter 10 digits';
    }
    return null;
  }

  String? _phoneValidator2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length != 10) {
      return 'Enter 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TextInputType vs Validation vs InputFormatter',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// 1. TextInputType فقط
              _buildSection(
                title: '1. TextInputType (Keyboard Hint Only)',
                description:
                    'يغيّر الكيبورد فقط. لا يمنع إدخال خاطئ ولا يتحكم بالبيانات.',
                child: TextFormField(
                  controller: _typeOnlyController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    // labelText: 'Phone',
                    hintText: 'Try paste: abc@#123',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 2. Validation & TextInputType
              _buildSection(
                title: '2. Validation & TextInputType',
                description: 'يسمح بأي إدخال، ويكتشف الخطأ فقط بعد الكتابة.',
                child: TextFormField(
                  controller: _validationController,
                  keyboardType: TextInputType.phone,
                  validator: _phoneValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    hintText: 'Type anything...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 3. الحل الصحيح
              _buildSection(
                title: '3. Combined Approach (Best Practice)',
                description:
                    'TextInputType + InputFormatter + Validation = أفضل تجربة مستخدم.',
                child: TextFormField(
                  controller: _combinedController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(10),
                    PhoneNumberFormatter(),
                  ],
                  validator: _phoneValidator2,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    hintText: '1234567890',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Button واحد لكل الفورم
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Submit Form'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(description, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Formatter لعرض الرقم بشكل (123) 456-7890
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      if (i == 0) buffer.write('(');
      buffer.write(digits[i]);
      if (i == 2) buffer.write(') ');
      if (i == 5) buffer.write('-');
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// inputFormatters: [
//   FilteringTextInputFormatter.digitsOnly,
//   LengthLimitingTextInputFormatter(10),
//   FilteringTextInputFormatter.deny(RegExp(r'\s')),
//   FilteringTextInputFormatter.deny(RegExp(r'[!@#]')),
//   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
//   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
// ]

// class UpperCaseFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     return newValue.copyWith(
//       text: newValue.text.toUpperCase(),
//     );
//   }
// }
