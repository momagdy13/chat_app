import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterCubitInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Map error codes to user-friendly messages
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for this email.';
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

      emit(RegisterFailure(errorMessage: errorMessage));
    } catch (e) {
      // Handle unexpected errors
      emit(RegisterFailure(
          errorMessage: 'Something went wrong. Please try again.'));
    }
  }
}
