import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(ReadyToAuthenticateState()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(ReadyToAuthenticateState());

        final firebaseInstance = FirebaseAuth.instance;

        try {
          if (email == null) {
            emit(EmptyFieldsAuthenticationState());
          } else if (password == null) {
            emit(EmptyFieldsAuthenticationState());
          } else {
            emit(LoadingAuthenticationState());
            await firebaseInstance.signInWithEmailAndPassword(
              email: email!,
              password: password!,
            );
            emit(SuccessfulLoginState());
          }
        } on FirebaseAuthException catch (firebaseException) {
          switch (firebaseException.code) {
            case 'invalid-email':
              emit(WrongEmailAuthenticationState());
            case 'wrong-password':
              emit(WrongPasswordAuthenticationState());
            case 'invalid-credential':
              emit(ErrorAuthenticateState(
                  errorMessage: 'invalid e-mail or password'));
            default:
              emit(ErrorAuthenticateState(
                  errorMessage: firebaseException.message ?? ''));
          }
        } catch (e) {
          emit(
            ErrorAuthenticateState(
              errorMessage: e.toString(),
            ),
          );
        }
      },
    );
    on<RegisterEvent>((event, emit) async {
      final firebaseInstance = FirebaseAuth.instance;

      try {
        if (email == null) {
          emit(EmptyFieldsAuthenticationState());
        } else if (password == null) {
          emit(EmptyFieldsAuthenticationState());
        } else {
          emit(LoadingAuthenticationState());
          await firebaseInstance.createUserWithEmailAndPassword(
            email: email!,
            password: password!,
          );
          emit(SuccessfulRegistrationState());
        }
      } on FirebaseAuthException catch (firebaseException) {
        switch (firebaseException.code) {
          case 'email-already-in-use':
            emit(EmailAlreadyInUseAuthenticationState());
          case 'weak-password':
            emit(
              WeakPasswordAuthenticationState(),
            );
        }
      } catch (e) {
        emit(ErrorAuthenticateState(
          errorMessage: e.toString(),
        ));
      }
    });
  }

  String? email;
  String? password;
}

sealed class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {}

class RegisterEvent extends AuthenticationEvent {}

sealed class AuthenticationState {}

class LoadingAuthenticationState extends AuthenticationState {}

class WrongPasswordAuthenticationState extends AuthenticationState {}

class WrongEmailAuthenticationState extends AuthenticationState {}

class EmailAlreadyInUseAuthenticationState extends AuthenticationState {}

class WeakPasswordAuthenticationState extends AuthenticationState {}

class EmptyFieldsAuthenticationState extends AuthenticationState {}

class ReadyToAuthenticateState extends AuthenticationState {}

class ErrorAuthenticateState extends AuthenticationState {
  ErrorAuthenticateState({required this.errorMessage});

  final String errorMessage;
}

class SuccessfulRegistrationState extends AuthenticationState {}

class SuccessfulLoginState extends AuthenticationState {}
