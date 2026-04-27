import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Task {
  final String title;
  String status;

  Task({required this.title, required this.status});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Task> tasks = [
    Task(title: 'Estudiar Flutter', status: 'To do'),
    Task(title: 'Crear interfaz principal', status: 'In progress'),
    Task(title: 'Entregar ejercicio', status: 'Done'),
    Task(title: 'Revisar el código', status: 'To do'),
    Task(title: 'Probar la aplicación', status: 'In progress'),
  ];

  void moveTask(Task task) {
    setState(() {
      if (task.status == 'To do') {
        task.status = 'In progress';
      } else if (task.status == 'In progress') {
        task.status = 'Done';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de tareas',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Organización de tareas'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskColumn(title: 'To do', tasks: tasks, onMove: moveTask),
              TaskColumn(title: 'In progress', tasks: tasks, onMove: moveTask),
              TaskColumn(title: 'Done', tasks: tasks, onMove: moveTask),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskColumn extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final Function(Task) onMove;

  const TaskColumn({
    super.key,
    required this.title,
    required this.tasks,
    required this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    final filteredTasks =
        tasks.where((task) => task.status == title).toList();

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...filteredTasks.map(
              (task) => Card(
                child: ListTile(
                  title: Text(task.title),
                  trailing: task.status == 'Done'
                      ? const Icon(Icons.check, color: Colors.green)
                      : IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () => onMove(task),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}