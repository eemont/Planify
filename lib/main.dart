import 'package:flutter/material.dart';
//import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 24, 185, 129)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Planify Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/Planify_Logo_Black copy.png',
              width: 200,
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Log In'),
            ),
            const SizedBox(height: 10), // Spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

// LoginPage widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}
class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    //Form built using _formKey
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Log In'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/Planify_Logo_Black copy.png',
                width: 200,
                height: 200,
              ),
              Container(
                alignment: Alignment.center,
              child: SizedBox(
                width: 500,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  validator: (username) {
                    if(username == null || username.isEmpty) {
                      return 'Please enter valid username';
                    }
                    return null;
                  },
                ),
              ),
              ),

              SizedBox(
                width: 500,
                child: TextFormField(
                  obscureText: isHiddenPassword,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.key),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordView,
                      child: const Icon(Icons.visibility),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (password) {
                    if(password == null || password.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      //CALL TO BACKEND
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      //sleep(const Duration(seconds:2));
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignedInHomePage()),
                      );
                    }
                  },
                  child: const Text('Log In'),
                  ),
                )
          ],
        )
      )
    );
  }


  /*Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Log In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/Planify_Logo_Black copy.png',
              width: 200,
              height: 200,
            )
            
          ],
        ),
        //child: const Text('This is the Log In page'),
      ),
    );
  }*/

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

}

// SignUpPage widget
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Sign Up')),
      body: Center(
        child: const Text('This is the Sign Up page'),
      ),
    );
  }
}

  // SignedInHomePage widget
class SignedInHomePage extends StatelessWidget {
  const SignedInHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Home')),
      body: Center(
        child: const Text('This is the signed in home page'),
      ),
    );
  }
}
