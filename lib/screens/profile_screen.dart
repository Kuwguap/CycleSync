import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'notifications_screen.dart';
import 'lessons_screen.dart';
import 'stories_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Profile',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A2128),
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.grey.shade600,
                  size: 24,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Profile Summary
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.pink.shade100,
                    child: Icon(
                      Icons.person,
                      color: Colors.pink.shade600,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RahRah',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A2128),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: 0.8,
                                backgroundColor: Colors.pink.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade500),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '80%',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.pink.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Profile Completion',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Settings Options
            _buildSettingsSection([
              _buildSettingsItem('Edit Profile', Icons.edit, () {}),
              _buildSettingsItem('My Cycle', Icons.calendar_today, () {}),
              _buildSettingsItem('My Symptoms', Icons.favorite, () {}),
              _buildSettingsItem('My Mood', Icons.sentiment_satisfied, () {}),
              _buildSettingsItem('My Activity', Icons.directions_run, () {}),
              _buildSettingsItem('My Goals', Icons.flag, () {}),
              _buildSettingsItem('My Rewards', Icons.star, () {}),
              _buildSettingsItem('My Lessons', Icons.school, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LessonsScreen()),
                );
              }),
              _buildSettingsItem('My Stories', Icons.book, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StoriesScreen()),
                );
              }),
              _buildSettingsItem('My Notifications', Icons.notifications, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                );
              }),
              _buildSettingsItem('My Reminders', Icons.alarm, () {}),
              _buildSettingsItem('My Privacy', Icons.security, () {}),
              _buildSettingsItem('My Language', Icons.language, () {}),
              _buildSettingsItem('My Subscription', Icons.card_membership, () {}),
              _buildSettingsItem('Help & Support', Icons.help, () {}),
              _buildSettingsItem('Log Out', Icons.logout, () {}, isDestructive: true),
            ]),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red.shade500 : Colors.grey.shade600,
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red.shade500 : const Color(0xFF1A2128),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey.shade400,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
} 