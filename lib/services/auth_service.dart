import 'package:flutter/foundation.dart';

// Platform-specific authentication service
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Web-compatible user data structure
  Map<String, dynamic>? _currentUser;
  final Map<String, Map<String, dynamic>> _webDatabase = {};

  Map<String, dynamic>? get currentUser => _currentUser;

  Stream<Map<String, dynamic>?> get authStateChanges => 
      Stream.value(_currentUser);

  // Email validation
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Password validation
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<Map<String, dynamic>?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // Validate inputs
      if (fullName.trim().isEmpty) {
        throw Exception('Full name is required.');
      }

      if (email.trim().isEmpty) {
        throw Exception('Email address is required.');
      }

      if (!_isValidEmail(email.trim())) {
        throw Exception('Please enter a valid email address.');
      }

      if (password.isEmpty) {
        throw Exception('Password is required.');
      }

      if (!_isValidPassword(password)) {
        throw Exception('Password must be at least 6 characters long.');
      }
      
      // Normalize email to lowercase and trim
      final normalizedEmail = email.trim().toLowerCase();
      
      if (kIsWeb) {
        // Web implementation - simulate Firebase behavior
        if (_webDatabase.containsKey(normalizedEmail)) {
          throw Exception('An account already exists with this email address.');
        }

        final user = {
          'uid': DateTime.now().millisecondsSinceEpoch.toString(),
          'email': normalizedEmail,
          'displayName': fullName.trim(),
        };

        _webDatabase[normalizedEmail] = {
          'fullName': fullName.trim(),
          'email': normalizedEmail,
          'password': password, // In real app, this would be hashed
          'createdAt': DateTime.now().toIso8601String(),
          'profileCompleted': false,
          'nickname': '',
          'ageGroup': '',
          'avatar': '',
          'language': 'English',
        };

        _currentUser = user;
        print('User registered successfully (Web): $normalizedEmail');
        debugPrintDatabase();
        return user;
      } else {
        // Mobile implementation - use Firebase
        return await _signUpWithFirebase(email: normalizedEmail, password: password, fullName: fullName.trim());
      }
    } catch (e) {
      print('Signup error: $e');
      throw Exception('Registration failed: $e');
    }
  }

  Future<Map<String, dynamic>?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Validate inputs
      if (email.trim().isEmpty) {
        throw Exception('Email address is required.');
      }

      if (password.isEmpty) {
        throw Exception('Password is required.');
      }
      
      // Normalize email to lowercase and trim
      final normalizedEmail = email.trim().toLowerCase();
      
      if (kIsWeb) {
        // Web implementation
        if (!_webDatabase.containsKey(normalizedEmail)) {
          throw Exception('No account found with this email address.');
        }

        final storedPassword = _webDatabase[normalizedEmail]!['password'];
        if (storedPassword != password) {
          throw Exception('Incorrect password. Please try again.');
        }

        final user = {
          'uid': DateTime.now().millisecondsSinceEpoch.toString(),
          'email': normalizedEmail,
          'displayName': _webDatabase[normalizedEmail]!['fullName'],
        };

        _currentUser = user;
        print('User signed in successfully (Web): $normalizedEmail');
        return user;
      } else {
        // Mobile implementation - use Firebase
        return await _signInWithFirebase(email: normalizedEmail, password: password);
      }
    } catch (e) {
      print('Signin error: $e');
      throw Exception('Login failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      if (kIsWeb) {
        _currentUser = null;
        print('User signed out successfully (Web)');
      } else {
        await _signOutWithFirebase();
      }
    } catch (e) {
      print('Signout error: $e');
      throw Exception('Sign out failed: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      if (email.trim().isEmpty) {
        throw Exception('Email address is required.');
      }

      if (!_isValidEmail(email.trim())) {
        throw Exception('Please enter a valid email address.');
      }

      if (kIsWeb) {
        // Web implementation - simulate password reset
        if (!_webDatabase.containsKey(email.trim().toLowerCase())) {
          throw Exception('No account found with this email address.');
        }
        print('Password reset email would be sent to: $email (Web simulation)');
      } else {
        // Mobile implementation - use Firebase
        await _resetPasswordWithFirebase(email: email.trim());
      }
    } catch (e) {
      print('Password reset error: $e');
      throw Exception('Password reset failed: $e');
    }
  }

  Future<void> updateUserProfile({
    String? nickname,
    String? ageGroup,
    String? avatar,
    String? language,
  }) async {
    try {
      if (kIsWeb) {
        // Web implementation
        if (_currentUser == null) {
          throw Exception('No user is currently signed in.');
        }

        final email = _currentUser!['email'];
        if (_webDatabase.containsKey(email)) {
          final updates = <String, dynamic>{};
          if (nickname != null) updates['nickname'] = nickname;
          if (ageGroup != null) updates['ageGroup'] = ageGroup;
          if (avatar != null) updates['avatar'] = avatar;
          if (language != null) updates['language'] = language;
          updates['profileCompleted'] = true;

          _webDatabase[email]!.addAll(updates);
          print('User profile updated successfully (Web)');
        }
      } else {
        // Mobile implementation - use Firebase
        await _updateProfileWithFirebase(nickname: nickname, ageGroup: ageGroup, avatar: avatar, language: language);
      }
    } catch (e) {
      print('Profile update error: $e');
      throw Exception('Profile update failed: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      if (kIsWeb) {
        // Web implementation
        if (_currentUser == null) {
          return null;
        }

        final email = _currentUser!['email'];
        if (_webDatabase.containsKey(email)) {
          return _webDatabase[email];
        }
        return null;
      } else {
        // Mobile implementation - use Firebase
        return await _getProfileWithFirebase();
      }
    } catch (e) {
      print('Get profile error: $e');
      throw Exception('Failed to get user profile: $e');
    }
  }

  // Helper method for testing
  void addTestUser() {
    if (kIsWeb) {
      if (!_webDatabase.containsKey('test@example.com')) {
        _webDatabase['test@example.com'] = {
          'fullName': 'Test User',
          'email': 'test@example.com',
          'password': 'password123',
          'createdAt': DateTime.now().toIso8601String(),
          'profileCompleted': false,
          'nickname': '',
          'ageGroup': '',
          'avatar': '',
          'language': 'English',
        };
        print('Test user added (Web): test@example.com / password123');
        debugPrintDatabase();
      }
    } else {
      print('Test user functionality available for mobile - use signUpWithEmailAndPassword to create real users');
    }
  }

  // Debug method to print current database state
  void debugPrintDatabase() {
    if (kIsWeb) {
      print('=== WEB DATABASE DEBUG ===');
      print('Total users: ${_webDatabase.length}');
      _webDatabase.forEach((email, data) {
        print('Email: $email');
        print('  FullName: ${data['fullName']}');
        print('  ProfileCompleted: ${data['profileCompleted']}');
      });
      print('==========================');
    } else {
      print('Debug database - Firebase implementation on mobile');
    }
  }

  // Mobile-specific Firebase methods (will be implemented when Firebase is available)
  Future<Map<String, dynamic>?> _signUpWithFirebase({
    required String email,
    required String password,
    required String fullName,
  }) async {
    // This would use Firebase Auth on mobile
    // For now, we'll simulate the behavior
    await Future.delayed(const Duration(seconds: 1));
    
    final user = {
      'uid': DateTime.now().millisecondsSinceEpoch.toString(),
      'email': email,
      'displayName': fullName,
    };

    print('User registered successfully (Mobile Firebase): $email');
    return user;
  }

  Future<Map<String, dynamic>?> _signInWithFirebase({
    required String email,
    required String password,
  }) async {
    // This would use Firebase Auth on mobile
    // For now, we'll simulate the behavior
    await Future.delayed(const Duration(seconds: 1));
    
    final user = {
      'uid': DateTime.now().millisecondsSinceEpoch.toString(),
      'email': email,
      'displayName': 'User',
    };

    print('User signed in successfully (Mobile Firebase): $email');
    return user;
  }

  Future<void> _signOutWithFirebase() async {
    // This would use Firebase Auth on mobile
    await Future.delayed(const Duration(milliseconds: 500));
    print('User signed out successfully (Mobile Firebase)');
  }

  Future<void> _resetPasswordWithFirebase({required String email}) async {
    // This would use Firebase Auth on mobile
    await Future.delayed(const Duration(seconds: 1));
    print('Password reset email sent to: $email (Mobile Firebase)');
  }

  Future<void> _updateProfileWithFirebase({
    String? nickname,
    String? ageGroup,
    String? avatar,
    String? language,
  }) async {
    // This would use Firebase Firestore on mobile
    await Future.delayed(const Duration(milliseconds: 500));
    print('User profile updated successfully (Mobile Firebase)');
  }

  Future<Map<String, dynamic>?> _getProfileWithFirebase() async {
    // This would use Firebase Firestore on mobile
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'uid': 'mobile-user-id',
      'email': 'user@example.com',
      'displayName': 'Mobile User',
      'profileCompleted': false,
    };
  }
} 