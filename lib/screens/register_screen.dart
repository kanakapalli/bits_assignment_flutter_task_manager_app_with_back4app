import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'task_list_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final user = ParseUser(_emailController.text.trim(), _passwordController.text, _emailController.text.trim());

    var response = await user.signUp();

    setState(() => _isLoading = false);

    if (response.success && mounted) {
      _showSuccessDialog();
    } else {
      if (mounted) {
        _showErrorDialog(response.error?.message ?? 'Registration failed');
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green[400]),
            const SizedBox(width: 8),
            const Flexible(child: Text('Success!')),
          ],
        ),
        content: Text(
          'Registration successful! Welcome aboard!',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TaskListScreen()),
              );
            },
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              color: Colors.green[400],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text('Continue', style: GoogleFonts.poppins(color: Colors.white)),
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
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red[400]),
            const SizedBox(width: 8),
            const Flexible(child: Text('Error')),
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
        title: Text(
          'Create Account',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Icon with neumorphic effect
                  Center(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: const NeumorphicBoxShape.circle(),
                        depth: 8,
                        intensity: 0.7,
                        lightSource: LightSource.topLeft,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        child: Icon(
                          Icons.person_add_rounded,
                          size: 80,
                          color: Colors.green[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Title
                  Text(
                    'Join Us Today!',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create your account to get started',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Email Field
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: -5,
                      intensity: 0.8,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.green[400]),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: -5,
                      intensity: 0.8,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.green[400]),
                        suffixIcon: NeumorphicButton(
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                          style: const NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            depth: 0,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      obscureText: _obscurePassword,
                      style: GoogleFonts.poppins(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Field
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: -5,
                      intensity: 0.8,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                        prefixIcon: Icon(Icons.lock_clock_outlined, color: Colors.green[400]),
                        suffixIcon: NeumorphicButton(
                          onPressed: () {
                            setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                          },
                          style: const NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            depth: 0,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      obscureText: _obscureConfirmPassword,
                      style: GoogleFonts.poppins(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Register Button
                  NeumorphicButton(
                    onPressed: _isLoading ? null : _register,
                    style: NeumorphicStyle(
                      depth: 8,
                      intensity: 0.8,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                      color: Colors.green[400],
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
                          : Text(
                              'Register',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Link
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      NeumorphicButton(
                        onPressed: () => Navigator.pop(context),
                        style: const NeumorphicStyle(
                          depth: 0,
                          boxShape: NeumorphicBoxShape.rect(),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            color: Colors.green[600],
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
