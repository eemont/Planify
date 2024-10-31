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


  submitForm() {
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
  }

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
                  onFieldSubmitted: (username) {
                    submitForm();
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
                  onFieldSubmitted: (password) {
                    submitForm();
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    submitForm();
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
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;

  String? password;
  String? confirmPassword;

  submitSignUpForm() {
    if (_formKey.currentState!.validate()) {
      // Call to backend for sign up
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      // Remove the current snack bar after processing
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignedInHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    labelText: 'Full Name',
                  ),
                  validator: (fullName) {
                    if (fullName == null || fullName.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  onFieldSubmitted: (fullName) {
                    submitSignUpForm();
                  },
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: (email) {
                  if (email == null || email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onFieldSubmitted: (email) {
                  submitSignUpForm();
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  password = value;
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 500,
              child: TextFormField(
                obscureText: isHiddenConfirmPassword,
                decoration: InputDecoration(
                  icon: const Icon(Icons.key),

                  //Focus(),
                  suffixIcon: InkWell(
                    onTap: _toggleConfirmPasswordView,
                    child: const Icon(Icons.visibility),
                  ),
                  
                  border: const OutlineInputBorder(),
                  labelText: 'Re-enter Password',
                ),
                validator: (value) {
                  confirmPassword = value;
                  if (value == null || value.isEmpty) {
                    return 'Please re-enter your password';
                  }
                  if (value != password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  submitSignUpForm();
                },
                child: const Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      isHiddenConfirmPassword = !isHiddenConfirmPassword;
    });
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
        //child: const Text('This is the signed in home page'),
      ),
    );
  }
}
