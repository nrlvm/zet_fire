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
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String myPhone = '';

  @override
  void initState() {
    getPhoneNum();
    super.initState();
  }

  getPhoneNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myPhone = prefs.getString('phone_number') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: [
        HomeScreen(
          phone: myPhone,
          change: (int id) {
            _selectedIndex = id;
            setState(() {});
          },
        ),
        const ExploreScreen(),
        const UploadScreen(),
        const AllChatsScreen(),
        MyProfileScreen(
          phoneMe: myPhone,
        ),
      ][_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _selectedIndex = 2;
          setState(() {});
        },
        child: Icon(
          Icons.add,
          size: 28 * h,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              label: '',
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
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: SizedBox(),
              label: '',
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
              label: '',
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
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
