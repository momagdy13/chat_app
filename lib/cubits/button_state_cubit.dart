import 'package:bloc/bloc.dart';

class ButtonStateCubit extends Cubit<bool> {
  ButtonStateCubit() : super(false); // Button starts as disabled.

  // Method to update button state
  void updateButtonState(String? email, String? password) {
    emit((email != null && email.isNotEmpty) &&
        (password != null && password.length >= 6));
  }
  // Optional: Reset button state (e.g., when clearing fields)
  void resetButtonState() {
    emit(false);
  }
}
