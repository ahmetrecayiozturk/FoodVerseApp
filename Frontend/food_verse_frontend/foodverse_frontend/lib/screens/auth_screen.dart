import 'package:flutter/material.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/userprofile_screen.dart';
import 'package:foodverse_frontend/services/auth_service.dart' as auth;

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        notificationPredicate: (notification) => true,
        title: const Text(''),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.red,
              Colors.red,
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/foodverse2.png'),
            SizedBox(height: 10.0), // Boşluk burada eklendi
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: _buildTextField(
                _emailController,
                'E-mail',
              ),
            ),
            SizedBox(height: 10.0), // Boşluk burada eklendi
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: _buildTextField(_passwordController, 'Password',
                  isPassword: true),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.orange),
              ),
            SizedBox(height: 25.0), // Boşluk burada eklendi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildElevatedButton(
                  'Register',
                  Colors.orange,
                  Colors.orange,
                  () async {
                    bool success = await auth.AuthService().registerUser(
                        _emailController.text, _passwordController.text);
                    if (success) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddorFilterPage(
                                  user: User(
                                      email: _emailController.text,
                                      password: _passwordController.text))));
                    } else {
                      setState(() {
                        _errorMessage =
                            'Registration failed. Please try again.';
                      });
                    }
                  },
                ),
                _buildElevatedButton(
                  '    Login    ',
                  Colors.orange,
                  Colors.orange,
                  () async {
                    bool success = await auth.AuthService().loginUser(
                        _emailController.text, _passwordController.text);
                    if (success) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileScreen(
                                  user: User(
                                      email: _emailController.text,
                                      password: _passwordController.text))));
                    } else {
                      setState(() {
                        _errorMessage =
                            'There is an error in login, please check username or password.';
                      });
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    IconData icon;
    if (label == 'E-mail') {
      icon = Icons.person_2;
    } else {
      icon = Icons.key;
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon), // icon'u burada kullanabilirsiniz
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildElevatedButton(
      String text, Color color, Color highlight, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(text),
    );
  }
}

/*-------------------------çalışan2-----------------------------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/userprofile_screen.dart';
import 'package:foodverse_frontend/services/auth_service.dart' as auth;

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        notificationPredicate: (notification) => true,
        title: const Text(''),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.orange.shade200,
              Colors.deepOrange.shade400,
            ],
          ),
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/foodverse2.png'),
            SizedBox(height: 10.0), // Boşluk burada eklendi
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: _buildTextField(
                _emailController,
                'E-mail',
              ),
            ),
            SizedBox(height: 10.0), // Boşluk burada eklendi
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: _buildTextField(_passwordController, 'Password',
                  isPassword: true),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 25.0), // Boşluk burada eklendi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildElevatedButton(
                  'Register',
                  Colors.red,
                  Colors.red,
                  () async {
                    bool success = await auth.AuthService().registerUser(
                        _emailController.text, _passwordController.text);
                    if (success) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddorFilterPage(
                                  user: User(
                                      email: _emailController.text,
                                      password: _passwordController.text))));
                    } else {
                      setState(() {
                        _errorMessage =
                            'Registration failed. Please try again.';
                      });
                    }
                  },
                ),
                _buildElevatedButton(
                  '    Login    ',
                  Colors.red,
                  Colors.red,
                  () async {
                    bool success = await auth.AuthService().loginUser(
                        _emailController.text, _passwordController.text);
                    if (success) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileScreen(
                                  user: User(
                                      email: _emailController.text,
                                      password: _passwordController.text))));
                    } else {
                      setState(() {
                        _errorMessage =
                            'There is an error in login, please check username or password.';
                      });
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    IconData icon;
    if (label == 'E-mail') {
      icon = Icons.person_2;
    } else {
      icon = Icons.key;
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon), // icon'u burada kullanabilirsiniz
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildElevatedButton(
      String text, Color color, Color highlight, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(text),
    );
  }
}
*/




/*--------------------çalışan1-----------------------------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/userprofile_screen.dart';
import 'package:foodverse_frontend/services/auth_service.dart' as auth;

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        notificationPredicate: (notification) => true,
        title: const Text(''),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.orange.shade200,
              Colors.deepOrange.shade400,
            ],
          ),
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/foodverse2.png'),
            _buildTextField(
              _emailController,
              'E-mail',
            ),
            SizedBox(width: 10.0),
            _buildTextField(_passwordController, 'Password', isPassword: true),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildElevatedButton(
                  'Register',
                  Colors.red,
                  Colors.red,
                  () async {
                    bool success = await auth.AuthService().registerUser(
                        _emailController.text, _passwordController.text);
                    if (success) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddorFilterPage(
                                  user: User(
                                      email: _emailController.text,
                                      password: _passwordController.text))));
                    } else {
                      setState(() {
                        _errorMessage =
                            'Registration failed. Please try again.';
                      });
                    }
                  },
                ),
                _buildElevatedButton(
                  '    Login    ',
                  Colors.red,
                  Colors.red,
                  () async {
                    bool success = await auth.AuthService().loginUser(
                        _emailController.text, _passwordController.text);
                    if (success) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileScreen(
                                  user: User(
                                      email: _emailController.text,
                                      password: _passwordController.text))));
                    } else {
                      setState(() {
                        _errorMessage =
                            'There is an error in login, please check username or password.';
                      });
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

/*
  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(
          if(label == 'E-mail'){
              Icons.person_2
          }
          else{
              Icon(Icons.key)
          }),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: isPassword,
    );
  }
*/
  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    // Icon'u belirlemek için if-else yapısını dışarıda kullanın
    IconData icon;
    if (label == 'E-mail') {
      icon = Icons.person_2;
    } else {
      icon = Icons.lock;
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon), // icon'u burada kullanabilirsiniz
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildElevatedButton(
      String text, Color color, Color highlight, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(text),
    );
  }
}

*/