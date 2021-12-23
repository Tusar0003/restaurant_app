import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/mvvm_builder.widget.dart';
import 'package:pmvvm/views/stateless.view.dart';
import 'package:restaurant_app/models/item.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/item_details_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class ItemDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => ItemDetailsPageView(),
      viewModel: ItemDetailsViewModel(ModalRoute.of(context)?.settings.arguments as Item)
    );
  }
}

// ignore: must_be_immutable
class ItemDetailsPageView extends StatelessView<ItemDetailsViewModel> {

  late BuildContext context;
  late ItemDetailsViewModel viewModel;

  @override
  Widget render(BuildContext context, ItemDetailsViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        floatingActionButton: floatingActionButton(),
        body: body(),
      )
    );
  }

  floatingActionButton() {
    return FloatingActionButton.extended(
      backgroundColor: ColorHelper.PRIMARY_COLOR,
      icon: viewModel.cartItemNumber > 0 ? floatingActionIcon() : null,
      label: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (Widget widget, Animation<double> animation) =>
            FadeTransition(
              opacity: animation,
              child: SizeTransition(
                child: widget,
                sizeFactor: animation,
                axis: Axis.horizontal,
              ),
            ) ,
        child: viewModel.cartItemNumber > 0 ?
        floatingActionText() :
        floatingActionIcon(),
      ),
      onPressed: () async {
        if (viewModel.cartItemNumber > 0) {
          await Navigator.pushNamed(context, AppRoute.CART);
          viewModel.getCartItemNumber();
        } else {
          showEmptyCartDialog();
        }
      },
    );
  }

  floatingActionIcon() {
    return Icon(
      Icons.shopping_bag_outlined,
      color: Colors.black,
      size: Constants.SMALL_ICON_SIZE,
    );
  }

  floatingActionText() {
    return Text(
      '${viewModel.cartItemNumber} Item/s',
      style: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: Constants.SMALL_FONT_SIZE,
          color: Colors.black
      ),
    );
  }

  body() {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Constants.MEDIUM_RADIUS),
                      bottomRight: Radius.circular(Constants.MEDIUM_RADIUS)
                  ),
                  child: FadeInImage(
                    image: NetworkImage(ApiServices.BASE_URL + '${viewModel.item.imagePath!}'),
                    placeholder: AssetImage('assets/images/place_holder.jpg'),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    // height: Constants.MEDIUM_HEIGHT,
                  ),
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
                        viewModel.item.itemName!,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: Constants.LARGE_FONT_SIZE,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(
                        height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                      ),
                      Text(
                        viewModel.item.description!,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: Constants.MEDIUM_FONT_SIZE,
                        ),
                      ),
                      SizedBox(
                        height: Constants.EXTRA_SMALL_HEIGHT,
                      ),
                      bottomLayout(),
                    ],
                  ),
                )
            ),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: Constants.EXTRA_SMALL_WIDTH,
            height: Constants.EXTRA_SMALL_HEIGHT,
            margin: EdgeInsets.only(
              top: 40,
              left: Constants.MEDIUM_PADDING
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(Constants.LARGE_RADIUS)
              ),
              color: Colors.white
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: Constants.SMALL_ICON_SIZE,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  bottomLayout() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: Constants.EXTRA_SMALL_HEIGHT,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Constants.SMALL_RADIUS)
                  ),
                  color: Colors.grey.shade300
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                          Icons.remove
                      ),
                      onPressed: () {
                        viewModel.decrementQuantity();
                      }
                  ),
                  Spacer(),
                  Text(
                    viewModel.quantity.toString(),
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: Constants.MEDIUM_FONT_SIZE,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(
                          Icons.add
                      ),
                      onPressed: () {
                        viewModel.incrementQuantity();
                      }
                  )
                ],
              ),
            )
          ),
          SizedBox(
            width: Constants.EXTRA_EXTRA_SMALL_WIDTH,
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: Constants.EXTRA_SMALL_HEIGHT,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Text(
                      Constants.ADD_TO_CART,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: Constants.SMALL_FONT_SIZE,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${viewModel.price} TK',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: Constants.SMALL_FONT_SIZE,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(
                    top: Constants.SMALL_PADDING,
                    bottom: Constants.SMALL_PADDING,
                    left: Constants.STANDARD_PADDING,
                    right: Constants.STANDARD_PADDING
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Constants.SMALL_RADIUS)
                  ),
                  primary: Colors.black
                ),
                onPressed: () {
                  viewModel.addToCart();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  showEmptyCartDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      headerAnimationLoop: false,
      dismissOnTouchOutside: false,
      title: Constants.CART,
      desc: 'Your cart is empty!',
      btnOkText: Constants.OK,
      btnOkOnPress: () {},
    ).show();
  }
}
