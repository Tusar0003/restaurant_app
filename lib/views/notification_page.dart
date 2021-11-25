import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/home_view_model.dart';


class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => NotificationPageView(),
      viewModel: HomeViewModel(),
    );
  }
}

// ignore: must_be_immutable
class NotificationPageView extends StatelessView<HomeViewModel> {

  late BuildContext context;

  @override
  Widget render(BuildContext context, HomeViewModel viewModel) {
    this.context = context;

    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  appBar() {
    return AppBar(
      title: Text(
        Constants.NOTIFICATIONS,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500
        ),
      ),
      backgroundColor: ColorHelper.TRANSPARENT_COLOR,
      elevation: 0,
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(Constants.STANDARD_PADDING),
      child: itemListView(),
    );
  }

  itemListView() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: singleItem(),
          onTap: () {},
        );
      },
    );
  }

  singleItem() {
    return Container(
        width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.only(bottom: Constants.STANDARD_PADDING),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: Constants.MEDIUM_RADIUS,
                  backgroundColor: Colors.black,
                  child: ClipOval(
                    child: Image(
                      image: AssetImage('assets/images/notification.png'),
                      height: Constants.MY_ORDER_IMAGE_SIZE,
                      width: Constants.MY_ORDER_IMAGE_SIZE,
                    ),
                  ),
                ),
                SizedBox(
                  width: Constants.EXTRA_EXTRA_SMALL_WIDTH,
                ),
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Item Name',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: Constants.MEDIUM_FONT_SIZE,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )
                        ),
                        SizedBox(
                          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                        ),
                        Text(
                            'It is a long established fact that a reader will be '
                                'distracted by the readable content of a page when looking at its layout',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: Constants.SMALL_FONT_SIZE,
                              color: Colors.black,
                            )
                        ),
                      ],
                    )
                ),
                // SizedBox(
                //   width: Constants.EXTRA_EXTRA_SMALL_WIDTH,
                // ),
                // Expanded(
                //     flex: 1,
                //     child: IconButton(
                //       icon: Icon(
                //         Icons.navigate_next_outlined,
                //       ),
                //       onPressed: () {
                //         showDetails();
                //       },
                //     ),
                // )
              ],
            ),
            Divider()
          ],
        )
    );
  }

  showDetails() {
    showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Material(
        child: Container(
          height: Constants.EXTRA_EXTRA_LARGE_HEIGHT,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: FadeInImage(
                        image: NetworkImage(Constants.DEMO_PIZZA_LINK),
                        placeholder: AssetImage('assets/images/place_holder.jpg'),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        // height: Constants.MEDIUM_HEIGHT,
                      )
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        padding: EdgeInsets.all(Constants.STANDARD_PADDING),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Item Name',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: Constants.LARGE_FONT_SIZE,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(
                              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Order Type: ',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: Constants.MEDIUM_FONT_SIZE,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  'Home Delivery',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: Constants.MEDIUM_FONT_SIZE,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${Constants.QUANTITY}: ',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: Constants.MEDIUM_FONT_SIZE,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  '3',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: Constants.MEDIUM_FONT_SIZE,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${Constants.UNIT_PRICE}: ',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: Constants.MEDIUM_FONT_SIZE,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  '${Constants.TK_SYMBOL}100',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: Constants.MEDIUM_FONT_SIZE,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${Constants.DELIVERY_CHARGE}: ',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: Constants.MEDIUM_FONT_SIZE,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  '${Constants.TK_SYMBOL}30',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: Constants.MEDIUM_FONT_SIZE,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${Constants.TOTAL_PRICE}: ',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: Constants.MEDIUM_FONT_SIZE,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  '${Constants.TK_SYMBOL}330',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: Constants.MEDIUM_FONT_SIZE,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: ColorHelper.PRIMARY_COLOR,
                      shape: CircleBorder(
                          side: BorderSide(
                              color: Colors.transparent
                          )
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.clear_thick,
                      color: Colors.black,
                      size: Constants.EXTRA_SMALL_ICON_SIZE,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
