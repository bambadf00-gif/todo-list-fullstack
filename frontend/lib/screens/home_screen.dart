
import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  final int userId;

  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();

  late Future<dynamic> tasksFuture;

  @override
  void initState() {
    super.initState();
    tasksFuture = apiService.getTasks(widget.userId);
  }

  void refreshTasks() {
    setState(() {
      tasksFuture = apiService.getTasks(widget.userId);
    });
  }

  // MODAL D'AJOUT
  void _showAddTaskModal(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Nouvelle tâche",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Titre",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final title = titleController.text.trim();
                  final description = descriptionController.text.trim();

                  if (title.isEmpty) return;

                  await apiService.createTask(
                    widget.userId,
                    title,
                    description,
                    false,
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                    refreshTasks();
                  }
                },
                child: const Text("Ajouter"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MODAL DE MODIFICATION
  void _showEditTaskModal(
    BuildContext context,
    int taskId,
    String oldTitle,
    String oldDescription,
    bool status,
  ) {
    final titleController = TextEditingController(text: oldTitle);
    final descriptionController =
        TextEditingController(text: oldDescription);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Modifier la tâche",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Titre",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final title = titleController.text.trim();
                  final description =
                      descriptionController.text.trim();

                  if (title.isEmpty) return;

                  await apiService.updateTask(
                    taskId,
                    title,
                    description,
                    status,
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                    refreshTasks();
                  }
                },
                child: const Text("Enregistrer"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SUPPRESSION
  Future<void> _deleteTask(int taskId) async {
    try {
      await apiService.deleteTask(taskId);
      refreshTasks();
    } catch (e) {
      debugPrint("Erreur : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Mes tâches",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder(
        future: tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Erreur de chargement"),
            );
          }

          final tasks = snapshot.data;

          if (tasks == null || tasks.isEmpty) {
            return const Center(
              child: Text(
                "Aucune tâche pour le moment",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),

                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),

                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE3EEFF),
                    child: Icon(
                      Icons.task_alt,
                      color: Colors.blue,
                    ),
                  ),

                  title: Text(
                    tasks[index][1].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  subtitle: Text(
                    tasks[index][2].toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          _showEditTaskModal(
                            context,
                            tasks[index][0] as int,
                            tasks[index][1].toString(),
                            tasks[index][2].toString(),
                            tasks[index][4] == 1 ||
                                tasks[index][4] == true,
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _deleteTask(tasks[index][0] as int);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () => _showAddTaskModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
