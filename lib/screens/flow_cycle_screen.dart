import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';

class FlowCycleScreen extends StatelessWidget {
  const FlowCycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hide system UI overlays (status bar and navigation bar)
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            
            // Profile Image - Woman on bed with phone
            Container(
              width: 338,
              height: 338,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink.shade50,
              ),
              child: Center(
                child: Icon(
                  Icons.phone_android,
                  size: 80,
                  color: Colors.pink.shade300,
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Text Content
            Container(
              width: 374,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // App Title
                  Text(
                    'FlowCycle',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A2128),
                      letterSpacing: -0.68,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  Text(
                    'Empower Your Cycle',
                    style: TextStyle(
                      fontFamily: 'Public Sans',
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF281A21),
                      letterSpacing: -0.44,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Description
                  Text(
                    'Track, Learn, and Enjoy Rewards',
                    style: TextStyle(
                      fontFamily: 'Public Sans',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF281A21),
                      letterSpacing: -0.09,
                      height: 1.35,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPageIndicator(false),
                const SizedBox(width: 8),
                _buildPageIndicator(true),
                const SizedBox(width: 8),
                _buildPageIndicator(false),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Get Started Button
            Container(
              width: 280,
              height: 56,
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
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
                  'Get Started',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 60),
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