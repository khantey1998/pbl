import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {

	static final String endPoint = '/api/auth/login';

	// Keys to store and fetch data from SharedPreferences
	static final String authTokenKey = 'access_token';
	static final String userIdKey = 'id';
	static final String nameKey = 'name';
	static final String emailKey = 'email';

	static String getToken(SharedPreferences prefs) {
		return prefs.getString(authTokenKey);
	}

	static insertDetails(SharedPreferences prefs, var response) {
		prefs.setString(authTokenKey, response['access_token']);
		var user = response['user'];
		prefs.setInt(userIdKey, user['id']);
		prefs.setString(nameKey, user['name']);
		prefs.setString(emailKey, user['email']);
	}
	
}