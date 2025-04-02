import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/input_field.dart';
import '../../common/primary_button.dart';
import '../bloc/signUp/sign_up_bloc.dart';
import '../bloc/signUp/sign_up_event.dart';
import '../bloc/signUp/sign_up_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB993D6), Color(0xFF8CA6DB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Hero(
                        tag: 'signup_title',
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 90,
                          backgroundImage: _imagePath != null
                              ? FileImage(File(_imagePath!))
                              : NetworkImage('https://previews.123rf.com/images/moremar/moremar1709/moremar170900019/86803734-female-portrait-avatar-woman-in-a-circle-on-a-white-background-linear-art-vector-illustration.jpg') as ImageProvider,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: Icon(Icons.camera_alt, color: Colors.black, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlocListener<SignupBloc, SignupState>(
                      listener: (context, state) {
                        if (state.isSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Signup Successful!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        } else if (state.isFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Signup Failed: Passwords do not match"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Column(
                        children: [
                          _buildTextField(
                            nameController,
                            "Name",
                            Icons.person,
                                (name) => context.read<SignupBloc>().add(NameChanged(name)),
                          ),
                          _buildTextField(
                            emailController,
                            "Email",
                            Icons.email,
                                (email) => context.read<SignupBloc>().add(EmailChanged(email)),
                          ),
                          _buildTextField(
                            passwordController,
                            "Password",
                            Icons.lock,
                                (password) => context.read<SignupBloc>().add(PasswordChanged(password)),
                            obscureText: true,
                          ),
                          _buildTextField(
                            confirmPasswordController,
                            "Confirm Password",
                            Icons.lock,
                                (confirmPassword) => context.read<SignupBloc>().add(ConfirmPasswordChanged(confirmPassword)),
                            obscureText: true,
                          ),
                          SizedBox(height: 20),
                          BlocBuilder<SignupBloc, SignupState>(
                            builder: (context, state) {
                              return PrimaryButton(
                                text: "Sign Up",
                                isLoading: state.isSubmitting,
                                context: context,
                                onPressed: () {
                                  context.read<SignupBloc>().add(SignupSubmitted());
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Already have an account? Log in",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hint,
      IconData icon,
      Function(String) onChanged,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: NeumorphicTextField(
        hint: hint,
        controller: controller,
        icon: icon,
        obscureText: obscureText,
        onChanged: onChanged,
      ),
    );
  }
}
