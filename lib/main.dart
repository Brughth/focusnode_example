import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusNode Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;
  late FocusNode _nameNode;

  late TextEditingController _phoneController;
  late FocusNode _phoneNode;

  late TextEditingController _emailController;
  late FocusNode _emailNode;

  @override
  void initState() {
    _nameController = TextEditingController();
    _nameNode = FocusNode();
    _phoneController = TextEditingController();
    _phoneNode = FocusNode();
    _emailController = TextEditingController();
    _emailNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameNode.dispose();
    _phoneController.dispose();
    _phoneNode.dispose();
    _emailController.dispose();
    _emailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'FocusNode Example',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const FlutterLogo(
                size: 150,
                style: FlutterLogoStyle.stacked,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _nameController,
                label: 'Name',
                prefixIcon: const Icon(Icons.person),
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.familyName],
                textInputAction: TextInputAction.next,
                focusNode: _nameNode,
                nextNode: _phoneNode,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _phoneController,
                label: 'Phone',
                prefixIcon: const Icon(Icons.phone),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.telephoneNumber],
                focusNode: _phoneNode,
                nextNode: _emailNode,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _emailController,
                label: 'E-mail',
                prefixIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.send,
                focusNode: _emailNode,
                onSubmitted: (value) => onSubmitted(),
              ),
              const SizedBox(height: 60),
              OutlinedButton(
                onPressed: () => onSubmitted(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Do Something'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onSubmitted() {
    // you can add validation here

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Column(
          children: [
            Text("Name : ${_nameController.text}"),
            Text("Phone: ${_phoneController.text}"),
            Text("Email: ${_emailController.text}"),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.nextNode,
    this.keyboardType,
    this.prefixIcon,
    this.textInputAction,
    this.onSubmitted,
    this.autofillHints,
    required this.label,
  });

  final TextEditingController controller;

  final FocusNode? focusNode;

  final String label;

  final FocusNode? nextNode;

  final TextInputType? keyboardType;

  final Widget? prefixIcon;

  final TextInputAction? textInputAction;

  final Function(String)? onSubmitted;

  final List<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      onSubmitted: nextNode == null
          ? onSubmitted
          : (value) {
              FocusScope.of(context).requestFocus(nextNode);
              if (onSubmitted != null) {
                onSubmitted!(value);
              }
            },
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        label: Text(label),
      ),
    );
  }
}
