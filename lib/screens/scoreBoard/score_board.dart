import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:friendlywar/components/AppColors.dart';
import 'package:friendlywar/components/AppText.dart';
import 'package:friendlywar/store/app.state.dart';
import 'package:friendlywar/store/friend/friend.state.dart';

class ScoreBoardScreen extends StatelessWidget {
  const ScoreBoardScreen({super.key});

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
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/BG.jpg'),
                          opacity: 0.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    );
                  },
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Username',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Text('Wins',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppColors.cardColor,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                )),
                            Expanded(
                              child: ListView.builder(
                                itemCount: sortedUsers.length,
                                itemBuilder: (context, index) {
                                  final entry = sortedUsers[index];
                                  return Card(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    color:
                                        AppColors.primaryColor.withOpacity(0.2),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
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
