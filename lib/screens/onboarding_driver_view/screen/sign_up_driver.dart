

// 1. Define the Provider
// 4. The Screen Widget
import 'export.dart';

class DriverAccountScreen extends ConsumerWidget {
  const DriverAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final formData = ref.watch(driverAccountFormProvider);
    final formDataNotifier = ref.watch(driverAccountFormProvider.notifier);

    void _submitForm() {
      if (formKey.currentState!.validate()) {
        print(
            'Form data: ${formData.toJson()}'); // Print form data (you'll replace this)
        ref.read(driverAccountFormProvider.notifier).resetForm(); // Reset form
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmergencyContactScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')),
        );
      }
    }


Widget _buildInputField({
    required String label,
    required void Function(String) onChanged,
    required String value,
    required String hintText,
    IconData? icon,
    bool isRequired = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ... (Label Text Widgets)
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon) : null,
            border: const OutlineInputBorder(),
            hintText: hintText,
          ),
          validator: validator ??
              (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
        ),
        // ... (SizedBox)
      ],
    );
  }

  Widget _buildPasswordInput({
    required String label,
    required void Function(String) onChanged,
    required String value,
    required String hintText,
    bool isRequired = false,
    String? confirmPassword,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ... (Label Text Widgets)
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            border: const OutlineInputBorder(),
            hintText: hintText,
          ),
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            if (confirmPassword != null && value != confirmPassword) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        // ... (SizedBox)
      ],
    );
  }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (Title and Subtitle Text Widgets)

              _buildInputField(
                label: 'Name',
                onChanged: (value) =>
                    formDataNotifier.updateField('name', value),
                value: formData.name,
                hintText: 'Name',
                icon: Icons.person,
                isRequired: true,
              ),
              _buildInputField(
                label: 'Email',
                onChanged: (value) =>
                    formDataNotifier.updateField('email', value),
                value: formData.email,
                hintText: 'E.g yourname@gmail.com',
                icon: Icons.email,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
              ),
              // ... (Other _buildInputField and _buildPasswordInput widgets)

              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  // ... (ButtonStyle)
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Proceed',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

