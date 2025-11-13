import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/task.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;
  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleController.text = widget.task!.title ?? '';
      _descriptionController.text = widget.task!.description ?? '';
    }
    // Add listeners to update character counters
    _titleController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      setState(() => _isLoading = false);
      _showErrorDialog('User not logged in');
      return;
    }

    final task = _isEditing ? widget.task! : Task();
    task.title = _titleController.text.trim();
    task.description = _descriptionController.text.trim();

    if (!_isEditing) {
      task.createdBy = currentUser;
      task.isCompleted = false;

      // Set ACL to ensure only the creator can read/write
      final acl = ParseACL(owner: currentUser);
      acl.setPublicReadAccess(allowed: false);
      acl.setPublicWriteAccess(allowed: false);
      task.setACL(acl);
    }

    final response = await task.save();

    setState(() => _isLoading = false);

    if (response.success && mounted) {
      _showSuccessDialog();
    } else {
      if (mounted) {
        _showErrorDialog(response.error?.message ??
            (_isEditing ? 'Failed to update task' : 'Failed to create task'));
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: NeumorphicTheme.baseColor(context),
        title: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green[400]),
            const SizedBox(width: 8),
            Flexible(child: Text('Success!', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
          ],
        ),
        content: Text(
          _isEditing ? 'Task updated successfully!' : 'Task created successfully!',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              color: Colors.green[400],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text('OK', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: NeumorphicTheme.baseColor(context),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red[400]),
            const SizedBox(width: 8),
            Flexible(child: Text('Error', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
          ],
        ),
        content: Text(message, style: GoogleFonts.poppins()),
        actions: [
          NeumorphicButton(
            onPressed: () => Navigator.pop(context),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: NeumorphicAppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isEditing ? Icons.edit_outlined : Icons.add_task,
              color: _isEditing ? Colors.blue[600] : Colors.deepPurple[400],
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                _isEditing ? 'Edit Task' : 'Add Task',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        leading: NeumorphicButton(
          onPressed: () => Navigator.pop(context),
          style: const NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            depth: 2,
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(Icons.arrow_back, size: 20),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Info card
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: 4,
                    intensity: 0.7,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue[400],
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _isEditing
                            ? 'Update your task details below'
                            : 'Fill in the details to create a new task',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Title Label
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'Task Title *',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),

                // Title Field
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: -6,
                    intensity: 0.8,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter task title',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.title, color: Colors.deepPurple[400]),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLength: 100,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a task title';
                      }
                      return null;
                    },
                  ),
                ),

                // Character counter
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 8),
                  child: Text(
                    '${_titleController.text.length}/100 characters',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Description Label
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'Task Description (Optional)',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),

                // Description Field
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: -6,
                    intensity: 0.8,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter task description (optional)',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    style: GoogleFonts.poppins(fontSize: 14),
                    maxLines: 6,
                    maxLength: 500,
                  ),
                ),

                // Character counter
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 8),
                  child: Text(
                    '${_descriptionController.text.length}/500 characters',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Save Button
                NeumorphicButton(
                  onPressed: _isLoading ? null : _saveTask,
                  style: NeumorphicStyle(
                    depth: 8,
                    intensity: 0.8,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                    color: _isEditing ? Colors.blue[600] : Colors.deepPurple[400],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Center(
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _isEditing ? Icons.update : Icons.save,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  _isEditing ? 'Update Task' : 'Create Task',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Cancel Button
                NeumorphicButton(
                  onPressed: () => Navigator.pop(context),
                  style: NeumorphicStyle(
                    depth: 4,
                    intensity: 0.6,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
