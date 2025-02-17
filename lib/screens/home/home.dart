import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
                    // Handle logout action
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
          appBar: AppBar(
            title: Text('Home'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  // Handle logout action
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(top: 10, left: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/stone-cover.jpg',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome, $username!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Matches Won: $wins',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            showOpponentSelectionDialog(context);
                          },
                          child: Text(
                            'Play',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle scoreboard button action
                            Navigator.pushNamed(context, "/scoreboard");
                          },
                          child: Text(
                            'Scoreboard',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
