import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('66a492c8001b7290a7ee')
      .setSelfSigned(status: true);
  Account account = Account(client);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(account: account),
  ));
}

class MyApp extends StatefulWidget {
  
  final Account account;

  const MyApp({super.key, required this.account});

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  
  models.User? loggedInUser;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String errorMessage = '';

  Future<void> login(String email, String password) async {
    try {
      await widget.account.createEmailPasswordSession(email: email, password: password);
      final user = await widget.account.get();
      setState(() {
        loggedInUser = user;
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Login failed: $e';
      });
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      await widget.account.create(
        userId: ID.unique(), email: email, password: password, name: name);
      await login(email, password);
    } catch (e) {
      setState(() {
        errorMessage = 'Registration failed: $e';
      });
    }
  }

  Future<void> logout() async {
    try {
      await widget.account.deleteSession(sessionId: 'current');
      setState(() {
        loggedInUser = null;
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Logout failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AppWrite Auth Example'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      loggedInUser != null
                          ? 'Logged in as ${loggedInUser!.name}'
                          : 'Not logged in',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            login(emailController.text, passwordController.text);
                          },
                          child: const Text('Login'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            register(emailController.text, passwordController.text, nameController.text);
                          },
                          child: const Text('Register'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            logout();
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
