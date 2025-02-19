import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:friendlywar/store/app.state.dart';
import 'package:friendlywar/store/friend/friend.state.dart';

class ScoreBoardScreen extends StatelessWidget {
  const ScoreBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FriendState>(
        converter: (store) => store.state.friendState,
        builder: (context, friendState) {
          if (friendState.loading) {
            return Scaffold(
              appBar: AppBar(title: Text('Scoreboard')),
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Process user match wins
          final Map<String, int> userWins = {};
          for (var match in friendState.matches) {
            userWins[match["winner"]] = (userWins[match["winner"]] ?? 0) + 1;
          }

          final List<MapEntry<String, int>> sortedUsers = userWins.entries
              .toList()
            ..sort((a, b) => b.value.compareTo(a.value));

          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.5,
                      image: AssetImage('assets/images/BG.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    AppBar(
                      title: Text('Scoreboard'),
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Leaderboard',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemCount: sortedUsers.length,
                                itemBuilder: (context, index) {
                                  final entry = sortedUsers[index];
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade300)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          entry.key,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          entry.value.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
