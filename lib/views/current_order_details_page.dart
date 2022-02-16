import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pmvvm/mvvm_builder.widget.dart';
import 'package:pmvvm/views/stateless.view.dart';
import 'package:restaurant_app/models/current_order.dart';
import 'package:restaurant_app/models/item.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/item_details_view_model.dart';
import 'package:restaurant_app/viewmodels/current_order_details_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


// ignore: must_be_immutable
class CurrentOrderDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => CurrentOrderDetailsPageView(),
      viewModel: CurrentOrderDetailsViewModel(ModalRoute.of(context)?.settings.arguments as CurrentOrder)
    );
  }
}

// ignore: must_be_immutable
class CurrentOrderDetailsPageView extends StatelessView<CurrentOrderDetailsViewModel> {

  late BuildContext context;
  late CurrentOrderDetailsViewModel viewModel;

  @override
  Widget render(BuildContext context, CurrentOrderDetailsViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        appBar: Widgets().appBar(Constants.ORDER_DETAILS),
        body: body(),
      )
    );
  }

  body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(Constants.STANDARD_PADDING),
      child: orderDetails(),
    );
  }

  orderDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
              viewModel.getLottie(),
              width: Constants.MEDIUM_WIDTH,
              height: Constants.MEDIUM_HEIGHT,
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
                viewModel.currentOrder.orderNo!,
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
                viewModel.getOrderStatus(),
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
                viewModel.currentOrder.orderType!,
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
                '${Constants.TK_SYMBOL} ${viewModel.currentOrder.deliveryCharge.toString()}',
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
                '${Constants.TOTAL_DISCOUNT}:',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.SMALL_FONT_SIZE,
                    fontWeight: FontWeight.w600
                ),
              ),
              Spacer(),
              Text(
                '${Constants.TK_SYMBOL} ${viewModel.currentOrder.totalDiscountAmount}',
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
                '${Constants.TK_SYMBOL} ${viewModel.currentOrder.totalPrice}',
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
              Constants.ITEMS,
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
    );
  }

  itemListView() {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: viewModel.currentOrder.items!.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: singleItem(viewModel.currentOrder.items![index]),
          onTap: () async {},
        );
      },
    );
  }

  singleItem(CurrentOrderItems currentOrderItem) {
    return Row(
      children: [
        Text(
          '${currentOrderItem.itemName} x${currentOrderItem.quantity}',
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: Constants.SMALL_FONT_SIZE,
              fontWeight: FontWeight.w600
          ),
        ),
        Spacer(),
        Text(
          '${Constants.TK_SYMBOL} ${currentOrderItem.subTotalPrice}',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: Constants.MEDIUM_FONT_SIZE,
          ),
        )
      ],
    );
  }
}
