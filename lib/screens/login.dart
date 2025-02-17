import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:friendlywar/store/app.state.dart';
import 'package:friendlywar/store/friend/friend.action.dart';
import 'package:friendlywar/store/friend/friend.state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              controller: _usernameController,
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: _passwordController,
            ),
            SizedBox(height: 20),
            StoreConnector<AppState, FriendState>(
              converter: (store) => store.state.friendState,
              builder: (context, friendState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle login action
                      StoreProvider.of<AppState>(context).dispatch(
                          AuthenticationAction(
                              username: _usernameController.text,
                              password: _passwordController.text));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey,
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
              onDidChange: (previous, current) {
                if (!_loggedIn &&
                    current.loading == false &&
                    current.token.isNotEmpty &&
                    current.token != "") {
                  //navigating to the next page
                  setState(() {
                    _loggedIn = true;
                  });
                  Navigator.pushNamed(context, '/home');
                }
                ;
              },
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigate to account creation screen
              },
              child: Text("Don’t have an account? Create one"),
            ),
          ],
        ),
      ),
    );
  }
}
