// ignore_for_file: file_names, deprecated_member_use, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medcineapp/Presentation/views/homeView.dart';
import 'package:medcineapp/Presentation/views/registerPage.dart';
import 'package:medcineapp/Presentation/views/verfiyEmail.dart';
import 'package:medcineapp/const.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    // Basic input validation
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter your email.')));
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter your password.')));
      return;
    }

    try {
      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to Homeview after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homeview()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password provided.';
          break;
        case 'invalid-email':
          message = 'The email address is invalid.';
          break;
        case 'user-disabled':
          message = 'This user account has been disabled.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred. Please try again.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100, left: 130),
                child: Text(
                  'Login Now',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              std,
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF2F8FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Enter your email',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF2F8FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    const Text('Remember me', style: TextStyle(fontSize: 15)),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Verfiyemail(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(340, 50),
                    backgroundColor: const Color(0xFF4A90E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey[250],
                      endIndent: 10,
                    ),
                  ),
                  const Text('or', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey[250],
                      indent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(left: 140),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset('asset/icons/google_icon.png'),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(left: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset('asset/icons/Apple-Logo.png'),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Registerpage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// // ignore_for_file: file_names, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:medcineapp/Presentation/views/homeView.dart';
// import 'package:medcineapp/Presentation/views/registerPage.dart';
// import 'package:medcineapp/Presentation/views/verfiyEmail.dart';
// import 'package:medcineapp/const.dart';

// class Loginview extends StatefulWidget {
//   const Loginview({super.key});

//   @override
//   State<Loginview> createState() => _LoginviewState();
// }

// class _LoginviewState extends State<Loginview> {
//   bool _obscurePassword = true;
//   bool _rememberMe = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox.expand(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(top: 100, left: 130),
//                 child: Text(
//                   'Login Now',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               std,
//               const SizedBox(height: 20),
//               const Padding(
//                 padding: EdgeInsets.only(left: 15),
//                 child: Text(
//                   'Email',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFF2F8FF),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Padding(
//                 padding: EdgeInsets.only(left: 15),
//                 child: Text(
//                   'Password',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: TextField(
//                   obscureText: _obscurePassword,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFF2F8FF),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ),

//               /// 👉 "Remember Me" Checkbox
//               Padding(
//                 padding: const EdgeInsets.only(left: 8, top: 8),
//                 child: Row(
//                   children: [
//                     Checkbox(
//                       value: _rememberMe,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _rememberMe = value!;
//                         });
//                       },
//                     ),
//                     const Text('Remember me', style: TextStyle(fontSize: 15)),
//                     Spacer(),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return Verfiyemail();
//                             },
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         'Forgot Password',
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 25),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Homeview()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(340, 50),
//                     backgroundColor: const Color(0xFF4A90E2),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                   ),
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Divider(
//                       thickness: 1.5,
//                       color: Colors.grey[250],
//                       endIndent: 10,
//                     ),
//                   ),
//                   const Text('or', style: TextStyle(fontSize: 16)),
//                   Expanded(
//                     child: Divider(
//                       thickness: 1.5,
//                       color: Colors.grey[250],
//                       indent: 10,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 25),
//               Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     margin: const EdgeInsets.only(left: 140),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.grey[200],
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Image.asset('asset/icons/google_icon.png'),
//                   ),
//                   Container(
//                     width: 40,
//                     height: 40,
//                     margin: const EdgeInsets.only(left: 25),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.grey[200],
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Image.asset('asset/icons/Apple-Logo.png'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 80),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Don\'t have an account?',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Registerpage(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'Register',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
