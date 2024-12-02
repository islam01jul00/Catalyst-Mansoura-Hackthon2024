import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdg_app/core/utils/assets.dart';
import 'package:gdg_app/core/utils/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AssetsManager.homeHeader,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Welcome user!\nHow are you feeling today?',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white, // Lighter blue
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                          color: const Color.fromARGB(255, 203, 203, 203)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Personality : Logistician \nTraits : ISTJ-A',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              // Define the start button action here.
                            },
                            child: CircleAvatar(
                              radius: 39.r,
                              backgroundColor: ColorManager.primaryColor,
                              child: CircleAvatar(
                                radius: 35.r,
                                backgroundColor: Colors.white,
                                child: Text(
                                  "Start\n Now",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorManager.blackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFeatureCard(
                          'The disorder you \nare suffering from.',
                          AssetsManager.home1),
                      _buildFeatureCard('Discover your\nPersonality type.',
                          AssetsManager.home2),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Personality Traits',
                    style: TextStyle(
                      fontSize: 20.sp, // Increased the font size here
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildEnhancedProgressBar('Energy', 56, 'Extraverted',
                      'Introverted', Colors.blue), // Changed color
                  _buildEnhancedProgressBar('Mind', 51, 'Intuitive',
                      'Observant', Colors.purple), // Changed color
                  _buildEnhancedProgressBar('Nature', 63, 'Thinking', 'Feeling',
                      Colors.green), // Changed color
                  _buildEnhancedProgressBar('Tactics', 53, 'Judging',
                      'Prospecting', Colors.red), // Changed color
                  _buildEnhancedProgressBar('Identity', 57, 'Assertive',
                      'Turbulent', Colors.teal), // Changed color
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            activeIcon: Icon(Icons.home, color: ColorManager.primaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            activeIcon: Icon(Icons.chat, color: ColorManager.primaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Types',
            activeIcon: Icon(Icons.person, color: ColorManager.primaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
            activeIcon: Icon(Icons.settings, color: ColorManager.primaryColor),
          ),
        ],
        selectedItemColor: ColorManager.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        elevation: 5,
      ),
    );
  }

  Widget _buildFeatureCard(String title, String image) {
    return Column(
      children: [
        Container(
            width: 80.w,
            height: 80.h,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Image.asset(image)),
        SizedBox(height: 10.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedProgressBar(
      String title, int value, String start, String end, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '$title : ',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '$start',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.blackColor,
                  ),
                ),
              ],
            ),
            Text(
              '$value%',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        LinearProgressIndicator(
          value: value / 100,
          color: color,
          backgroundColor: Colors.grey.shade300,
          minHeight: 8.h,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
