import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/task.dart';
import 'add_edit_task_screen.dart';
import 'login_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> with SingleTickerProviderStateMixin {
  List<Task> tasks = [];
  bool _isLoading = false;
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loadTasks();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);

    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      return;
    }

    // Verify session is still valid
    final sessionResponse = await currentUser.getUpdatedUser();
    if (!sessionResponse.success) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      return;
    }

    final QueryBuilder<Task> query = QueryBuilder<Task>(Task())
      ..whereEqualTo(Task.keyCreatedBy, currentUser)
      ..orderByDescending('createdAt');

    final response = await query.query();

    setState(() => _isLoading = false);

    if (response.success && response.results != null) {
      setState(() {
        tasks = response.results!.cast<Task>();
      });
    } else {
      // Handle error case - show empty list rather than crash
      setState(() {
        tasks = [];
      });
      if (mounted && response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading tasks: ${response.error!.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteTask(Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: NeumorphicTheme.baseColor(context),
        title: Row(
          children: [
            Icon(Icons.delete_forever, color: Colors.red[400]),
            const SizedBox(width: 8),
            Flexible(child: Text('Delete Task', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this task?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          NeumorphicButton(
            onPressed: () => Navigator.pop(context, false),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          NeumorphicButton(
            onPressed: () => Navigator.pop(context, true),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              color: Colors.red[400],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text('Delete', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final response = await task.delete();
      if (response.success) {
        _loadTasks();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task deleted successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete task: ${response.error?.message ?? "Unknown error"}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: NeumorphicTheme.baseColor(context),
        title: Row(
          children: [
            Icon(Icons.logout, color: Colors.orange[600]),
            const SizedBox(width: 8),
            Flexible(child: Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
          ],
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          NeumorphicButton(
            onPressed: () => Navigator.pop(context, false),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          NeumorphicButton(
            onPressed: () => Navigator.pop(context, true),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              color: Colors.orange[600],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text('Logout', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final user = await ParseUser.currentUser() as ParseUser?;
      if (user != null) {
        await user.logout();
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  Widget _buildTaskCard(Task task, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: task.isCompleted ? -4 : 8,
          intensity: 0.7,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          color: task.isCompleted ? Colors.grey[300] : NeumorphicTheme.baseColor(context),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: task.isCompleted ? Colors.grey[600] : Colors.grey[800],
                          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (task.description != null && task.description!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          task.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: task.isCompleted ? Colors.grey[500] : Colors.grey[600],
                            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Action buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NeumorphicButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditTaskScreen(task: task),
                          ),
                        );
                        if (result == true) {
                          _loadTasks();
                        }
                      },
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        depth: 4,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.edit_outlined, size: 18, color: Colors.blue[600]),
                    ),
                    const SizedBox(height: 8),
                    NeumorphicButton(
                      onPressed: () => _deleteTask(task),
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        depth: 4,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.delete_outline, size: 18, color: Colors.red[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: NeumorphicAppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(Icons.task_alt_rounded, color: Colors.deepPurple[400], size: 28),
        ),
        title: Text(
          'Tasks',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          NeumorphicButton(
            onPressed: _loadTasks,
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              depth: 2,
            ),
            child: Icon(Icons.refresh, color: Colors.grey[700], size: 20),
          ),
          NeumorphicButton(
            onPressed: _logout,
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              depth: 2,
            ),
            child: Icon(Icons.logout, color: Colors.orange[600], size: 20),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: NeumorphicProgressIndeterminate())
          : tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neumorphic(
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: const NeumorphicBoxShape.circle(),
                          depth: 8,
                          intensity: 0.7,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          child: Icon(
                            Icons.task_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No tasks yet',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap the + button to add your first task',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadTasks,
                  child: ListView.builder(
                    itemCount: tasks.length,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildTaskCard(tasks[index], index);
                    },
                  ),
                ),
      floatingActionButton: NeumorphicFloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditTaskScreen(),
            ),
          );
          if (result == true) {
            _loadTasks();
          }
        },
        style: NeumorphicStyle(
          depth: 8,
          intensity: 0.8,
          boxShape: const NeumorphicBoxShape.circle(),
          color: Colors.deepPurple[400],
        ),
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}
