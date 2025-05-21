import 'package:bloc_flutter/ui/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late LoginBloc _loginBloc;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loginBloc = LoginBloc();
    super.initState();
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
        body: BlocProvider(
          create: (_) => _loginBloc,
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
                //_buildStatusMessage(),
              ],
            ),
          ),
        ));
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
          ),
          keyboardType: TextInputType.emailAddress,
          onSubmitted: (value) {},
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
          ),
          onSubmitted: (value) {},
          onChanged: (password) =>
              context.read<LoginBloc>().add(PasswordChanged(password)),
        );
      },
    );
  }
  Widget _buildLoginButton() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message.toString())),
          );
        }

        if (state.loginStatus == LoginStatus.loading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Submitting')),
          );
        }

        if (state.loginStatus == LoginStatus.success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PostScreen()),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (state.email.trim().isEmpty || state.password.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter both email and password."),
                    ),
                  );
                  return;
                }

                context.read<LoginBloc>().add(LoginApi());
              },
              child: const Text("Login"),
            ),
          );
        },
      ),
    );
  }


  Widget _buildStatusMessage() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
        true,
      builder: (context, state) {
        if (state.loginStatus == LoginStatus.success) {
          return const Text(
            "Login Successful!",
            style: TextStyle(color: Colors.green),
          );
        } else if (state.loginStatus == LoginStatus.error) {
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
