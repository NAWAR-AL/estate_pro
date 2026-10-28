import 'package:estate_pro/features/widgets/custom_appbar.dart';
import 'package:estate_pro/features/widgets/custom_button.dart';
import 'package:estate_pro/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _send() {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Your message has been sent. Thank you!')),
    );
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppbar(title: 'Contact Us'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get in touch',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const Gap(8),
            const Text(
              'Have a question about a property or one of our services? '
              'Send us a message and our team will get back to you.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.darkLight,
                height: 1.5,
              ),
            ),
            const Gap(24),
            _infoTile(Icons.phone_outlined, 'Phone', '+1 (555) 123-4567'),
            const Gap(12),
            _infoTile(Icons.email_outlined, 'Email', 'hello@estatepro.com'),
            const Gap(12),
            _infoTile(
              Icons.location_on_outlined,
              'Office',
              '120 Sunset Boulevard, Los Angeles, CA',
            ),
            const Gap(28),
            _field(_nameController, 'Full name'),
            const Gap(14),
            _field(_emailController, 'Email address'),
            const Gap(14),
            _field(_messageController, 'Your message', maxLines: 5),
            const Gap(24),
            CustomButton(
              text: 'Send Message',
              icon: Icons.send_outlined,
              onPressed: _send,
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.gold, size: 20),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.darkLight,
                  ),
                ),
                const Gap(2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.light, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}