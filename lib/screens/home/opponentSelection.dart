import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:friendlywar/store/app.state.dart';
import 'package:friendlywar/store/friend/friend.state.dart';

void showOpponentSelectionDialog(BuildContext context) {
  TextEditingController _controller = TextEditingController();
  bool _isValidUser = false;
  String _errorMessage = '';

  showDialog(
    context: context,
    builder: (context) {
      return StoreConnector<AppState, FriendState>(
        converter: (store) => store.state.friendState,
        builder: (context, friendState) {
          return StatefulBuilder(
            builder: (context, setState) {
              void validateUser() {
                String enteredUsername = _controller.text.trim();
                bool _user = friendState.users
                    .where((item) => item["username"] == enteredUsername)
                    .isNotEmpty;
                if (_user) {
                  setState(() {
                    _isValidUser = true;
                    _errorMessage = '';
                  });
                } else {
                  setState(() {
                    _isValidUser = false;
                    _errorMessage = 'User not found';
                  });
                }
              }

              return AlertDialog(
                title: Text('Select Opponent'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Opponent Username',
                        errorText:
                            _errorMessage.isNotEmpty ? _errorMessage : null,
                      ),
                      onChanged: (value) => validateUser(),
                    ),
                    SizedBox(height: 10),
                    if (_isValidUser)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/play', arguments: {
                            "opponent": friendState.users.where(
                                (item) => item["username"] == _controller.text)
                          });
                        },
                        child: Text('Proceed to Play'),
                      ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}
