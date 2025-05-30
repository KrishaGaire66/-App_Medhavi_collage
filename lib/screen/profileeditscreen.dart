import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medhavi/utils/colors.dart';
import 'package:medhavi/widgets/custom_button.dart';
import 'package:medhavi/widgets/custom_textfield.dart';

class ProfileEditscreen extends StatefulWidget {
  const ProfileEditscreen({super.key});

  @override
  State<ProfileEditscreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<ProfileEditscreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  var authBox = Hive.box('authBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = authBox.get('name') ?? 'user';
    _emailController.text = authBox.get('email') ?? 'email';
    _phoneController.text = authBox.get('phone') ?? '9819999099';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pick from Gallery'),
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  setState(() {
                    _pickedImage = File(pickedFile.path);
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  setState(() {
                    _pickedImage = File(pickedFile.path);
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Settings Clicked')));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image - default blank circle with gray background
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  _pickedImage != null ? FileImage(_pickedImage!) : null,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _pickImage,
              child: const Text('Change Profile Picture'),
            ),
            const SizedBox(height: 20),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Custom TextFields
                  CustomTextField(
                    label: 'Full Name',
                    icon: Icons.person,
                    controller: _nameController,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    isReadOnly: true,
                    label: 'Email',
                    icon: Icons.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Phone',
                    icon: Icons.phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    color: primaryColor,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Fixed Size Button
            SizedBox(
              width: double.infinity, // Full width of the parent container
              height: 50, // Fixed height
              child: Container(
                decoration: BoxDecoration(
                  gradient: linearGradient1,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomButton(
                  text: 'Update',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Save data to Hive
                      await authBox.put('name', _nameController.text);
                      // Show confirmation SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile Updated')),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
