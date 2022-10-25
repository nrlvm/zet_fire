import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/bloc/lenta_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/ui/main/profile/profile_screen.dart';
import 'package:zet_fire/src/ui/main/profile/user_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/shimmer.dart';
import 'package:zet_fire/src/widget/lenta/lenta_widget.dart';

class HomeScreen extends StatefulWidget {
  final Function(int id) change;

  const HomeScreen({Key? key, required this.change}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String myPhoneNumber = '';

  @override
  void initState() {
    lentaBloc.allLenta();
    getMyPhone();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getMyPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myPhoneNumber = prefs.getString('phone_number') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppColor.screen,
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        elevation: 1,
        centerTitle: false,
        title: Text(
          'Home',
          style: TextStyle(
            fontFamily: AppColor.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28 * h,
            color: AppColor.dark,
          ),
        ),
        actions: [
          SvgPicture.asset(
            'assets/icons/bell_i.svg',
          ),
          SizedBox(
            width: 16 * w,
          ),
        ],
      ),
      body: StreamBuilder<List<LentaModel>>(
        stream: lentaBloc.getLenta,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<LentaModel> data = snapshot.data!;
            return ListView(
              children: [
                SizedBox(
                  height: 148 * h,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return LentaWidget(
                      data: data[index],
                      onTap: () {
                        if (data[index].userPhone == myPhoneNumber) {
                          widget.change(4);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserScreen(
                                userPhoneNumber: data[index].userPhone,
                                myPhoneNumber: myPhoneNumber,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            );
          } else {
            return CustomShimmer(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              borderRadius: 16,
              horizontalMargin: 16 * w,
              verticalMargin: 16 * h,
            );
          }
        },
      ),
    );
  }
}
