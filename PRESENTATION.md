# Task Manager App with Back4App
## Flutter CRUD Application - BITS Assignment

---

## Slide 1: Title Slide

**Task Manager App**

A Flutter-Based CRUD Application Using Back4App (BaaS)

**Student Name:** [Your Name]
**Course:** [Your Course]
**Date:** November 2025

**Technologies:**
- Flutter (Dart)
- Back4App (Backend-as-a-Service)
- Skeuomorphic/Neumorphic Design

---

## Slide 2: Project Overview

### What is this project?

A **Task Manager Application** that demonstrates:
- ✅ User Authentication (Register/Login)
- ✅ Complete CRUD Operations (Create, Read, Update, Delete)
- ✅ Cloud Backend Integration (Back4App)
- ✅ Modern Skeuomorphic UI Design
- ✅ Real-time Data Synchronization

**Why Back4App?**
- No need to build custom backend
- Ready-to-use authentication
- Cloud database with real-time sync
- Fast deployment and scalability

---

## Slide 3: Technology Stack

### Frontend
- **Flutter/Dart** - Cross-platform mobile framework
- **flutter_neumorphic** ^3.2.0 - 3D UI effects
- **google_fonts** ^4.0.4 - Typography (Poppins)
- **glassmorphism** ^3.0.0 - Glass effects

### Backend
- **Back4App** - Backend-as-a-Service (Parse Server)
- **parse_server_sdk_flutter** ^9.0.0 - SDK for Flutter

### Design Philosophy
- **Skeuomorphism** - Realistic 3D design elements
- **Neumorphic Design** - Soft UI with depth and shadows

---

## Slide 4: App Architecture

```
┌─────────────────────────────────────┐
│         Flutter Frontend            │
│  (Neumorphic UI Components)         │
└──────────────┬──────────────────────┘
               │
               │ Parse SDK
               │
┌──────────────▼──────────────────────┐
│         Back4App Cloud              │
│  ┌──────────────────────────────┐   │
│  │   Authentication Service     │   │
│  └──────────────────────────────┘   │
│  ┌──────────────────────────────┐   │
│  │   Task Database (Parse)      │   │
│  └──────────────────────────────┘   │
└─────────────────────────────────────┘
```

**Key Components:**
- Models: Task model with Parse integration
- Screens: Login, Register, Task List, Add/Edit Task
- Services: Back4App authentication and CRUD operations

---

## Slide 5: Key Features - Authentication

### User Authentication System

**Registration:**
- Email-based account creation
- Password validation (minimum 6 characters)
- Password confirmation matching
- Secure storage in Back4App cloud
- Success dialog with smooth transitions

**Login:**
- Email and password authentication
- Session persistence
- Password visibility toggle
- Error handling with user-friendly messages
- Automatic navigation to task list

**Security:**
- Secure password storage (handled by Back4App)
- Session management with auto-login
- User-specific data access (ACL)

---

## Slide 6: Key Features - CRUD Operations

### Complete Task Management

**Create:**
- Add new tasks with title (required)
- Optional description (up to 500 characters)
- Real-time character counter
- Form validation

**Read:**
- View all tasks in beautiful 3D cards
- Tasks sorted by creation date (newest first)
- Pull-to-refresh for sync

**Update:**
- Edit task title and description
- Mark tasks as complete/incomplete
- Visual feedback (completed tasks pressed inward)

**Delete:**
- Delete with confirmation dialog
- Immediate UI update

---

## Slide 7: Skeuomorphic Design

### What is Skeuomorphism?

A design style that makes digital elements look like their **physical counterparts** with realistic textures, depth, and shadows.

**Our Implementation - Neumorphic Design:**

1. **3D Depth Effects**
   - Inset elements: -6 to -3 depth (pressed in)
   - Raised elements: 4-8 depth (popping out)

2. **Realistic Shadows**
   - Light source from top-left
   - Multi-layered shadows
   - Soft, subtle gradients

3. **Tactile Buttons**
   - Buttons appear raised when unpressed
   - Buttons appear pressed when clicked
   - Smooth transitions

4. **Physical Metaphors**
   - Cards that look embossed
   - Text fields carved into surface
   - Checkboxes with 3D effect

---

## Slide 8: UI Screenshots - Login & Register

### Login Screen
- **3D Circular Logo** - Concave depth effect with task icon
- **Inset Text Fields** - Email and password fields pressed into surface
- **Raised Login Button** - Purple button with depth and shadow
- **Password Toggle** - Neumorphic visibility button
- **Typography** - Poppins font for modern look

### Register Screen
- **Neumorphic App Bar** - With circular back button
- **3D Person Icon** - Concave green icon
- **Three Input Fields** - Email, password, confirm password
- **Raised Register Button** - Green button with depth
- **Success Dialog** - Animated confirmation
- **Password Validation** - Real-time feedback

**Color Scheme:**
- Base: #E0E5EC (soft gray)
- Primary: Deep Purple (#673AB7)
- Success: Green (#66BB6A)
- Error: Red (#EF5350)

---

## Slide 9: UI Screenshots - Task List

### Task List Screen Features

**Neumorphic App Bar:**
- Task icon with title
- Refresh button (circular, raised)
- Logout button (orange, raised)

**Task Cards:**
- 3D cards with depth (raised: depth 8)
- Completed tasks pressed inward (depth -4)
- Neumorphic checkbox (3D toggle)
- Task title and description
- Edit button (blue, raised)
- Delete button (red, raised)

**Empty State:**
- 3D concave icon
- "No tasks yet" message
- Helpful instruction text

**Floating Action Button:**
- Large purple circular button
- Add icon with depth effect
- Positioned bottom-right

---

## Slide 10: UI Screenshots - Add/Edit Task

### Add/Edit Task Screen

**Components:**

1. **Info Card** - Helpful message with icon
2. **Task Title Field**
   - Inset text field (depth -6)
   - Required field with validation
   - Character counter (0/100)
   - Icon prefix

3. **Description Field**
   - Large multiline inset field
   - Optional with 500 character limit
   - Character counter
   - 6 lines height

4. **Action Buttons**
   - **Save Button** - Large raised button (blue/purple)
   - Icon + text layout
   - **Cancel Button** - Secondary raised button
   - Gray color scheme

5. **Dialogs**
   - Success dialog with green theme
   - Error dialog with red theme
   - Neumorphic buttons in dialogs

---

## Slide 11: Application Flow Diagram

```
START
  │
  ▼
┌─────────────────┐
│  App Launch     │
│  (Auth Check)   │
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
Logged In  Not Logged In
    │         │
    │    ┌────▼─────┐
    │    │  Login   │
    │    │  Screen  │
    │    └────┬─────┘
    │         │
    │    [Register?]
    │         │
    │    ┌────▼─────┐
    │    │ Register │
    │    │  Screen  │
    │    └────┬─────┘
    │         │
    └────┬────┘
         │
    ┌────▼─────────┐
    │  Task List   │
    │   Screen     │
    └────┬─────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
[Add Task] [Edit/Delete]
    │         │
    ▼         ▼
┌────────────────┐
│  Add/Edit Task │
│     Screen     │
└────┬───────────┘
     │
     ▼
[Save to Back4App]
     │
     ▼
Back to Task List
```

---

## Slide 12: User Journey

### Step-by-Step User Experience

**1. First Time User**
   - Opens app → Sees login screen
   - Taps "Register" → Enters email & password
   - Confirms password → Taps "Register"
   - Success! → Redirected to empty task list

**2. Creating First Task**
   - Taps floating "+" button
   - Enters task title: "Complete assignment"
   - Adds description: "Finish Flutter project"
   - Taps "Create Task" → Success dialog
   - Task appears in list with 3D card

**3. Managing Tasks**
   - Checks checkbox → Task marked complete
   - Task visually pressed inward
   - Taps edit → Modifies description
   - Taps update → Changes saved
   - Swipes down → Pull to refresh
   - Taps delete → Confirmation → Task removed

**4. Logout**
   - Taps logout in app bar
   - Confirmation dialog appears
   - Confirms → Redirected to login
   - Session ended securely

---

## Slide 13: Database Schema

### Task Object in Back4App

```
Task {
  objectId: String (auto-generated)
  title: String (required, max 100)
  description: String (optional, max 500)
  isCompleted: Boolean (default: false)
  createdBy: Pointer<User> (task owner)
  createdAt: Date (auto-generated)
  updatedAt: Date (auto-generated)
  ACL: {
    [userId]: { read: true, write: true }
  }
}
```

**User Object (Built-in)**
```
User {
  objectId: String
  username: String (email)
  email: String
  password: String (hashed)
  sessionToken: String
  createdAt: Date
  updatedAt: Date
}
```

**Relationships:**
- Each Task belongs to one User (createdBy)
- Each User can have many Tasks
- ACL ensures users only see their own tasks

---

## Slide 14: Back4App Integration

### How Back4App Powers the App

**1. Initialization** (main.dart)
```dart
await Parse().initialize(
  'APPLICATION_ID',
  'https://parseapi.back4app.com',
  clientKey: 'CLIENT_KEY',
  autoSendSessionId: true,
);
```

**2. User Registration**
```dart
final user = ParseUser(email, password, email);
var response = await user.signUp();
```

**3. User Login**
```dart
final user = ParseUser(email, password, email);
var response = await user.login();
```

**4. Create Task**
```dart
final task = Task();
task.title = "My Task";
task.createdBy = currentUser;
await task.save();
```

**5. Read Tasks**
```dart
final query = QueryBuilder<Task>(Task())
  ..whereEqualTo('createdBy', currentUser);
final response = await query.query();
```

**Benefits:**
- No server setup required
- Automatic data persistence
- Real-time synchronization
- Secure authentication handled

---

## Slide 15: Code Structure

### Project Organization

```
lib/
├── main.dart
│   ├── NeumorphicApp configuration
│   ├── Back4App initialization
│   ├── Theme setup (light/dark)
│   └── Auth check widget
│
├── models/
│   └── task.dart
│       └── Task model (extends ParseObject)
│
└── screens/
    ├── login_screen.dart
    │   ├── Login form
    │   ├── Neumorphic inputs
    │   └── Navigation to register
    │
    ├── register_screen.dart
    │   ├── Registration form
    │   ├── Password confirmation
    │   └── Success dialog
    │
    ├── task_list_screen.dart
    │   ├── Task card builder
    │   ├── CRUD operations
    │   ├── Pull to refresh
    │   └── Logout functionality
    │
    └── add_edit_task_screen.dart
        ├── Task form
        ├── Character counters
        └── Save/Update logic
```

**Key Patterns:**
- StatefulWidget for dynamic UI
- Form validation
- Async/await for API calls
- Error handling
- Loading states

---

## Slide 16: Technical Challenges & Solutions

### Challenges Faced

**1. UI Package Compatibility**
- **Problem:** Version conflicts between parse_server_sdk and google_fonts
- **Solution:** Downgraded google_fonts to ^4.0.4 for compatibility

**2. Neumorphic Design Learning Curve**
- **Problem:** Understanding depth, intensity, and light source
- **Solution:** Experimented with values, settled on -6 to 8 range

**3. Real-time Character Counters**
- **Problem:** Character counters not updating on text change
- **Solution:** Added TextEditingController listeners with setState

**4. Task State Management**
- **Problem:** Task list not updating after create/edit/delete
- **Solution:** Implemented result passing through Navigator

**5. Form Validation**
- **Problem:** Multiple validation rules per field
- **Solution:** Used TextFormField validators with clear messages

---

## Slide 17: Key Learnings - Technical

### What I Learned

**1. Backend-as-a-Service (BaaS)**
- Understanding cloud backend without custom server
- Benefits of managed authentication
- Real-time database synchronization
- Parse Server architecture

**2. Flutter Development**
- StatefulWidget vs StatelessWidget
- Form handling and validation
- Navigation with result passing
- Async programming with Future/await
- Error handling and user feedback

**3. Neumorphic Design**
- Depth and shadow manipulation
- Light source consistency
- Inset vs raised elements
- Color theory for 3D effects
- Typography in modern design

**4. State Management**
- Managing form state
- Loading indicators
- Data persistence
- Session management

---

## Slide 18: Key Learnings - Development Process

### Skills Gained

**1. Project Planning**
- Breaking down features into tasks
- Estimating development time
- Managing dependencies

**2. UI/UX Design**
- Skeuomorphism principles
- User flow design
- Accessibility considerations
- Visual hierarchy

**3. API Integration**
- REST API concepts
- Authentication tokens
- CRUD operations via SDK
- Error handling

**4. Testing & Debugging**
- Flutter analyze tool
- Debugging async code
- Testing on different devices
- User acceptance testing

**5. Documentation**
- Writing clear README
- Code comments
- Project presentation

---

## Slide 19: Project Features Summary

### What Makes This App Special

✅ **Complete CRUD Implementation**
- All operations working seamlessly
- Real-time data sync

✅ **Beautiful Skeuomorphic UI**
- Modern take on realistic design
- 3D depth effects throughout
- Consistent design language

✅ **Cloud Backend Integration**
- No custom server needed
- Automatic scaling
- Secure data storage

✅ **User Experience**
- Smooth animations
- Clear feedback
- Intuitive navigation
- Error handling

✅ **Best Practices**
- Clean code structure
- Form validation
- Security considerations
- Responsive design

---

## Slide 20: Future Enhancements

### Possible Improvements

**1. Additional Features**
- Task categories/tags
- Due dates with reminders
- Task priority levels
- Search and filter functionality
- Task statistics/analytics

**2. Enhanced UI**
- Dark mode toggle
- Custom color themes
- Animations on task completion
- Swipe gestures for actions
- Haptic feedback

**3. Collaboration**
- Share tasks with other users
- Team workspaces
- Comments on tasks
- Activity history

**4. Technical Improvements**
- Offline mode with local storage
- Push notifications
- Widget for quick task add
- Export tasks to CSV/PDF
- Biometric authentication

---

## Slide 21: Demo Screenshots

### Visual Showcase

**Screen 1: Login**
- Elegant 3D circular icon
- Inset email and password fields
- Raised purple login button
- "Don't have an account?" link

**Screen 2: Task List**
- Multiple task cards with depth
- Some completed (pressed inward)
- Some active (raised outward)
- Blue edit and red delete buttons
- Purple floating action button

**Screen 3: Add Task**
- Info card at top
- Labeled inset title field
- Large description text area
- Character counters visible
- Large raised save button

**Screen 4: Empty State**
- 3D concave task icon
- "No tasks yet" message
- Clean, minimalist design

---

## Slide 22: Deliverables Completed

### Assignment Requirements

✅ **YouTube Video (2 minutes)**
- Login demonstration
- Task creation
- Task update
- Task deletion
- Logout process
- UI showcase

✅ **GitHub Repository**
- Complete source code
- Detailed README.md
- Project structure
- Installation instructions
- Screenshots

✅ **PPT Presentation**
- Project overview
- Features explanation
- Technology stack
- Key learnings
- Visual demonstrations

✅ **Submission via Taxila**
- Video link ready
- GitHub repo link ready
- PPT file ready

---

## Slide 23: References & Resources

### Learning Resources Used

**Official Documentation:**
- Flutter Docs: https://docs.flutter.dev/
- Back4App Docs: https://docs.back4app.com/
- Parse SDK: https://pub.dev/packages/parse_server_sdk_flutter

**UI/Design:**
- Flutter Neumorphic: https://pub.dev/packages/flutter_neumorphic
- Google Fonts: https://pub.dev/packages/google_fonts
- Material Design Guidelines

**Tools Used:**
- VS Code / Android Studio
- Flutter SDK 3.9.2
- Back4App Console
- Git for version control

**Community Resources:**
- Stack Overflow
- Flutter Community
- GitHub repositories

---

## Slide 24: Conclusion

### Project Summary

**What We Built:**
A fully functional Task Manager app with:
- Cloud backend (Back4App)
- Beautiful skeuomorphic UI
- Complete CRUD operations
- User authentication

**Key Achievements:**
- ✅ Learned Backend-as-a-Service integration
- ✅ Mastered Flutter CRUD operations
- ✅ Implemented modern UI design
- ✅ Delivered production-ready app

**Personal Growth:**
- Enhanced Flutter development skills
- Understood cloud backend architecture
- Improved UI/UX design abilities
- Gained project management experience

**Thank You!**

Questions?

---

## Slide 25: Contact & Repository

### Get the Code

**GitHub Repository:**
[Your GitHub Repository URL]

**Project Structure:**
```
bits_assignment_flutter_task_manager_app_with_back4app/
├── lib/
├── README.md
├── pubspec.yaml
└── PRESENTATION.md
```

**Contact Information:**
- Email: [Your Email]
- GitHub: [Your GitHub Profile]
- LinkedIn: [Your LinkedIn]

**Technologies Used:**
- Flutter 3.9.2
- Dart SDK
- Back4App (Parse Server)
- Neumorphic Design

**Special Thanks:**
- BITS Pilani
- Back4App Team
- Flutter Community

---

# End of Presentation
