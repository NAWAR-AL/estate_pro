import 'package:flutter/material.dart';

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blog Details")),
      body: const Center(child: Text("BlogDetailsPage")),
    );
  }
}
