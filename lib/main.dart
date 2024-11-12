import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// --------------------------------------------------------- App ---------------------------------------------------------

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

// --------------------------------------------------------- Homepage ---------------------------------------------------------

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    // Check if a user is already signed in at startup and print the UID
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid); // Prints the UID if a user is signed in
    }

    // Listening to authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    // Listening to ID token changes
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    // Listening to user changes
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

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

// --------------------------------------------------------- Add People Page ---------------------------------------------------------

class AddPeoplePage extends StatefulWidget {
  const AddPeoplePage({super.key});

  @override
  State<AddPeoplePage> createState() => _AddPeoplePageState();
}

class _AddPeoplePageState extends State<AddPeoplePage> {
  int numberOfPeople = 1;

  void increment() {
    setState(() {
      numberOfPeople++;
    });
  }

  void decrement() {
    setState(() {
      if (numberOfPeople > 1) numberOfPeople--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF98D4B1),
        title: const Text('Add People to Schedule', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFE8F5E9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'How many people are you adding to the schedule?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: decrement,
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  '$numberOfPeople',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: increment,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SelectTimeFramePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF98D4B1),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------- Time Frame Page ---------------------------------------------------------

class SelectTimeFramePage extends StatefulWidget {
  const SelectTimeFramePage({super.key});

  @override
  State<SelectTimeFramePage> createState() => _SelectTimeFramePageState();
}

class _SelectTimeFramePageState extends State<SelectTimeFramePage> {
  String? startTime = "10am";
  String? endTime = "6pm";
  final List<String> times = [
    "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF98D4B1),
        title: const Text('Select Time Frame', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFE8F5E9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose a valid time frame',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: startTime,
                  onChanged: (String? newValue) {
                    setState(() {
                      startTime = newValue;
                    });
                  },
                  items: times.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 20),
                DropdownButton<String>(
                  value: endTime,
                  onChanged: (String? newValue) {
                    setState(() {
                      endTime = newValue;
                    });
                  },
                  items: times.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the "Next" button functionality (e.g., navigate to another page or save selection)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF98D4B1),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------- Login Page ---------------------------------------------------------

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

  // Controllers for email and password input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Log In'),
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
                  controller: _emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: TextFormField(
                controller: _passwordController,
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
                  if (password == null || password.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Attempt to sign in with email and password
                      final UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );

                      // Show success message and navigate to SignedInHomePage
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login successful!')),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignedInHomePage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      // Handle specific Firebase authentication exceptions
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No user found for that email.')),
                        );
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Wrong password provided for that user.')),
                        );
                      }
                    } catch (e) {
                      // Handle any other errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login failed: ${e.toString()}')),
                      );
                    }
                  }
                },
                child: const Text('Log In'),
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
}

// --------------------------------------------------------- Sign Up Page ---------------------------------------------------------

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

  // Controllers for full name, email, and password input
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
            // Full Name Field
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 500,
                child: TextFormField(
                  controller: _fullNameController,
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
                ),
              ),
            ),
            // Email Field
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 500,
                child: TextFormField(
                  controller: _emailController,
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
                ),
              ),
            ),
            // Password Field
            SizedBox(
              width: 500,
              child: TextFormField(
                controller: _passwordController,
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
                  return null;
                },
              ),
            ),
            // Confirm Password Field
            SizedBox(
              width: 500,
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: isHiddenConfirmPassword,
                decoration: InputDecoration(
                  icon: const Icon(Icons.key),
                  suffixIcon: InkWell(
                    onTap: _toggleConfirmPasswordView,
                    child: const Icon(Icons.visibility),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            // Sign-Up Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Create a new user with email and password
                      final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );

                      // Update the display name with the full name
                      await credential.user?.updateDisplayName(_fullNameController.text.trim());

                      // Show success message and navigate to SignedInHomePage
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sign-up successful!')),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignedInHomePage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      // Handle specific Firebase authentication exceptions
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('The password provided is too weak.')),
                        );
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('The account already exists for that email.')),
                        );
                      }
                    } catch (e) {
                      // Catch any other errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sign-up failed: ${e.toString()}')),
                      );
                    }
                  }
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

// --------------------------------------------------------- Signed In Home Page ---------------------------------------------------------

class SignedInHomePage extends StatelessWidget {
  const SignedInHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF98D4B1), // Light green color for AppBar
        title: const Text('Home', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () async {
              // Sign out the user
              await FirebaseAuth.instance.signOut();

              // Show a sign-out confirmation message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Successfully signed out.')),
              );

              // Navigate back to the Login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFE8F5E9), // Light green background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/Planify_Logo_Black copy.png', // Ensure this path is correct
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPeoplePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF98D4B1), // Button color matching AppBar
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Create Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}
