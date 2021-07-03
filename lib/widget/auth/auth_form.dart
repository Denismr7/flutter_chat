import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm();

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 12),
                ElevatedButton(onPressed: () {}, child: const Text('Login')),
                TextButton(
                  onPressed: () {},
                  child: const Text('Create new account'),
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
