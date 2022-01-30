import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/models/order_history.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/order_history_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class MyOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => MyOrderPageView(),
      viewModel: OrderHistoryViewModel(),
    );
  }
}

// ignore: must_be_immutable
class MyOrderPageView extends StatelessView<OrderHistoryViewModel> {

  late BuildContext context;
  late OrderHistoryViewModel viewModel;

  @override
  Widget render(BuildContext context, OrderHistoryViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        appBar: Widgets().appBar(Constants.MY_ORDERS),
        body: body(),
      )
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(Constants.STANDARD_PADDING),
      child: orderListView(),
    );
  }

  orderListView() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: viewModel.orderHistoryList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: singleOrder(viewModel.orderHistoryList[index]),
          onTap: () {},
        );
      },
    );
  }

  singleOrder(OrderData orderData) {
    return Container(
        width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.only(bottom: Constants.STANDARD_PADDING),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(Constants.LARGE_RADIUS),
                  child: Image(
                    image: AssetImage('assets/images/order_history.png'),
                    fit: BoxFit.fill,
                    height: Constants.MY_ORDER_IMAGE_SIZE,
                    width: Constants.MY_ORDER_IMAGE_SIZE,
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
                            orderData.orderNo!,
                            maxLines: 1,
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
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(Constants.SMALL_PADDING),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Constants.SMALL_RADIUS)
                                  ),
                                  color: Colors.grey.shade300
                              ),
                              child: Text(
                                  '${orderData.totalPrice} tk',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: Constants.SMALL_FONT_SIZE,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(
                              width: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                            ),
                            Container(
                              padding: EdgeInsets.all(Constants.SMALL_PADDING),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Constants.SMALL_RADIUS)
                                  ),
                                  color: Colors.grey.shade300
                              ),
                              child: Text(
                                  viewModel.getOrderStatus(orderData),
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: Constants.SMALL_FONT_SIZE,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                            ),
                          ],
                        )
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
                      onPressed: () async {
                        await viewModel.setOrderData(orderData);
                        showDetails();
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

  showDetails() {
    showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Material(
        child: Container(
          height: 500,
          child: Stack(
            children: [
              detailsBody(),
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

  detailsBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(Constants.STANDARD_PADDING),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
                viewModel.getLottie(),
                width: Constants.SMALL_WIDTH,
                height: Constants.SMALL_HEIGHT,
                repeat: true
            ),
            SizedBox(
              height: Constants.MEDIUM_PADDING,
            ),
            Text(
              viewModel.orderStatus,
              style: GoogleFonts.poppins(
                  fontSize: Constants.LARGE_FONT_SIZE,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
            ),
            SizedBox(
              height: Constants.LARGE_PADDING,
            ),
            Row(
              children: [
                Text(
                  '${Constants.ORDER_NO}:',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text(
                  viewModel.orderData.orderNo!,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.MEDIUM_FONT_SIZE,
                  ),
                )
              ],
            ),
            SizedBox(
              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
            ),
            Row(
              children: [
                Text(
                  '${Constants.STATUS}:',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text(
                  viewModel.getOrderStatus(viewModel.orderData),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.MEDIUM_FONT_SIZE,
                  ),
                )
              ],
            ),
            SizedBox(
              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
            ),
            Row(
              children: [
                Text(
                  '${Constants.ORDER_TYPE}:',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text(
                  viewModel.orderData.orderType!,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.MEDIUM_FONT_SIZE,
                  ),
                )
              ],
            ),
            SizedBox(
              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
            ),
            Row(
              children: [
                Text(
                  '${Constants.DELIVERY_CHARGE}:',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text(
                  '${Constants.TK_SYMBOL} ${viewModel.orderData.deliveryCharge.toString()}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.MEDIUM_FONT_SIZE,
                  ),
                )
              ],
            ),
            SizedBox(
              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
            ),
            Row(
              children: [
                Text(
                  '${Constants.TOTAL_PRICE}:',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text(
                  '${Constants.TK_SYMBOL} ${viewModel.orderData.totalPrice}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.MEDIUM_FONT_SIZE,
                  ),
                )
              ],
            ),
            Divider(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Items',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.MEDIUM_FONT_SIZE,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            SizedBox(
              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
            ),
            itemListView()
          ],
        ),
      ),
    );
  }

  itemListView() {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: viewModel.orderData.items!.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: singleItem(viewModel.orderData.items![index]),
          onTap: () async {},
        );
      },
    );
  }

  singleItem(Items item) {
    return Row(
      children: [
        Text(
          '${item.itemName} x${item.quantity}',
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: Constants.SMALL_FONT_SIZE,
              fontWeight: FontWeight.w600
          ),
        ),
        Spacer(),
        Text(
          item.subTotalPrice.toString(),
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: Constants.MEDIUM_FONT_SIZE,
          ),
        )
      ],
    );
  }
}
