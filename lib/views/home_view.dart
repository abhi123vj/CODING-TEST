import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/controller/news_controller.dart';
import 'package:instagram/provider/insta_provider.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final feedController = Get.put(NewsCntroller());
  final _iconHeight = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'lib/assets/images/logo.png',
              ),
            )),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => Get.toNamed("/saved"),
              child: SvgPicture.asset(
                feedController.bookmrk,
                height: _iconHeight,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Consumer<InstaProvider>(builder: (context, model, _) {
          return FutureBuilder(
              future: model.fetchData(),
              builder: (context, snapshot) => ListView.builder(
                  itemCount: feedController.listViewData.length <= 30
                      ? feedController.listViewData.length
                      : 30,
                  itemBuilder: (context, int index) {
                    var active = 'lib/assets/images/like.svg'.obs;

                    return Container(
                      color: bgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    backgroundColor: Vx.randomPrimaryColor,
                                    foregroundColor: Vx.randomOpaqueColor,
                                    child: Icon(EvaIcons.people),
                                  ),
                                ),
                                Text(feedController.listViewData[index]
                                    ['channelname']),
                              ],
                            ),
                          ),
                          Divider(
                            height: .05,
                          ),
                          Container(
                            child: ProgressiveImage(
                              placeholder: NetworkImage(feedController
                                  .listViewData[index]['low thumbnail']),
                              // size: 1.87KB
                              thumbnail: NetworkImage(feedController
                                  .listViewData[index]['medium thumbnail']),
                              // size: 1.29MB
                              image: NetworkImage(feedController
                                  .listViewData[index]['high thumbnail']),
                              height: 300,
                              width: 500,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Obx(() {
                                  return GestureDetector(
                                    onTap: () {
                                      if (active.value == feedController.like)
                                        active.value = feedController.likefill;
                                      else
                                        active.value = feedController.like;
                                    },
                                    child: SvgPicture.asset(
                                      active.value,
                                      height: _iconHeight,
                                    ),
                                  );
                                }),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Get.toNamed("/cmnts", parameters: {
                                    "username": feedController
                                        .listViewData[index]['channelname'],
                                    "title": feedController.listViewData[index]
                                        ['title'],
                                  }),
                                  child: SvgPicture.asset(
                                    feedController.cmnt,
                                    height: _iconHeight,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  feedController.share,
                                  height: _iconHeight,
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    try {
                                      // Saved with this method.
                                      var imageId =
                                          await ImageDownloader.downloadImage(
                                              feedController.listViewData[index]
                                                  ['high thumbnail']);
                                      if (imageId == null) {
                                        return;
                                      }

                                      // Below is a method of obtaining saved image information.
                                      // var fileName =
                                      //     await ImageDownloader.findName(
                                      //         imageId);
                                      // var path = await ImageDownloader.findPath(
                                      //     imageId);
                                      // var size =
                                      //     await ImageDownloader.findByteSize(
                                      //         imageId);
                                      // var mimeType =
                                      //     await ImageDownloader.findMimeType(
                                      //         imageId);
                                        } on PlatformException catch (error) {
                                      Get.snackbar("Error!", error.toString());
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    feedController.bookmrk,
                                    height: _iconHeight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ReadMoreText(
                              feedController.listViewData[index]['title'],
                              style: GoogleFonts.robotoMono(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 16,
                                color: textColor,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                              ),
                              trimLength: 50,
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Length,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              moreStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                              onTap: () => Get.toNamed("/cmnts", parameters: {
                                    "username": feedController
                                        .listViewData[index]['channelname'],
                                    "title": feedController.listViewData[index]
                                        ['title'],
                                  }),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "view comments",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Vx.gray500),
                                ),
                              ))
                        ],
                      ),
                    );
                  }));
        }),
      ),
    );
  }
}
