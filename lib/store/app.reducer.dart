import './friend/friend.reducer.dart';

import './app.state.dart';
AppState appReducer(AppState state, action) => AppState(friendState: friendReducer(state.friendState, action),);
	