import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/models/notification.dart' as Model;
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/notificatoin_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => NotificationPageView(),
      viewModel: NotificationViewModel(),
    );
  }
}

// ignore: must_be_immutable
class NotificationPageView extends StatelessView<NotificationViewModel> {

  late BuildContext context;
  late NotificationViewModel viewModel;

  @override
  Widget render(BuildContext context, NotificationViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        appBar: Widgets().appBar(Constants.NOTIFICATIONS),
        body: body(),
      )
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(Constants.STANDARD_PADDING),
      child: RefreshIndicator(
        color: ColorHelper.PRIMARY_COLOR,
        onRefresh: () async {
          viewModel.getNotificationList();
        },
        child: viewModel.isNotificationDataFound ? notificationListView() : Widgets().noItem(context),
      ),
    );
  }

  notificationListView() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: viewModel.notificationList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: singleNotification(viewModel.notificationList[index]),
            onTap: () {},
          );
        },
      ),
    );
  }

  singleNotification(Model.Notification notification) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/notification.png'),
                  fit: BoxFit.fill,
                  height: Constants.EXTRA_SMALL_HEIGHT,
                  width: Constants.EXTRA_SMALL_WIDTH,
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
                            notification.title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: Constants.MEDIUM_FONT_SIZE,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )
                        ),
                        SizedBox(
                          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                        ),
                        Text(
                            notification.body!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: Constants.SMALL_FONT_SIZE,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            )
                        ),
                      ],
                    )
                ),
                SizedBox(
                  width: Constants.EXTRA_EXTRA_SMALL_WIDTH,
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next_outlined,
                    ),
                    onPressed: () {
                      showDetails(notification);
                    },
                  ),
                )
              ],
            ),
            Divider()
          ],
        )
    );
  }

  showDetails(Model.Notification notification) {
    showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Material(
        child: Container(
          height: Constants.EXTRA_LARGE_HEIGHT,
          child: Stack(
            children: [
              notificationDetails(notification),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  notificationDetails(Model.Notification notification) {
    return Container(
      padding: EdgeInsets.all(Constants.STANDARD_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Constants.NOTIFICATION,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Constants.LARGE_FONT_SIZE,
                fontWeight: FontWeight.w600
            ),
          ),
          Divider(),
          Text(
            notification.title!,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Constants.MEDIUM_FONT_SIZE,
                fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(
            height: Constants.MEDIUM_PADDING,
          ),
          Text(
            notification.body!,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: Constants.MEDIUM_FONT_SIZE,
            ),
          ),
        ],
      ),
    );
  }
}
