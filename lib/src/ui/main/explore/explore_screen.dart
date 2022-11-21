import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zet_fire/src/bloc/explore_bloc.dart';
import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/ui/main/single_lenta/single_lenta_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';
import 'package:zet_fire/src/colors/app_color.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    exploreBloc.allExploreLenta();
    super.initState();
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
          'Explore',
          style: TextStyle(
            fontFamily: AppColor.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28 * h,
            color: AppColor.dark,
          ),
        ),
      ),
      body: StreamBuilder<List<LentaModel>>(
        stream: exploreBloc.getExploreLenta,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<LentaModel> data = snapshot.data!;
            data.removeWhere((element) => element.contentType == 'video');
            return MasonryGridView.count(
              padding: EdgeInsets.only(
                left: 12 * w,
                right: 12 * w,
                top: 12 * h,
              ),
              itemCount: data.length,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleLentaScreen(
                          data: data[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 12) / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: data[index].contentType != 'video'
                        ? CustomNetworkImage(
                            image: data[index].url,
                            boxFit: BoxFit.fitWidth,
                            borderRadius: BorderRadius.circular(8),
                          )
                        : Container(
                            height:
                                (MediaQuery.of(context).size.width - 12) / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.grey.withOpacity(0.45),
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              size: 36,
                            ),
                          ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: SizedBox(
                height: 36 * h,
                width: 36 * h,
                child: const CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
