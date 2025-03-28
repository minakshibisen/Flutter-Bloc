import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import 'counter_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CounterScreen()),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    errorText: state.email.isEmpty ? "Email required" : null,
                  ),
                  onChanged: (email) {
                    context.read<LoginBloc>().add(EmailChanged(email));
                  },
                );
              },
            ),
            SizedBox(height: 10),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorText: state.password.isEmpty ? "Password required" : null,
                  ),
                  obscureText: true,
                  onChanged: (password) {
                    context.read<LoginBloc>().add(PasswordChanged(password));
                  },
                );
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state.isSubmitting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  },
                  child: Text("Login"),
                );
              },
            ),
            SizedBox(height: 10),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state.isSuccess) {
                  return Text(
                    "Login Successful!",
                    style: TextStyle(color: Colors.green),
                  );
                } else if (state.isFailure) {
                  return Text(
                    "Login Failed!",
                    style: TextStyle(color: Colors.red),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
