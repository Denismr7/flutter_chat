import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm();

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  final Map<String, String> _authData = {
    'email': '',
    'username': '',
    'password': ''
  };
  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hey ${_authData['username']}!')));
    }
  }

  void _onSaveTextField(String? value, String inputName) {
    _authData[inputName] = value ?? "";
  }

  String? _validateInput(String? value, String inputName) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    // Specific validation
    switch (inputName) {
      case 'email':
        if (!value.contains('@')) {
          return 'Invalid email';
        }
        break;
      case 'password':
        if (value.length < 7) {
          return 'Password must be at least 7 characters long';
        }
        break;
      case 'username':
        if (value.length < 4) {
          return 'Username must be at least 7 characters long';
        }
        break;
      default:
        break;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      onSaved: (value) => _onSaveTextField(value, 'email'),
                      validator: (val) => _validateInput(val, 'email'),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        onSaved: (value) => _onSaveTextField(value, 'username'),
                        validator: (val) => _validateInput(val, 'username'),
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      onSaved: (value) => _onSaveTextField(value, 'password'),
                      obscureText: true,
                      validator: (val) => _validateInput(val, 'password'),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _onSubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I have an account'),
                      style: TextButton.styleFrom(
                        onSurface: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
