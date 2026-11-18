import 'package:flutter/material.dart';
import 'package:frontend/app/router/app_routes.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.go(AppRoutes.home);
          },
          child: Text("click"),
        ),
      ),
    );
  }
}
