import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.icon,
    required this.placeHolder,
    this.onChange,
    this.validator,
    this.isPassword = false,
  });

  final IconData icon;
  final String placeHolder;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  String? _errorText;
  bool _isValid = false;
  final TextEditingController _controller = TextEditingController();

  // Method to validate the input field
  String? _validateInput(String? value) {
    final error = widget.validator?.call(value);
    setState(() {
      _errorText = error;
      _isValid = error == null;
    });
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          // Use the built-in validator, which shows an error message under the field
          onChanged: (value) {
            // Validate the input and update the error text in real-time
            _validateInput(value);

            // Trigger onChange callback if the input is valid
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
          },
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.placeHolder,
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.black54,
            prefixIcon: Icon(
              widget.icon,
              color: Colors.white70,
            ),
            // Password visibility toggle button
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: _isValid ? Colors.green : Colors.grey,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: _isValid ? Colors.green : Colors.red,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            // Error message style
            errorStyle: const TextStyle(height: 0),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        // Display custom validation error below the field
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              _errorText!,
              style: const TextStyle(
                color: Color.fromARGB(255, 174, 12, 0),
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
