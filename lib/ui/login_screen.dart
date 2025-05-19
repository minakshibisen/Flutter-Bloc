import 'package:bloc_flutter/ui/favorite_screen.dart';
import 'package:bloc_flutter/ui/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    context.read<LoginBloc>().add(LoginSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
        previous.isSuccess != current.isSuccess ||
            previous.isFailure != current.isFailure,
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PostScreen()),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildEmailField(),
              const SizedBox(height: 12),
              _buildPasswordField(),
              const SizedBox(height: 24),
              _buildLoginButton(),
              const SizedBox(height: 12),
              _buildStatusMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
            border: const OutlineInputBorder(),
            errorText:
            state.email.isEmpty && state.isFailure ? "Email required" : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) =>
              context.read<LoginBloc>().add(EmailChanged(email)),
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            border: const OutlineInputBorder(),
            errorText: state.password.isEmpty && state.isFailure
                ? "Password required"
                : null,
          ),
          onChanged: (password) =>
              context.read<LoginBloc>().add(PasswordChanged(password)),
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
      previous.isSubmitting != current.isSubmitting,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.isSubmitting
                ? null
                : () => _onLoginPressed(context),
            child: state.isSubmitting
                ? const CircularProgressIndicator(
                color: Colors.white, strokeWidth: 2)
                : const Text("Login"),
          ),
        );
      },
    );
  }

  Widget _buildStatusMessage() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
      previous.isSuccess != current.isSuccess ||
          previous.isFailure != current.isFailure,
      builder: (context, state) {
        if (state.isSuccess) {
          return const Text(
            "Login Successful!",
            style: TextStyle(color: Colors.green),
          );
        } else if (state.isFailure) {
          return const Text(
            "Login Failed!",
            style: TextStyle(color: Colors.red),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
