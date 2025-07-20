// ignore_for_file: file_names, deprecated_member_use, prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medcineapp/Presentation/views/homeView.dart';
import 'package:medcineapp/Presentation/views/loginView.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _register() async {
    // Basic input validation
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter your name.')));
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your phone number.')),
      );
      return;
    }
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
      // Create user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      // Update user profile with name
      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      // Optionally, store phone number in user profile or Firestore (not implemented here)
      // For example, you could use Firestore to store additional user data:
      // FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
      //   'name': _nameController.text.trim(),
      //   'phone': _phoneController.text.trim(),
      //   'email': _emailController.text.trim(),
      // });

      // Navigate to Homeview after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homeview()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'The email address is already in use.';
          break;
        case 'invalid-email':
          message = 'The email address is invalid.';
          break;
        case 'weak-password':
          message = 'The password provided is too weak.';
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
    _nameController.dispose();
    _phoneController.dispose();
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
                padding: EdgeInsets.only(top: 70, left: 85),
                child: Text(
                  'Create An Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF2F8FF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Enter your name',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Phone number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF2F8FF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Enter your phone number',
                    ),
                  ),
                ),
              ),
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
                child: SizedBox(
                  height: 50,
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
                child: SizedBox(
                  height: 50,
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
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(340, 50),
                    backgroundColor: const Color(0xFF4A90E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Loginview(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login',
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

// // ignore_for_file: file_names, deprecated_member_use, prefer_final_fields, unused_field

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:medcineapp/Presentation/views/homeView.dart';
// import 'package:medcineapp/Presentation/views/loginView.dart';

// class Registerpage extends StatefulWidget {
//   const Registerpage({super.key});

//   @override
//   State<Registerpage> createState() => _RegisterpageState();
// }

// class _RegisterpageState extends State<Registerpage> {
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
//                 padding: EdgeInsets.only(top: 70, left: 85),
//                 child: Text(
//                   'Create An Account',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 50),
//               const Padding(
//                 padding: EdgeInsets.only(left: 15),
//                 child: Text(
//                   'Name',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: SizedBox(
//                   height: 50,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: const Color(0xFFF2F8FF),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Padding(
//                 padding: EdgeInsets.only(left: 15),
//                 child: Text(
//                   'phone number',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: SizedBox(
//                   height: 50,
//                   child: TextField(
//                     keyboardType:
//                         TextInputType.number, // Shows numeric keyboard
//                     inputFormatters: [
//                       FilteringTextInputFormatter
//                           .digitsOnly, // Allows only digits
//                     ],
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: const Color(0xFFF2F8FF),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
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
//                 child: SizedBox(
//                   height: 50,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: const Color(0xFFF2F8FF),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
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
//                 child: SizedBox(
//                   height: 50,
//                   child: TextField(
//                     obscureText: _obscurePassword,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: const Color(0xFFF2F8FF),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
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
//                     'Register',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
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
//               const SizedBox(height: 10),
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
//               const SizedBox(height: 35),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Already have an account?",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Loginview(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'Login',
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
