import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:friendlywar/components/AppColors.dart';
import 'package:friendlywar/components/AppText.dart';
import 'package:friendlywar/store/app.state.dart';
import 'package:friendlywar/store/friend/friend.action.dart';
import 'package:friendlywar/store/friend/friend.state.dart';
import 'package:sse_client/sse_client.dart';

final baseUrl = dotenv.env['BASE_URL'];

class PlayScreen extends StatefulWidget {
  final dynamic opponent;
  const PlayScreen({super.key, required this.opponent});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late SseClient _sseClient;
  StreamSubscription<String>? _sseSubscription; // Add this

  Map<String, dynamic> _matchResults = {};

  @override
  void initState() {
    super.initState();

    _sseClient = SseClient.connect(Uri.parse("${baseUrl}friend/events/"));

    // Listen to SSE stream
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sseClient.stream?.listen((event) {
        final data = jsonDecode(event);
        if (data.isNotEmpty) {
          // Dispatch action to update matches
          StoreProvider.of<AppState>(context).dispatch(MatchLoadingAction());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FriendState>(
      converter: (store) => store.state.friendState,
      builder: (context, friendState) {
        final dynamic opponent = widget.opponent.first;
        final String opponentUserName = opponent['username'];
        final String homeUsername = friendState.userName;
        final List<dynamic> matches = List.from(friendState.matches);

        // Compute win counts
        final headToHead = matches.where((match) =>
            (match["team1"] == homeUsername &&
                match["team2"] == opponentUserName) ||
            (match["team1"] == opponentUserName &&
                match["team2"] == homeUsername));
        final int homeWin =
            headToHead.where((match) => match["winner"] == homeUsername).length;
        final int opponentWin = headToHead
            .where((match) => match["winner"] == opponentUserName)
            .length;

        return Scaffold(
          appBar: AppBar(title: Text('Match in Progress')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPlayerInfo(
                          homeUsername, 'assets/images/avatar1.jpg', homeWin),
                      Text('VS',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      _buildPlayerInfo(opponentUserName,
                          'assets/images/avatar2.jpg', opponentWin),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              _buildLoseMatchButton(context, opponentUserName),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlayerInfo(String username, String avatar, int wins) {
    return Column(
      children: [
        CircleAvatar(radius: 50, backgroundImage: AssetImage(avatar)),
        SizedBox(height: 10),
        Text(username,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(
          "$wins",
          style: TextStyle(fontSize: 40, color: AppColors.primaryColor),
        ),
        ParagraphText(text: 'Wins'),
      ],
    );
  }

  Widget _buildLoseMatchButton(BuildContext context, String opponent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => _confirmLostMatch(context, opponent),
          child: Text('Lost Match',
              style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }

  void _confirmLostMatch(BuildContext context, String opponent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure you lost the match?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(MatchLosingAction(opponent: opponent));
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
