import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:friendlywar/components/AppColors.dart';
import 'package:friendlywar/components/AppInput.dart';
import 'package:friendlywar/components/AppText.dart';
import 'package:friendlywar/components/AppButton.dart';
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/BG.jpg'),
                        opacity: 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            height: MediaQuery.of(context).size.width * 0.8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/Authentication.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        TitleText(text: 'Login'),
                        SizedBox(
                          height: 10,
                        ),
                        AppInput(
                          hintText: 'Username',
                          controller: _usernameController,
                        ),
                        AppInput(
                          hintText: 'Password',
                          controller: _passwordController,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: ParagraphText(
                            text: 'Don’t have an account? Create one',
                          ),
                        ),
                        StoreConnector<AppState, FriendState>(
                          converter: (store) => store.state.friendState,
                          builder: (context, friendState) {
                            return AppButton(
                              text: "Login",
                              onPressed: () {
                                // Handle login action
                                StoreProvider.of<AppState>(context).dispatch(
                                    AuthenticationAction(
                                        username: _usernameController.text,
                                        password: _passwordController.text));
                              },
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
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
