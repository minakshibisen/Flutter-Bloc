import 'package:bloc_flutter/ui/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/input_field.dart';
import '../../common/primary_button.dart';
import '../../ui/favorite_screen.dart';
import 'login_bloc.dart';
import 'login_event.dart';

class AnimatedLoginScreen extends StatefulWidget {
  const AnimatedLoginScreen({super.key});

  @override
  AnimatedLoginScreenState createState() => AnimatedLoginScreenState();
}

class AnimatedLoginScreenState extends State<AnimatedLoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.37,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB993D6), Color(0xFF8CA6DB)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const CounterScreen()),
                    );
                  }
                },
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    ScaleTransition(
                      scale: _animation,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset('assets/images/login.png'),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),

                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return NeumorphicTextField(
                          icon: Icons.email,
                          hint: "Email",
                          controller: emailController,
                          onChanged: (email) => context
                              .read<LoginBloc>()
                              .add(EmailChanged(email)),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.02),

                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return NeumorphicTextField(
                          icon: Icons.lock,
                          hint: "Password",
                          controller: passwordController,
                          obscureText: true,
                          onChanged: (password) => context
                              .read<LoginBloc>()
                              .add(PasswordChanged(password)),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.04),

                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return PrimaryButton(
                          text: "Login",
                          isLoading: state.isSubmitting,
                          onPressed: () {
                            context.read<LoginBloc>().add(LoginSubmitted());
                          },
                          context: context,
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.02),

                    Text(
                      "Forgot your password?",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: size.height * 0.04),

                    /// Social Buttons
                    _buildSocialButtons(),
                    const SizedBox(height: 20),

                    /// Sign Up Redirect
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FavoriteScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Don't have an account? Sign up",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(Icons.facebook, "Facebook", Colors.blue),
        const SizedBox(width: 20),
        _buildSocialButton(Icons.apple, "Apple", Colors.black),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label, Color color) {
    return SizedBox(
      width: 140,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 40);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height - 80, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
