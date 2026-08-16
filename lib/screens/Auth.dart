import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_course/screens/home.dart';
import 'package:supabase_course/services/AuthSupa.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  bool logIn = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),

          children: [
            Text(
              textAlign: TextAlign.center,
              logIn ? 'Log In' : 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 90),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: emailCon,
              decoration: InputDecoration(
                hint: Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: passCon,
              decoration: InputDecoration(
                hint: Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                try {
                  logIn
                      ? await Authsupa().logIn(emailCon.text, passCon.text)
                      : await Authsupa().signUp(emailCon.text, passCon.text);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                } on Exception catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: Text(logIn ? 'Log In' : 'Sign In'),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  logIn = !logIn;
                });
              },
              child: Text(
                logIn ? 'create account' : 'Sign in',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
