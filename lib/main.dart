import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'view/history_widget.dart';
import 'view/lottery_widget.dart';

import 'view/settings_widget.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.emoji_emotions_outlined),
          title: const Text('抽選くん'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SettingsWidget(),
              SizedBox(height: 32),
              LotteryWidget(),
              SizedBox(height: 32),
              HistoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
