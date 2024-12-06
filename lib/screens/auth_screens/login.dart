import 'package:flutter/material.dart';
import 'package:sms_app/auth/authentication.dart';
import 'package:sms_app/screens/auth_screens/signup.dart';
import 'package:sms_app/widgets/bottom_nav_bar.dart'; // Import AuthService

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Initialize AuthService

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    try {
      // Authenticate user with AuthService
      final user = await _authService.loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (user != null) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Welcome back, ${user.email}!')),
        // );

        // Navigate to the dashboard or another screen
        // Navigator.pushReplacementNamed(context, '/home');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image at the top
            Image.asset(
              'assets/launch.png',
              height: 150,
              width: 150,
            ),
            // const SizedBox(height: 24.0),
            const Text(
              'Hello Again!',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Welcome back, you\'ve been missed!',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Your email address',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            // Login Button
            ElevatedButton(
              onPressed: _onLoginPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                minimumSize: const Size.fromHeight(48.0),
                backgroundColor: const Color.fromARGB(255, 203, 100, 22),
              ),
              child: const Text(
                'Log In',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            // Sign Up Redirect
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35,),
          ],
          
        ),
      ),
    );
  }
}
