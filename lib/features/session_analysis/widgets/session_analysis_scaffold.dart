import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/features/session_analysis/widgets/analysis_navigation.dart';

class SessionAnalysisScaffold extends StatelessWidget {
  const SessionAnalysisScaffold(
    this.body, {
    this.floatingActionButton,
    super.key,
  });

  final Widget body;

  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(
        context,
        title: "Session Analysis",
        actions: [PageComponentFactory.settingsNavigationButton()],
      ),
      body: body,
      bottomNavigationBar: const AnalysisNavigation(),
      floatingActionButton: floatingActionButton,
      fabLocation: FloatingActionButtonLocation.centerDocked,
      //fabLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}
