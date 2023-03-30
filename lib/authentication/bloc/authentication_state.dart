part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.token = '',
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(String token)
      : this._(status: AuthenticationStatus.authenticated, token: token);

  final AuthenticationStatus status;
  final String token;

  @override
  List<Object> get props => [status, token];
}
