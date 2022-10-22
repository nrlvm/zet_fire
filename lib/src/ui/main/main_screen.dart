import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/ui/main/chats/all_chats_screen.dart';
import 'package:zet_fire/src/ui/main/explore/explore_screen.dart';
import 'package:zet_fire/src/ui/main/home/home_screen.dart';
import 'package:zet_fire/src/ui/main/profile/profile_screen.dart';
import 'package:zet_fire/src/ui/main/upload/upload_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

int _selectedIndex = 0;
String phoneNumber = '';

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    getPhoneNum();
    super.initState();
  }

  getPhoneNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString('phone_number') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    return Scaffold(
      body: [
        HomeScreen(
          change: (int id) {
            _selectedIndex = id;
            setState(() {});
          },
        ),
        const ExploreScreen(),
        const UploadScreen(),
        const AllChatsScreen(),
        ProfileScreen(
          phone: phoneNumber,
          main: true,
        ),
      ][_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 96 * h,
        width: MediaQuery.of(context).size.width,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontSize: 0 * h,
            color: Colors.transparent,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 0 * h,
            color: Colors.transparent,
          ),
          onTap: (index) {
            _selectedIndex = index;
            // k = true;
            setState(() {});
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/bottom_icon/home.svg',
                    color: _selectedIndex == 0 ? AppColor.dark : AppColor.grey,
                  ),
                  SizedBox(
                    height: 8 * h,
                  ),
                  _selectedIndex == 0
                      ? Container(
                          height: 6 * h,
                          width: 6 * h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.blue,
                          ),
                        )
                      : SizedBox(
                          height: 6 * h,
                        ),
                ],
              ),
              label: 'asd',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/bottom_icon/send.svg',
                    color: _selectedIndex == 1 ? AppColor.dark : AppColor.grey,
                  ),
                  SizedBox(
                    height: 8 * h,
                  ),
                  _selectedIndex == 1
                      ? Container(
                          height: 6 * h,
                          width: 6 * h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.blue,
                          ),
                        )
                      : SizedBox(
                          height: 6 * h,
                        ),
                ],
              ),
              label: 'asd',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/bottom_icon/plus.svg',
                    color: _selectedIndex == 2 ? AppColor.dark : AppColor.grey,
                  ),
                  SizedBox(
                    height: 8 * h,
                  ),
                  _selectedIndex == 2
                      ? Container(
                          height: 6 * h,
                          width: 6 * h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.blue,
                          ),
                        )
                      : SizedBox(
                          height: 6 * h,
                        ),
                ],
              ),
              label: 'asd',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/bottom_icon/chat.svg',
                    color: _selectedIndex == 3 ? AppColor.dark : AppColor.grey,
                  ),
                  SizedBox(
                    height: 8 * h,
                  ),
                  _selectedIndex == 3
                      ? Container(
                          height: 6 * h,
                          width: 6 * h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.blue,
                          ),
                        )
                      : SizedBox(
                          height: 6 * h,
                        ),
                ],
              ),
              label: 'asd',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/bottom_icon/home.svg',
                    color: _selectedIndex == 4 ? AppColor.dark : AppColor.grey,
                  ),
                  SizedBox(
                    height: 8 * h,
                  ),
                  _selectedIndex == 4
                      ? Container(
                          height: 6 * h,
                          width: 6 * h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.blue,
                          ),
                        )
                      : SizedBox(
                          height: 6 * h,
                        ),
                ],
              ),
              label: 'asd',
            ),
          ],
        ),
      ),
    );
  }
}
