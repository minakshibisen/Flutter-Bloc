import 'package:bloc_flutter/common/primary_button.dart';
import 'package:bloc_flutter/ui/favorite_screen.dart';
import 'package:bloc_flutter/ui/home_screen.dart';
import 'package:bloc_flutter/ui/switch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/input_field.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.37,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB993D6), Color(0xFF8CA6DB)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SwitchScreen()),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                      ),
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset('assets/images/login.png')),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return NeumorphicTextField(
                            hint: "Password",
                            controller: passwordController,
                            obscureText: true,
                            onChanged: (password) => context
                                .read<LoginBloc>()
                                .add(PasswordChanged(password)),
                            icon: Icons.lock,
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text("Forgot your password?",
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      _buildSocialButtons(),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FavoriteScreen(
                            )),
                          );
                        },
                        child: Text(
                          "Don't have an account? Sign up",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
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
        SizedBox(width: 20),
        _buildSocialButton(Icons.apple, "Apple", Colors.blue),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label, Color color) {
    return SizedBox(
      width: 150,
      height: 80,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
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
