# InputFormatters Example - Flutter

A comprehensive Flutter example demonstrating the **importance and power of InputFormatters** in TextField widgets. This project shows the critical difference between `TextInputType`, `validation`, and `inputFormatters` - and why InputFormatters should be your go-to solution for controlling text input.

## 🎯 Project Overview

This example application presents **3 different scenarios** where input formatting is essential, comparing three approaches to input control:

1. **TextInputType Only**  (Worst Approach)
2. **Validation Only**  (Fair Approach)
3. **InputFormatters**  (Best Approach)

---

## 📚 Key Concepts

### 1. TextInputType Only
**What it does:** Shows a keyboard hint to the user (e.g., phone pad for phone numbers)

**Problems:**
- User can still paste special characters
- No real validation or formatting
- Validation happens only on submit
- Poor user experience

**Example:**
```dart
TextField(
  keyboardType: TextInputType.phone,
  decoration: InputDecoration(labelText: 'Phone'),
)
```

**Result:** User can type/paste "(123)abc-7890" → validation fails on submit

---

### 2. Validation Only
**What it does:** Accepts any input, checks validity after submission

**Problems:**
- User can type invalid characters freely
- Error appears only after submitting
- User wastes time typing wrong data
- Still no auto-formatting

**Example:**
```dart
String? validatePhone(String value) {
  if (value.length != 10) {
    return 'Phone must be 10 digits';
  }
  return null;
}
```

**Result:** User types "abc@#$%" → error shows only on submit button click

---

### 3. InputFormatters (BEST) ✅
**What it does:** Controls input in real-time, prevents invalid characters, auto-formats

**Benefits:**
- Invalid characters are **rejected immediately**
- Auto-formatting as user types
- **Excellent user experience**
- Full control over paste operations
- No wasted time entering wrong data

**Example:**
```dart
TextField(
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
    PhoneNumberFormatter(),
  ],
)
```

**Result:** User types "1234567890" → automatically becomes "(123) 456-7890"

---

## 📊 Comparison Table

| Feature | TextInputType | Validation | InputFormatters |
|---------|---|---|---|
| Real-time control | No | No | **Yes** |
| Prevents invalid input | No | No | **Yes** |
| Auto-formatting | No | No | **Yes** |
| User experience | Poor | Fair | **Excellent** |
| Paste handling | No control | No control | **Full control** |

---

## 🎨 Examples Included

### 1. Phone Number Formatter
Formats input to: `(123) 456-7890`

```dart
PhoneNumberFormatter() // Custom formatter
```
### 2. Digits Only
```dart
FilteringTextInputFormatter.digitsOnly
```

### 3. Length Limiting
```dart
LengthLimitingTextInputFormatter(10)
```

---

## 🚀 How to Run

### Prerequisites
- Flutter SDK installed
- A device or emulator ready

### Steps

1. **Clone/Navigate to project:**
```bash
cd input_formatters_example
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Run the app:**
```bash
flutter run
```

4. **Test the examples:**
   - Try typing in each TextField
   - Notice how InputFormatters prevent invalid characters
   - See automatic formatting in action
   - Compare with TextInputType-only and Validation-only examples

---

## 🎓 Learning Outcomes

After studying this example, you'll understand:

✅ Why TextInputType alone is insufficient

✅ Limitations of validation-only approaches

✅ Power and flexibility of InputFormatters

✅ How to create custom formatters

---

## 🎯 Key Takeaway

**InputFormatters > Validation > TextInputType**

Always prioritize InputFormatters for controlling user input in TextField widgets. They provide:
- Better user experience
- Real-time feedback
- Automatic formatting
- Prevention of invalid input
- Professional polish to your app

---

## 📚 Additional Resources

- [Flutter TextField Documentation](https://api.flutter.dev/flutter/material/TextField-class.html)
- [TextInputFormatter Documentation](https://api.flutter.dev/flutter/services/TextInputFormatter-class.html)
- [FilteringTextInputFormatter Documentation](https://api.flutter.dev/flutter/services/FilteringTextInputFormatter-class.html)

---

## 👨‍💻 Notes

This example was created to demonstrate that **input control is not a one-size-fits-all solution**. Different scenarios require different approaches, but InputFormatters should always be your first choice for real-time input validation and formatting.

---

## 📄 License

This project is open source and available under the MIT License.

---

**Happy Coding!** 🚀
