import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.httpClient})
      : super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(onAuthenticationStatusChanged);
  }

  final http.Client httpClient;

  Future<void> onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
      case AuthenticationStatus.authenticated:
        final token = await _tryGetToken();
        return emit(AuthenticationState.authenticated(token));
    }
  }

  Future<String> _tryGetToken() async {
    final loginRequest = Uri.https(
        'myhoursdevelopment-api.azurewebsites.net', 'api/Tokens/login');

    final logBody = {
      "grantType": "password",
      "email": "luke.skywalker@myhours.com",
      "password": "Myhours123",
      "clientId": "3d6bdd0e-5ee2-4654-ac53-00e440eed057"
    };

    final loginResponse = await httpClient.post(loginRequest,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json"
        },
        body: jsonEncode(logBody));

    if (loginResponse.statusCode != 200) {
      throw Exception('Login was unsuccessful!');
    }

    final bodyJson = jsonDecode(loginResponse.body) as Map<String, dynamic>;

    if (!bodyJson.containsKey('accessToken')) {
      throw Exception('No token in the response!');
    }

    return bodyJson['accessToken'];
  }
}
