import 'package:chat/models/auth_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  const AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  void _submit() {
    final bool _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_isValid) {
      widget.onSubmit(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if(_authData.isSignup)
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _authData.name,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if(value == null || value.trim().length < 4) {
                      return 'Nome deve ter no mínimo 4 caracteres';
                    }

                    return null;
                  },
                  onChanged: (value) => _authData.name = value,
                ),
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'E-mail',
                  ),
                  validator: (value) {
                    if(value == null || !value.contains('@')) {
                      return 'Forneça um e-mail válido';
                    }

                    return null;
                  },
                  onChanged: (value) => _authData.email = value,
                ),
                TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: 'Senha',
                  ),
                  validator: (value) {
                    if(value == null || value.trim().length < 7) {
                      return 'A senha deve ter no mínimo 7 caracteres';
                    }

                    return null;
                  },
                  onChanged: (value) => _authData.password = value,
                ),
                if(_authData.isSignup)
                TextFormField(
                  key: ValueKey('confirmPassword'),
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key_outlined),
                    labelText: 'Confirmar Senha',
                  ),
                  validator: (value) {
                    if(value != _authData.password) {
                      return 'Você inseriu senhas diferentes';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 12),
                RaisedButton(
                  child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                  onPressed: _submit,
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      _authData.toggleMode();
                    });
                  },
                  child: Text(_authData.isLogin ? 'Criar uma nova conta' : 'Entrar em uma conta existente'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
