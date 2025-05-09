import 'package:dojo_flutter/constants/constants.dart';
import 'package:dojo_flutter/constants/routes.dart';
import 'package:dojo_flutter/feature/auth/presentation/controller/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final AuthenticationBloc _authenticationBloc;
  AuthenticationAction _currentAction = AuthenticationAction.login;

  @override
  void initState() {
    super.initState();

    _authenticationBloc = context.read<AuthenticationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Measures.xxLarge,
          children: [
            Image.asset(AssetConstants.logoImage),
            TextField(
              decoration: InputDecoration(
                  helperText: 'E-mail', icon: Icon(Icons.alternate_email)),
              onChanged: (String? newValue) {
                _authenticationBloc.email = newValue;
              },
            ),
            TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  helperText: 'Password', icon: Icon(Icons.password)),
              onChanged: (String? newValue) {
                _authenticationBloc.password = newValue;
              },
            ),
            OutlinedButton(
              onPressed: () {
                _authenticationBloc.add(
                  (_currentAction == AuthenticationAction.login)
                      ? LoginEvent()
                      : RegisterEvent(),
                );
              },
              child: Text(
                (_currentAction == AuthenticationAction.login)
                    ? 'Login'
                    : 'Register',
              ),
            ),
            (_currentAction == AuthenticationAction.login)
                ? Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text('Don\'t have an account? '),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _currentAction = AuthenticationAction.register;
                          });
                        },
                        child: Text('register'),
                      ),
                    ],
                  )
                : Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text('Already have an account? '),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _currentAction = AuthenticationAction.login;
                          });
                        },
                        child: Text('login'),
                      ),
                    ],
                  ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: _authenticationBloc,
              builder: (BuildContext context, AuthenticationState state) {
                if (state is LoadingAuthenticationState) {
                  return CircularProgressIndicator();
                } else if (state is WrongPasswordAuthenticationState) {
                  return ErrorMessage(message: 'Wrong password');
                } else if (state is WrongEmailAuthenticationState) {
                  return ErrorMessage(message: 'Invalid E-mail');
                } else if (state is EmailAlreadyInUseAuthenticationState) {
                  return ErrorMessage(message: 'E-mail already in use');
                } else if (state is WeakPasswordAuthenticationState) {
                  return ErrorMessage(message: 'password is too weak');
                } else if (state is EmptyFieldsAuthenticationState) {
                  return ErrorMessage(message: 'all fields are required');
                } else if (state is ErrorAuthenticateState) {
                  return ErrorMessage(message: state.errorMessage);
                } else if (state is SuccessfulLoginState) {
                  context.go(Routes.home);
                  return Container();
                } else if (state is SuccessfulRegistrationState) {
                  context.go(Routes.login);
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Measures.medium),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}

enum AuthenticationAction {
  login,
  register,
}
