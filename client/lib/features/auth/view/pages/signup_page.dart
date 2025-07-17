import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/utills.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});
  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          showSnackBar(context, 'Account Created Successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true, // Ensures scrollable space for keyboard
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    CustomField(
                      hintText: 'Name',
                      controller: nameController,
                      isObscureText: false,
                    ),
                    const SizedBox(height: 20),
                    CustomField(
                      hintText: 'Email',
                      controller: emailController,
                      isObscureText: false,
                    ),
                    const SizedBox(height: 20),
                    CustomField(
                      hintText: 'Password',
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(height: 25),
                    AuthGradientButton(
                      buttonText: 'Sign Up',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await ref.read(authViewModelProvider.notifier).signUpUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: const [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: Pallete.gradient3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
    );
  }
}
