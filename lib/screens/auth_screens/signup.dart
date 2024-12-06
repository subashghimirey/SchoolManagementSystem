import 'package:flutter/material.dart';
import 'package:sms_app/auth/authentication.dart';
import 'package:sms_app/screens/auth_screens/login.dart'; // Import AuthService

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;
  bool _agreedToTerms = false;
  final AuthService _authService = AuthService(); // Initialize AuthService

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onContinuePressed() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _selectedRole == null ||
        !_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please complete all fields and accept the terms.')),
      );
      return;
    }

    try {
      // Call the AuthService to register the user
      final user = await _authService.registerUser(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful for ${user.email}!')),
        );

        _emailController.clear();
        _passwordController.clear();

        // Navigate to the dashboard or another screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
      body: 
        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
               
                children: [
                  Image.asset('assets/launch.png'),
                  const Text(
                    'Nice to see you!',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // const SizedBox(height: 40.0),
                  const Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 22.0,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 24.0),
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
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    hint: const Text('Select your role'),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                    items: [
                      'Student',
                      'Teacher',
                      'Admin',
                    ]
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CheckboxListTile(
                    value: _agreedToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = value ?? false;
                      });
                    },
                    title: const Text('I agree with Terms & Conditions'),
                    activeColor: Colors.blue,
                    
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _onContinuePressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        
                      ),
                      minimumSize: const Size.fromHeight(48.0),
                      backgroundColor: Color.fromARGB(255, 203, 100, 22)
                    ),
                    child: const Text('Continue', style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?', style: TextStyle(fontSize: 16),),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Login here',
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ],
                ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
