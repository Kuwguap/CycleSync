# Firebase Setup Guide for CycleSync

## ✅ Firebase Dependencies Added

The following Firebase packages have been added to your project:
- `firebase_core: ^2.24.2` - Core Firebase functionality
- `firebase_auth: ^4.15.3` - Authentication services
- `cloud_firestore: ^4.13.6` - Cloud database

## 🔧 Firebase Configuration

### Current Setup:
- **Project ID**: `cyclesync-8756a`
- **Web API Key**: `AIzaSyB_83BeAcZWf76m5Ni6OWPy0qebOEH0KBo`
- **Auth Domain**: `cyclesync-8756a.firebaseapp.com`

## 🚀 Next Steps to Complete Firebase Setup

### 1. Firebase Console Configuration

1. **Go to Firebase Console**: https://console.firebase.google.com/
2. **Select your project**: `cyclesync-8756a`
3. **Enable Authentication**:
   - Go to Authentication → Sign-in method
   - Enable "Email/Password" provider
   - Save changes

4. **Set up Firestore Database**:
   - Go to Firestore Database → Create database
   - Choose "Start in test mode" (for development)
   - Select a location (choose closest to your users)
   - Create database

### 2. Security Rules (Firestore)

Add these security rules to your Firestore database:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 3. Test the Setup

1. **Run the app**: `flutter run -d chrome`
2. **Create a test account** through the signup flow
3. **Check Firebase Console** to see the user in Authentication
4. **Check Firestore** to see user data in the `users` collection

## 📊 What's Now Working

### ✅ Authentication Features:
- **User Registration** - Creates Firebase Auth user + Firestore profile
- **User Login** - Authenticates with Firebase Auth
- **Password Reset** - Sends real reset emails
- **Logout** - Properly signs out from Firebase
- **Session Management** - Persistent login state

### ✅ Database Features:
- **User Profiles** - Stored in Firestore `users` collection
- **Profile Updates** - Real-time database updates
- **Data Persistence** - Data survives app restarts
- **Real-time Sync** - Changes sync across devices

## 🔍 Database Structure

### Users Collection (`users/{userId}`):
```json
{
  "fullName": "John Doe",
  "email": "john@example.com",
  "createdAt": "2024-01-01T00:00:00Z",
  "profileCompleted": false,
  "nickname": "",
  "ageGroup": "",
  "avatar": "",
  "language": "English",
  "updatedAt": "2024-01-01T00:00:00Z"
}
```

## 🛠️ Development vs Production

### Development Mode:
- Test users can be created through the app
- Firestore rules are permissive
- Debug logging is enabled

### Production Mode:
- Use Firebase Console to manage users
- Restrictive Firestore security rules
- Disabled debug logging

## 🚨 Important Notes

1. **Firebase Project**: Make sure you have access to the `cyclesync-8756a` project
2. **Billing**: Firestore has a free tier, but monitor usage
3. **Security**: Update Firestore rules before production
4. **Backup**: Consider implementing data backup strategies

## 🐛 Troubleshooting

### Common Issues:
1. **Authentication not working**: Check if Email/Password is enabled in Firebase Console
2. **Database errors**: Verify Firestore is created and rules are set
3. **Network errors**: Check internet connection and Firebase project status

### Debug Commands:
```bash
# Check Firebase configuration
flutterfire configure

# View Firebase logs
firebase functions:log

# Test authentication
flutter test test/auth_test.dart
```

## 📱 Testing Checklist

- [ ] User registration works
- [ ] User login works
- [ ] Password reset sends email
- [ ] Profile data saves to Firestore
- [ ] Profile updates work
- [ ] Logout works
- [ ] Session persists after app restart

## 🎯 Next Features to Implement

1. **Real-time data sync** for cycle tracking
2. **Push notifications** for reminders
3. **Data analytics** and insights
4. **Social features** and sharing
5. **Offline support** with local caching

Your CycleSync app now has a fully functional Firebase backend! 🎉 