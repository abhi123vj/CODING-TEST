import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/controller/bookmark_controller.dart';
import 'package:instagram/controller/news_controller.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';

class SavedViews extends StatelessWidget {
  SavedViews({Key? key}) : super(key: key);
  final bookMarkController = Get.put(BookMarkController());
  final feedController = Get.put(NewsCntroller());
  final _iconHeight = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        title: Text(
          "Bookmarks",
          style: GoogleFonts.robotoMono(
            textStyle: Theme.of(context).textTheme.headline6,
            fontWeight: FontWeight.bold,
            color: textColor,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: Container(
        child: bookMarkController.feedlist.length > 0
            ? Obx(()=>ListView.builder(
                itemCount: bookMarkController.feedlist.length,
                itemBuilder: (BuildContext context, int index) {
                  var likeActive = 'lib/assets/images/like.svg'.obs;
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
                                  foregroundColor: Vx.pink100,
                                  child: Icon(EvaIcons.people),
                                ),
                              ),
                              Text(bookMarkController
                                  .feedlist[index].channelname),
                            ],
                          ),
                        ),
                        Divider(
                          height: .05,
                        ),
                        Container(
                          child: bookMarkController.dispimg(
                              bookMarkController.feedlist[index].localpath),
                          height: 300,
                          width: 500,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Obx(() {
                                return GestureDetector(
                                  onTap: () {
                                    if (likeActive.value == feedController.like)
                                      likeActive.value = feedController.likefill;
                                    else
                                      likeActive.value = feedController.like;
                                  },
                                  child: SvgPicture.asset(
                                    likeActive.value,
                                    height: _iconHeight,
                                  ),
                                );
                              }),
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                feedController.cmnt,
                                height: _iconHeight,
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
                                onTap: () {
                                 //  bookMarkController.rembook(index);
                                },
                                child: SvgPicture.asset(
                                   feedController.bookmrkfill,
                                   color: likecolor,
                                  height: _iconHeight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ReadMoreText(
                              bookMarkController.feedlist[index].title,
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
                      ],
                    ),
                  );
                }))
            : Center(
                child: Text("No data"),
              ),
      ),
    );
  }
}
