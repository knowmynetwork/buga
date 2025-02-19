import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/api_service.dart';
import 'auth_viewmodel.dart';

final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel(ApiService());
});

class SignUpWithViewModelPage extends ConsumerWidget {
  const SignUpWithViewModelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await ref
                .read(authViewModelProvider)
                .signUp('test@example.com', 'password123');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(authViewModel.message)),
            );
          },
          child: const Text('Dummy Sign Up'),
        ),
      ),
    );
  }
}
