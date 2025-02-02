import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/auth_provider.dart';
import 'package:shop/shared/shared_prefs_helper.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () async {
              authProvider.logout();
              await SharedPrefsHelper
                  .clearPreferences(); // Clear SharedPreferences on logout
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: authProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder(
              future: SharedPrefsHelper
                  .getEmail(), // Retrieve email from SharedPreferences
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final String email =
                    snapshot.data ?? "N/A"; // Provide a default value

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildProfileCard(
                          context,
                          title: 'Email',
                          content:
                              email, // Display email from SharedPreferences
                          icon: Icons.email,
                          buttonLabel: 'Update Email',
                          onPressed: () =>
                              _showEmailUpdateDialog(context, authProvider),
                        ),
                        const SizedBox(height: 20),
                        _buildProfileCard(
                          context,
                          title: 'Username',
                          content: authProvider.username ??
                              "N/A", // Provide a default value
                          icon: Icons.person,
                          buttonLabel: 'Update Username',
                          onPressed: () =>
                              _showUsernameUpdateDialog(context, authProvider),
                        ),
                        const SizedBox(height: 20),
                        _buildProfileCard(
                          context,
                          title: 'Password',
                          content: '********',
                          icon: Icons.lock,
                          buttonLabel: 'Update Password',
                          onPressed: () =>
                              _showPasswordUpdateDialog(context, authProvider),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showEmailUpdateDialog(BuildContext context, AuthProvider authProvider) {
    final emailController = TextEditingController();
    emailController.text = authProvider.email ?? ''; // Provide a default value

    showDialog(
      context: context,
      builder: (context) {
        return _buildUpdateDialog(
          context: context,
          title: 'Update Email',
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'New Email',
              border: OutlineInputBorder(),
              hintText: 'Enter your new email',
            ),
          ),
          onUpdate: () async {
            String newEmail = emailController.text.trim();
            if (newEmail.isEmpty || !newEmail.contains('@')) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a valid email'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            await authProvider.updateEmail(newEmail);
            _handleUpdateResponse(
                context, authProvider, 'Email updated successfully!');
          },
        );
      },
    );
  }

  void _showUsernameUpdateDialog(
      BuildContext context, AuthProvider authProvider) {
    final usernameController = TextEditingController();
    usernameController.text =
        authProvider.username ?? ''; // Provide a default value

    showDialog(
      context: context,
      builder: (context) {
        return _buildUpdateDialog(
          context: context,
          title: 'Update Username',
          content: TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'New Username',
              border: OutlineInputBorder(),
              hintText: 'Enter your new username',
            ),
          ),
          onUpdate: () async {
            String newUsername = usernameController.text.trim();
            if (newUsername.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Username cannot be empty'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            await authProvider.updateUsername(newUsername);
            _handleUpdateResponse(
                context, authProvider, 'Username updated successfully!');
          },
        );
      },
    );
  }

  void _showPasswordUpdateDialog(
      BuildContext context, AuthProvider authProvider) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return _buildUpdateDialog(
          context: context,
          title: 'Update Password',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your current password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your new password',
                ),
                obscureText: true,
              ),
            ],
          ),
          onUpdate: () async {
            String currentPassword = currentPasswordController.text.trim();
            String newPassword = newPasswordController.text.trim();

            if (currentPassword.isEmpty || newPassword.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Both fields are required'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            if (newPassword.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password must be at least 6 characters long'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            await authProvider.updatePassword(
              currentPassword: currentPassword,
              newPassword: newPassword,
            );
            _handleUpdateResponse(
                context, authProvider, 'Password updated successfully!');
          },
        );
      },
    );
  }

  Widget _buildProfileCard(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
    required String buttonLabel,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                elevation: 8,
              ),
              onPressed: onPressed,
              icon: Icon(icon, color: Colors.white),
              label: Text(
                buttonLabel,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    required VoidCallback onUpdate,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: onUpdate,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Update', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void _handleUpdateResponse(
    BuildContext context,
    AuthProvider authProvider,
    String successMessage,
  ) {
    if (authProvider.errorMessage == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(successMessage),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
