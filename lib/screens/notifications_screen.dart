import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'name': 'Dr. Britt Moran',
      'message': 'Your cycle analysis is ready',
      'time': '2 hours ago',
      'isUnread': true,
      'avatar': Icons.person,
    },
    {
      'name': 'CycleSync Team',
      'message': 'New lesson available: Understanding Your Body',
      'time': '5 hours ago',
      'isUnread': true,
      'avatar': Icons.medical_services,
    },
    {
      'name': 'Dr. Sarah Johnson',
      'message': 'Reminder: Track your symptoms today',
      'time': '1 day ago',
      'isUnread': false,
      'avatar': Icons.person,
    },
    {
      'name': 'Wellness Coach',
      'message': 'Great progress! You\'ve completed 5 days',
      'time': '2 days ago',
      'isUnread': false,
      'avatar': Icons.fitness_center,
    },
    {
      'name': 'CycleSync Team',
      'message': 'Weekly report: Your cycle insights',
      'time': '3 days ago',
      'isUnread': false,
      'avatar': Icons.analytics,
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 60),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.grey.shade600,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'My Notifications',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A2128),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.settings,
                  color: Colors.grey.shade600,
                  size: 24,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Notifications List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationItem(notification);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification['isUnread'] ? Colors.pink.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification['isUnread'] ? Colors.pink.shade200 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: notification['isUnread'] ? Colors.pink.shade100 : Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              notification['avatar'],
              color: notification['isUnread'] ? Colors.pink.shade600 : Colors.grey.shade600,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification['name'],
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A2128),
                        ),
                      ),
                    ),
                    if (notification['isUnread'])
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red.shade500,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification['message'],
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['time'],
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 