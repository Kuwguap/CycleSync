// Mock Authentication Service for development
// This simulates Firebase Auth functionality without the actual Firebase dependencies

class MockUser {
  final String uid;
  final String email;
  final String? displayName;
  
  MockUser({
    required this.uid,
    required this.email,
    this.displayName,
  });
}

class MockUserCredential {
  final MockUser user;
  
  MockUserCredential({required this.user});
}

class MockAuthException implements Exception {
  final String code;
  final String message;
  
  MockAuthException(this.code, this.message);
  
  @override
  String toString() => message;
}

class AuthService {
  MockUser? _currentUser;
  final Map<String, Map<String, dynamic>> _mockDatabase = {};
  
  // Add some debug methods
  void _debugPrintDatabase() {
    print('=== MOCK DATABASE DEBUG ===');
    print('Total users: ${_mockDatabase.length}');
    _mockDatabase.forEach((email, data) {
      print('Email: $email');
      print('  FullName: ${data['fullName']}');
      print('  Password: ${data['password']}');
    });
    print('==========================');
  }

  // Get current user
  MockUser? get currentUser => _currentUser;

  // Auth state changes stream (simplified)
  Stream<MockUser?> get authStateChanges => Stream.value(_currentUser);

  // Sign up with email and password
  Future<MockUserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Check if user already exists
    if (_mockDatabase.containsKey(email)) {
      throw MockAuthException('email-already-in-use', 'An account already exists with this email address.');
    }

    // Create mock user
    final user = MockUser(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      displayName: fullName,
    );

    // Store user data
    _mockDatabase[email] = {
      'fullName': fullName,
      'email': email,
      'password': password, // In real app, this would be hashed
      'createdAt': DateTime.now().toIso8601String(),
      'profileCompleted': false,
      'nickname': '',
      'ageGroup': '',
      'avatar': '',
      'language': 'English',
    };

    _currentUser = user;
    
    // Debug: Print database after signup
    print('User registered successfully: $email');
    _debugPrintDatabase();
    
    return MockUserCredential(user: user);
  }

  // Sign in with email and password
  Future<MockUserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Debug: Print database before login attempt
    print('Login attempt for: $email');
    _debugPrintDatabase();
    
    // Check if user exists
    if (!_mockDatabase.containsKey(email)) {
      print('User not found: $email');
      throw MockAuthException('user-not-found', 'No user found with this email address.');
    }

    // Check password
    final storedPassword = _mockDatabase[email]!['password'];
    print('Stored password: $storedPassword');
    print('Provided password: $password');
    
    if (storedPassword != password) {
      print('Password mismatch for: $email');
      throw MockAuthException('wrong-password', 'Wrong password provided.');
    }

    // Create mock user
    final user = MockUser(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      displayName: _mockDatabase[email]!['fullName'],
    );

    _currentUser = user;
    print('Login successful for: $email');
    return MockUserCredential(user: user);
  }

  // Sign out
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  // Reset password (mock implementation)
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (!_mockDatabase.containsKey(email)) {
      throw MockAuthException('user-not-found', 'No user found with this email address.');
    }
    
    // In a real app, this would send an email
    print('Password reset email would be sent to: $email');
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String nickname,
    required String ageGroup,
    required String avatar,
    required String language,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (currentUser != null) {
      final email = currentUser!.email;
      if (_mockDatabase.containsKey(email)) {
        _mockDatabase[email]!.addAll({
          'nickname': nickname,
          'ageGroup': ageGroup,
          'avatar': avatar,
          'language': language,
          'profileCompleted': true,
          'updatedAt': DateTime.now().toIso8601String(),
        });
      }
    }
  }

  // Get user profile data
  Future<Map<String, dynamic>?> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (currentUser != null) {
      final email = currentUser!.email;
      if (_mockDatabase.containsKey(email)) {
        return _mockDatabase[email];
      }
    }
    return null;
  }

  // Handle mock auth exceptions
  String _handleAuthException(MockAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  // Add test user for debugging
  void addTestUser() {
    _mockDatabase['test@example.com'] = {
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
    print('Test user added: test@example.com / password123');
    _debugPrintDatabase();
  }
} 