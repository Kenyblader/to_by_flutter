import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_buy/components/login_form.dart';
import 'package:to_buy/components/register_form.dart';
import 'package:to_buy/provider/auth_provider.dart';
import 'package:to_buy/screens/item_list_screen.dart';

class LoginRegisterScreen extends ConsumerStatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  ConsumerState<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends ConsumerState<LoginRegisterScreen> {
  bool isLogin = true;
  String? errorMessage;
  bool isSubmitting = false;

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
      errorMessage = null; // Réinitialiser le message d'erreur
    });
  }

  void onSubmit(String email, String password, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isSubmitting = true; // Indiquer que la soumission est en cours
        errorMessage = null;
      });
      final authService = ref.read(authProvider);
      String? error;
      if (isLogin) {
        error = await authService.signInWithEmail(email, password);
      } else {
        error = await authService.signUpWithEmail(email, password);
        if (error == null) {
          // Attendre que l'utilisateur soit déconnecté
          await Future.delayed(const Duration(milliseconds: 1000));
          if (FirebaseAuth.instance.currentUser == null) {
            // Passer à l'écran de connexion après inscription
            toggleForm();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Inscription réussie ! Veuillez vous connecter.')),
            );
          }
        }
      }
      setState(() {
        isSubmitting = false; // Terminer la soumission
        errorMessage = error;
      });
      if (error == null && isLogin) {
        // Redirection après connexion réussie
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ItemListScreen()),
          (route) => false,
        );
      } else if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
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
                ? LoginForm(onSubmit: onSubmit, goToRegister: toggleForm, errorMessage: errorMessage)
                : RegisterForm(onSubmit: onSubmit, goToLogin: toggleForm, errorMessage: errorMessage),
          ],
        ),
      ),
    );
  }
}