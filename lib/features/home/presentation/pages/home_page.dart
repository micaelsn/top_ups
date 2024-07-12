import 'package:flutter/material.dart';

import '../widgets/tab_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Mobile Recharge',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: Colors.blueGrey),
            ),
          ),
          TabViewWidget(
            tabs: [
              TabItem(
                  action: () {}, title: 'Recharge', widget: const SizedBox()),
              TabItem(
                  action: () {}, title: 'History', widget: const SizedBox()),
            ],
          )
        ],
      ),
    );
  }
}
