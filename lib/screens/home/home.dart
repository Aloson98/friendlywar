import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:friendlywar/components/AppColors.dart';
import 'package:friendlywar/components/AppText.dart';
import 'package:friendlywar/components/appButton.dart';
import 'package:friendlywar/screens/home/opponentSelection.dart';
import 'package:friendlywar/store/app.state.dart';
import 'package:friendlywar/store/friend/friend.action.dart';
import 'package:friendlywar/store/friend/friend.state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FriendState>(
        converter: (store) => store.state.friendState,
        onInit: (store) {
          store.dispatch(MatchLoadingAction());
          store.dispatch(UsersListingAction());
        },
        builder: (context, friendState) {
          if (friendState.loading) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Home'),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Compute matches won
          final String username = friendState.userName;
          final int wins = friendState.matches
              .where((match) => match["winner"] == username)
              .length;

          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text('Home'),
              ),
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
                          SafeArea(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Card(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: EdgeInsets.only(top: 10, left: 20),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          'assets/images/playing.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TitleText(text: 'Welcome, $username!'),
                                  Text(
                                    "$wins",
                                    style: TextStyle(
                                        fontSize: 70,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.buttonColor),
                                  ),
                                  ParagraphText(
                                    text: 'Matches Won',
                                    color: AppColors.primaryColor,
                                  ),
                                  Column(
                                    children: [
                                      AppButton(
                                        text: 'Play',
                                        onPressed: () {
                                          showOpponentSelectionDialog(context);
                                        },
                                      ),
                                      AppButton(
                                        text: 'ScoreBoard',
                                        onPressed: () {
                                          // Handle scoreboard button action
                                          Navigator.pushNamed(
                                              context, "/scoreboard");
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ));
        });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                // Handle logout action
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class RoleButton extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback onTap;

  const RoleButton({
    Key? key,
    required this.label,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
