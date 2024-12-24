import 'package:flutter/material.dart';
import 'package:sms_app/screens/classes/class_list_screen.dart';
import 'package:sms_app/screens/students/multiple.dart';
import 'package:sms_app/screens/students/student_details.dart';
import 'package:sms_app/screens/teachers/add_teachers.dart';
import 'package:sms_app/screens/teachers/teachers_screen.dart';
import 'package:sms_app/widgets/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Dashboard'),
            const Spacer(),
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard Overview',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // Search bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search assignments, announcements...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle search button press
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Dashboard cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.2,
                children: [
                  DashboardCard(
                    title: 'Students',
                    description: 'Manage student profiles and records',
                    icon: Icons.person,
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentListScreen())),
                  ),
                  DashboardCard(
                    title: 'Teachers',
                    description: 'Access teacher profiles and schedules',
                    icon: Icons.school,
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherListScreen())),
                  ),
                  DashboardCard(
                    title: 'Classes',
                    description: 'View and manage class schedules',
                    icon: Icons.class_,
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClassListScreen())),
                  ),
                  DashboardCard(
                    title: 'Attendance',
                    description: 'Track and record attendance',
                    icon: Icons.calendar_today,
                    onTap: () => Navigator.pushNamed(context, '/attendance'),
                  ),
                  DashboardCard(
                    title: 'Fees',
                    description: 'Manage fee structures and payments',
                    icon: Icons.monetization_on,
                    onTap: () => Navigator.pushNamed(context, '/fees'),
                  ),
                  DashboardCard(
                    title: 'Exams',
                    description: 'Check and upload exam results',
                    icon: Icons.assignment,
                    onTap: () => Navigator.pushNamed(context, '/exams'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
