import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'language_selection_screen.dart';

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
      'icon': Icons.person,
      'name': 'Pink Avatar',
    },
    {
      'color': Colors.green,
      'icon': Icons.person_outline,
      'name': 'Green Avatar',
    },
    {
      'color': Colors.brown,
      'icon': Icons.face,
      'name': 'Brown Avatar',
    },
    {
      'color': Colors.yellow,
      'icon': Icons.emoji_emotions,
      'name': 'Yellow Avatar',
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
              
              // Next Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Next',
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
              
              // Page Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageIndicator(true),
                  const SizedBox(width: 8),
                  _buildPageIndicator(true),
                  const SizedBox(width: 8),
                  _buildPageIndicator(true),
                ],
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
              child: Icon(
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
  
  Widget _buildPageIndicator(bool isActive) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.pink.shade500 : Colors.grey.shade300,
      ),
    );
  }
} 