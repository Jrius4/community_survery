import 'package:flutter/material.dart';
import '../services/hive_service.dart';
import '../models/survey.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Future<void> onRefresh() async {
    await HiveService.getAllSurveys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surveys'),
      ),
      body: RefreshIndicator(
          child: FutureBuilder<List<Survey>>(
            future: HiveService.getAllSurveys(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No surveys available'));
              }

              final surveys = snapshot.data!;
              return ListView.builder(
                itemCount: surveys.length,
                itemBuilder: (context, index) {
                  final survey = surveys[index];
                  return ListTile(
                    title: Text(survey.title),
                    subtitle: Text(survey.description),
                    trailing: Icon(
                      survey.isCompleted
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: survey.isCompleted ? Colors.green : Colors.grey,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/survey',
                          arguments: survey);
                    },
                  );
                },
              );
            },
          ),
          onRefresh: onRefresh),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/survey');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
