# Task Manager App - Flutter with Back4App

A Flutter-based Task Manager Application that utilizes Back4App as a Backend-as-a-Service (BaaS) for user authentication and task management with real-time cloud database syncing.

## Project Overview

This project demonstrates a complete CRUD application with user authentication, built using Flutter for the frontend and Back4App (Parse Server) for the backend. Users can register, login, create tasks, update them, mark them as complete, and delete them - all synced in real-time with the cloud database.

## Features

- **User Authentication**
  - Register new account with email
  - Login with existing credentials
  - Secure session management
  - Logout functionality

- **Task Management (CRUD Operations)**
  - Create new tasks with title and description
  - Read/View all tasks in a list
  - Update existing tasks
  - Delete tasks with confirmation
  - Mark tasks as complete/incomplete
  - Pull-to-refresh for real-time sync

- **Cloud Backend (Back4App)**
  - No custom backend code required
  - Real-time database synchronization
  - Secure user data storage
  - Automatic data persistence

- **Skeuomorphic UI Design**
  - Realistic 3D neumorphic effects
  - Depth and shadow on all interactive elements
  - Tactile button designs that appear pressed/raised
  - Smooth animations and transitions
  - Beautiful Poppins font throughout
  - Inset text fields with realistic depth
  - Raised cards with proper lighting
  - Concave/convex shapes for visual interest

## Technology Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Back4App (Parse Server)
- **Database**: Back4App Cloud Database
- **SDK**: parse_server_sdk_flutter ^9.0.0
- **UI Design**: Skeuomorphism with Neumorphic Design
- **UI Packages**:
  - flutter_neumorphic ^3.2.0 (3D realistic UI effects)
  - google_fonts ^4.0.4 (Poppins font family)
  - glassmorphism ^3.0.0 (Glass effects)

## Project Structure

```
lib/
├── main.dart                          # App entry point & Back4App initialization
├── models/
│   └── task.dart                      # Task model with Parse object
├── screens/
│   ├── login_screen.dart              # User login interface
│   ├── register_screen.dart           # User registration interface
│   ├── task_list_screen.dart          # Main task list with CRUD operations
│   └── add_edit_task_screen.dart      # Create/Update task form
```

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Back4App account (free tier available)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd bits_assignment_flutter_task_manager_app_with_back4app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Update Back4App credentials in `lib/main.dart` (lines 10-12):
```dart
const keyApplicationId = 'YOUR_APP_ID';
const keyClientKey = 'YOUR_CLIENT_KEY';
const keyParseServerUrl = 'https://parseapi.back4app.com';
```

4. Run the app:
```bash
flutter run
```

## Back4App Setup

1. Create a free account at [Back4App](https://www.back4app.com/)
2. Create a new app
3. Get your Application ID and Client Key from:
   - App Dashboard > App Settings > Security & Keys
4. The Task class will be automatically created in Back4App database when you create your first task

## App Flow

1. **Authentication**
   - App checks for existing user session
   - If not logged in, shows Login screen
   - User can register a new account or login
   - After successful authentication, navigates to Task List

2. **Task Management**
   - View all tasks in a scrollable list
   - Tap (+) button to create new task
   - Tap task checkbox to toggle completion status
   - Tap edit icon to update task
   - Tap delete icon to remove task (with confirmation)
   - Pull down to refresh and sync with server
   - Tap logout icon to sign out

## Key Screens

### 1. Login Screen
- Beautiful skeuomorphic design with 3D circular logo
- Inset text fields with realistic depth
- Raised login button with depth effect
- Email and password authentication
- Password visibility toggle
- Form validation with error messages
- Navigation to register screen
- Automatic navigation to task list on success

### 2. Register Screen
- Neumorphic app bar with back button
- 3D concave icon design
- New user registration with email
- Password and confirm password fields
- Password visibility toggles
- Password confirmation validation
- Minimum 6 character password requirement
- Success dialog with smooth animations
- Automatic login after successful registration

### 3. Task List Screen
- Neumorphic app bar with raised action buttons
- 3D task cards with depth effects
- Completed tasks appear pressed inward
- Neumorphic checkboxes for task completion
- Displays all user tasks in card format
- Real-time sync with Back4App
- Pull-to-refresh functionality
- Raised edit and delete buttons on each task
- Empty state with 3D concave icon
- Neumorphic floating action button
- Logout option with confirmation dialog

### 4. Add/Edit Task Screen
- Neumorphic app bar with contextual icon
- Info card with helpful message
- Labeled inset text fields with depth
- Title field (required, max 100 characters)
- Description field (optional, max 500 characters)
- Real-time character counters
- Form validation with error messages
- Large raised save button with icon
- Secondary cancel button
- Success/error dialogs with neumorphic buttons
- Save to Back4App database

## Features Demonstration

The app demonstrates:
- Backend-as-a-Service (BaaS) integration
- User authentication with cloud backend
- CRUD operations with real-time database
- Secure session management
- **Skeuomorphic Design** with realistic 3D effects
- Neumorphic UI components with depth and shadows
- Modern typography with Google Fonts (Poppins)
- Form validation
- Error handling
- Loading states with neumorphic progress indicators
- Responsive design
- Smooth animations and transitions

## Security Features

- Secure password storage (handled by Back4App)
- User session management
- User-specific data access (ACL)
- HTTPS communication with Back4App
- Input validation and sanitization

## Database Schema

### Task Object (Back4App)
- `objectId`: Unique task identifier (auto-generated)
- `title`: Task title (String, required)
- `description`: Task description (String, optional)
- `isCompleted`: Completion status (Boolean, default: false)
- `createdBy`: Task owner (Pointer to User)
- `createdAt`: Creation timestamp (auto-generated)
- `updatedAt`: Last update timestamp (auto-generated)

## Development Notes

- The app uses **Skeuomorphic/Neumorphic Design** for a modern, tactile UI
- Neumorphic theme with customizable depth, intensity, and light source
- Base color: #E0E5EC for light mode, #2E3239 for dark mode
- Light source positioned at top-left for consistent shadows
- Poppins font family from Google Fonts throughout the app
- Depth values: -6 to -3 for inset elements, 4-8 for raised elements
- Debug mode is enabled for Parse SDK during development
- Auto session ID is enabled for seamless user experience
- ACL is automatically set by Back4App for user-specific data

## Design Philosophy - Skeuomorphism

This app embraces **Skeuomorphism** - a design style that makes digital elements look like their physical counterparts with:

- **Realistic Textures**: Soft, subtle gradients that mimic real materials
- **Depth and Shadows**: Multi-layered shadows creating 3D illusion
- **Tactile Buttons**: Buttons that appear raised or pressed when interacted
- **Physical Metaphors**: UI elements that resemble real-world objects
- **Light and Shadow**: Consistent light source creating realistic depth perception

The neumorphic design creates a soft, modern take on skeuomorphism that's both beautiful and functional.

## Learning Outcomes

This project demonstrates:
- Integration of Flutter with Backend-as-a-Service
- User authentication implementation
- CRUD operations in mobile applications
- State management with StatefulWidget
- Navigation between screens
- Form handling and validation
- Asynchronous programming in Dart
- Cloud database integration
- Real-time data synchronization

## Deliverables

1. **YouTube Video** (2 minutes)
   - Demo: Login, register, create task, update, delete, logout

2. **GitHub Repository**
   - Complete source code
   - README documentation
   - Screenshots

3. **PPT Presentation**
   - Project overview
   - Features explanation
   - Technology stack
   - Key learnings

## License

This project is created for educational purposes as part of BITS assignment.

## Support

For issues or questions:
- Check Back4App documentation: https://docs.back4app.com/
- Flutter documentation: https://docs.flutter.dev/
- Parse SDK documentation: https://pub.dev/packages/parse_server_sdk_flutter
