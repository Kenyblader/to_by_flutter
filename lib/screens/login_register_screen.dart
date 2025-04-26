import 'package:flutter/material.dart';
import 'package:to_buy/components/login_form.dart';
import 'package:to_buy/components/register_form.dart';
import 'package:to_buy/screens/item_list_screen.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  bool isLogin = true;
  String? errorMessage;

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void onSubmit(String email, String password, GlobalKey<FormState> formKey) {
    formKey.currentState?.validate();
    // Handle form submission logic here
    if (isLogin) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ItemListScreen()),
        (route) => false,
      );

      // Perform login
    } else {
      toggleForm();
    }
    // Example error handling
    if (errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Connexion' : 'Inscription'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            isLogin
                ? LoginForm(onSubmit: onSubmit, goToRegister: toggleForm)
                : RegisterForm(onSubmit: onSubmit, goToLogin: toggleForm),
          ],
        ),
      ),
    );
  }
}
