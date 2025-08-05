import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChooseAvatarScreen extends StatefulWidget {
  const ChooseAvatarScreen({super.key});

  @override
  State<ChooseAvatarScreen> createState() => _ChooseAvatarScreenState();
}

class _ChooseAvatarScreenState extends State<ChooseAvatarScreen> {
  int _selectedAvatarIndex = 0;

  final List<Map<String, dynamic>> _avatars = [
    {
      'color': Colors.pink,
      'image': 'assets/images/pink.png',
      'name': 'Pink Avatar',
      'isImage': true,
    },
    {
      'color': Colors.green,
      'image': 'assets/images/green.png',
      'name': 'Green Avatar',
      'isImage': true,
    },
    {
      'color': Colors.brown,
      'image': 'assets/images/brown.png',
      'name': 'Brown Avatar',
      'isImage': true,
    },
    {
      'color': Colors.yellow,
      'image': 'assets/images/yellow.png',
      'name': 'Yellow Avatar',
      'isImage': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 80),
              
              // Header
              Text(
                'Choose Your Avatar',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A2128),
                  letterSpacing: -0.56,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              // Description
              Text(
                'Select your team mate to customise your look & experience',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Avatar Grid
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // First row
                    Row(
                      children: [
                        Expanded(
                          child: _buildAvatarOption(0),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildAvatarOption(1),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Second row
                    Row(
                      children: [
                        Expanded(
                          child: _buildAvatarOption(2),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildAvatarOption(3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildAvatarOption(int index) {
    final avatar = _avatars[index];
    final isSelected = _selectedAvatarIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAvatarIndex = index;
        });
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: avatar['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.pink.shade500 : Colors.transparent,
            width: 3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: avatar['color'],
                shape: BoxShape.circle,
              ),
              child: avatar['isImage'] 
                ? ClipOval(
                    child: Image.asset(
                      avatar['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: ${avatar['image']}');
                        print('Error: $error');
                        // Fallback to icon if image fails
                        return Icon(
                          _getFallbackIcon(avatar['name']),
                          color: Colors.white,
                          size: 30,
                        );
                      },
                    ),
                  )
                : Icon(
                    avatar['icon'],
                    color: Colors.white,
                    size: 30,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              avatar['name'],
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A2128),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  IconData _getFallbackIcon(String avatarName) {
    switch (avatarName) {
      case 'Pink Avatar':
        return Icons.person;
      case 'Green Avatar':
        return Icons.person_outline;
      case 'Brown Avatar':
        return Icons.face;
      case 'Yellow Avatar':
        return Icons.emoji_emotions;
      default:
        return Icons.person;
    }
  }

  void _handleConfirm() {
    final selectedAvatar = _avatars[_selectedAvatarIndex]['name'];
    Navigator.pop(context, selectedAvatar);
  }
}