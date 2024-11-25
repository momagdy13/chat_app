import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login User Method
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Map error codes to user-friendly messages
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many login attempts. Please try again later.';
          break;
      default:
          errorMessage = 'An unexpected error occurred. Please try again.';
          break;
      }

      // Emit failure with the error message
      emit(LoginFailure(errorMessage: errorMessage));
    } catch (e) {
      // Handle unexpected errors
      emit(LoginFailure(
          errorMessage: 'Something went wrong. Please try again.'));
    }
  }
}
