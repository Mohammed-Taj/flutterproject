import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants.dart';
import 'package:shop/provider/auth_provider.dart';

class UserProfileScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: authProvider.isLoading
          ? Center(child: CircularProgressIndicator(color: kprimaryColor))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Username Display Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kprimaryColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            authProvider.username ?? "N/A",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kprimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  usernameController.text =
                                      authProvider.username ?? '';
                                  return _buildUpdateDialog(
                                    context: context,
                                    title: 'Update Username',
                                    content: TextField(
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                          labelText: 'New Username'),
                                    ),
                                    onUpdate: () async {
                                      String newUsername =
                                          usernameController.text;
                                      await authProvider.updateProfile(
                                          newUsername, '');
                                      _handleUpdateResponse(
                                          context,
                                          authProvider,
                                          'Username updated successfully!');
                                    },
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.white),
                            label: Text('Update Username'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Password Update Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kprimaryColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '********',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kprimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return _buildUpdateDialog(
                                    context: context,
                                    title: 'Update Password',
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextField(
                                          controller: currentPasswordController,
                                          decoration: InputDecoration(
                                              labelText: 'Current Password'),
                                          obscureText: true,
                                        ),
                                        TextField(
                                          controller: newPasswordController,
                                          decoration: InputDecoration(
                                              labelText: 'New Password'),
                                          obscureText: true,
                                        ),
                                      ],
                                    ),
                                    onUpdate: () async {
                                      String currentPassword =
                                          currentPasswordController.text;
                                      String newPassword =
                                          newPasswordController.text;

                                      if (currentPassword.isEmpty ||
                                          newPassword.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Both fields are required')),
                                        );
                                        return;
                                      }

                                      await authProvider.updateProfile(
                                          authProvider.username!, newPassword);
                                      _handleUpdateResponse(
                                          context,
                                          authProvider,
                                          'Password updated successfully!');
                                    },
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.lock, color: Colors.white),
                            label: Text('Update Password'),
                          ),
                        ],
                      ),
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
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onUpdate,
          style: ElevatedButton.styleFrom(
            backgroundColor: kprimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text('Update'),
        ),
      ],
    );
  }

  void _handleUpdateResponse(
      BuildContext context, AuthProvider authProvider, String successMessage) {
    if (authProvider.errorMessage == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(successMessage)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMessage!)),
      );
    }
  }
}
