import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();

  bool isHidden = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(32),
        children: <Widget>[
          buildEmail(),
          const SizedBox(
            height: 24,
          ),
          buildPassword(),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('Email: ${emailController.text}');
                print('Password: ${passwordController.text}');
              }
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }

  Widget buildEmail() => TextFormField(
        controller: emailController,
        validator: (value) {
          if (value == null|| value.isEmpty) {
            return 'É obrigatório informar o e-mail.';
          } 
          
          if (!value.contains('@')) {
            return 'O formato do e-mail é inválido.';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'name@example.com',
          labelText: 'E-mail',
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.email),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              emailController.clear();
            },
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      );

  Widget buildPassword() => TextFormField(
        controller: passwordController,
        validator: (value) {
          if (value == null|| value.isEmpty) {
            return 'É obrigatório informar a senha.';
          }
          
          if (value.length < 6) {
            return 'A senha deve ter pelo menos 6 dígitos.';
          }
          return null;
        },
        obscureText: isHidden,
        decoration: InputDecoration(
          hintText: 'Your Password...',
          labelText: 'Password',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (isHidden) {
                isHidden = false;
                } else {
                  isHidden = true;
                }
              });
            },
            icon: isHidden ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined)
          )
        ),
      );
}