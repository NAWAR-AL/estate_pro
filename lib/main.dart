import 'package:estate_pro/features/dashbord/admin/presentation/pages/admin_dashbord_page.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/blog_managment_page.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/message_page.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/properties_managment_page.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/users_managment_page.dart';
import 'package:estate_pro/features/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const  AdminPageFrame(index: 0),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
   
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
