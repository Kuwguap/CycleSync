import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';

class CycleTrackingScreen extends StatelessWidget {
  const CycleTrackingScreen({super.key});

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
            
            // Illustration
            Container(
              width: 338,
              height: 338,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink.shade50,
              ),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  size: 120,
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
                  // Title
                  Text(
                    'Cycle Sync',
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
                    'Turn Cramps into Coins',
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
                    'Complete challenges, earn rewards',
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
            
            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                
                // Next Button
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade500,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
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