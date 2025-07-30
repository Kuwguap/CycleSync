import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'create_profile_success_screen.dart';

class AgeGroupSelectionScreen extends StatefulWidget {
  const AgeGroupSelectionScreen({super.key});

  @override
  State<AgeGroupSelectionScreen> createState() => _AgeGroupSelectionScreenState();
}

class _AgeGroupSelectionScreenState extends State<AgeGroupSelectionScreen> {
  String? _selectedAgeGroup;

  final List<String> _ageGroups = [
    '10-12', '13-15', '16-20', '21-25',
    '26-30', '31-35', '36-39', '39-44'
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
                'Age Group',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A2128),
                  letterSpacing: -0.56,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Age Group Grid
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
                        Expanded(child: _buildAgeGroupOption('10-12')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildAgeGroupOption('13-15')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildAgeGroupOption('16-20')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildAgeGroupOption('21-25')),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Second row
                    Row(
                      children: [
                        Expanded(child: _buildAgeGroupOption('26-30')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildAgeGroupOption('31-35')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildAgeGroupOption('36-39')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildAgeGroupOption('39-44')),
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
                      MaterialPageRoute(builder: (context) => const CreateProfileSuccessScreen()),
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
                  _buildPageIndicator(false),
                  const SizedBox(width: 8),
                  _buildPageIndicator(false),
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
  
  Widget _buildAgeGroupOption(String ageGroup) {
    final isSelected = _selectedAgeGroup == ageGroup;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAgeGroup = ageGroup;
        });
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink.shade500 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.pink.shade500 : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            ageGroup,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF1A2128),
            ),
          ),
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