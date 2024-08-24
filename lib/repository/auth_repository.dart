// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:docs_clone/models/error_model.dart';
import 'package:docs_clone/models/user_model.dart';
import 'package:docs_clone/repository/local_storage_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:riverpod/riverpod.dart';

// this will allow us to use this class easily and test it

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
    localStorage: LocalStorage(),
  ),
);
// to modify values we use state provider
final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorage _localStorage;
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
    required LocalStorage localStorage,
  })  : _googleSignIn = googleSignIn,
        _client = client,
        _localStorage = localStorage;

  final String host = dotenv.get("API_HOST", fallback: "");
  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occured',
      data: null,
    );
    try {
      print('Sign in with Google invoked');
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
          email: user.email,
          name: user.displayName!,
          profilePic: user.photoUrl ?? '',
          uid: '',
          token: '',
        );
        var res = await _client.post(Uri.parse('$host/docs/signup'),
            body: userAcc.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });
        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );
            log('User signed in successfully');

            _localStorage.setToken(jsonDecode(res.body)['token']);
            print('Token set ${newUser.token}');
            error = ErrorModel(error: null, data: newUser);
            break;

          default:
            print('Error signing in');
        }
      }
    } catch (e) {
      log(e.toString());
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    try {
      log("Get token invoked");
      String? token = await _localStorage.getToken();

      if (token != null) {
        var res = await _client.get(Uri.parse('$host/'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        switch (res.statusCode) {
          case 200:
            final newUser = UserModel.fromJson(
              jsonEncode(
                jsonDecode(res.body)['user'],
              ),
            ).copyWith(token: token);
            error = ErrorModel(error: null, data: newUser);
            _localStorage.setToken(newUser.token);
            break;
        }
      }
      log('Token: $token');
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
      log(e.toString());
    }
    return error;
  }

  void signOut() async {
    await _googleSignIn.signOut();
    _localStorage.setToken('');
  }
}
