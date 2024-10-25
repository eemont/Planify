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

// --------------------------------------------------------- Home Page ---------------------------------------------------------

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

// --------------------------------------------------------- Login Page ---------------------------------------------------------

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
                        if (username == null || username.isEmpty) {
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //CALL TO BACKEND
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );

                        //sleep(const Duration(seconds:2));
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignedInHomePage()),
                        );
                      }
                    },
                    child: const Text('Log In'),
                  ),
                )
              ],
            )));
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

// --------------------------------------------------------- SignUp Page ---------------------------------------------------------

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
                  if (email == null ||
                      email.isEmpty ||
                      !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                    return 'Please enter a valid email';
                  }
                  return null;
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
                  if (_formKey.currentState!.validate()) {
                    // Call to backend for sign up
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );

                    // Remove the current snack bar after processing
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignedInHomePage()),
                    );
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

// --------------------------------------------------------- SignedInHome Page ---------------------------------------------------------

class SignedInHomePage extends StatelessWidget {
  const SignedInHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Planify_Logo_Black copy.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(
                height: 20), // Add some spacing between the image and text
            const SizedBox(
                height: 20), // Add some space between the text and the button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddSchedulePage()),
                );
              },
              child: const Text('Create Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------- # of People Page ---------------------------------------------------------

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  int peopleCount = 1; // Initial count of people

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add People to Schedule'),
      ),
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
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (peopleCount > 1) {
                        peopleCount--; // Decrease count
                      }
                    });
                  },
                ),
                Text(
                  '$peopleCount', // Display the current count
                  style: const TextStyle(fontSize: 24),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      peopleCount++; // Increase count
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next page (you can replace this with your desired action)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TimeFramePage()),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------- TimeFrame Page ---------------------------------------------------------

class TimeFramePage extends StatefulWidget {
  const TimeFramePage({super.key});

  @override
  _TimeFramePageState createState() => _TimeFramePageState();
}

class _TimeFramePageState extends State<TimeFramePage> {
  final List<String> times = [
    '6am',
    '7am',
    '8am',
    '9am',
    '10am',
    '11am',
    '12pm',
    '1pm',
    '2pm',
    '3pm',
    '4pm',
    '5pm',
    '6pm',
    '7pm',
    '8pm',
    '9pm',
    '10pm',
    '11pm',
    '12am'
  ];

  String? startTime;
  String? endTime;
  String? errorMessage;

  // Validate the time selection
  bool _isValidTimeFrame(String start, String end) {
    int startIndex = times.indexOf(start);
    int endIndex = times.indexOf(end);
    return startIndex < endIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Select Time Frame'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose a valid time frame',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Dropdown for start time
            DropdownButton<String>(
              value: startTime,
              hint: const Text('Start Time'),
              items: times.map((String time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  startTime = newValue;
                  errorMessage = null; // Clear error when changing values
                });
              },
            ),
            const SizedBox(height: 20),
            // Dropdown for end time
            DropdownButton<String>(
              value: endTime,
              hint: const Text('End Time'),
              items: times.map((String time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  endTime = newValue;
                  errorMessage = null; // Clear error when changing values
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (startTime != null && endTime != null) {
                  if (_isValidTimeFrame(startTime!, endTime!)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NextPage()),
                    );
                  } else {
                    setState(() {
                      errorMessage =
                          'Invalid time frame: $startTime to $endTime';
                    });
                  }
                } else {
                  setState(() {
                    errorMessage = 'Please select both start and end times';
                  });
                }
              },
              child: const Text('Next'),
            ),
            const SizedBox(height: 20),
            if (errorMessage != null) // Display error message if any
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for the next page
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Next Page'),
      ),
      body: Center(
        child: const Text('You have successfully selected a valid time frame!'),
      ),
    );
  }
}
