import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/models/promo_details.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/cart_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => CartPageView(),
      viewModel: CartViewModel()
    );
  }
}

// ignore: must_be_immutable
class CartPageView extends StatelessView<CartViewModel> {

  late BuildContext context;
  late CartViewModel viewModel;

  @override
  Widget render(BuildContext context, CartViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        appBar: Widgets().appBar(Constants.CART),
        body: body(),
      )
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(Constants.STANDARD_PADDING),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Constants.DESIRED_ITEMS,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.EXTRA_LARGE_FONT_SIZE,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(
                height: Constants.LARGE_PADDING,
              ),
              addedItemListView(),
              SizedBox(
                height: Constants.STANDARD_PADDING,
              ),
              Text(
                Constants.ORDER_TYPE,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.MEDIUM_FONT_SIZE,
                    fontWeight: FontWeight.w500
                ),
              ),
              orderTypeListView(),
              SizedBox(
                height: Constants.LARGE_PADDING,
              ),
              viewModel.isPromoCodeApplied ? promoCode() : applyPromoCode(),
              SizedBox(
                height: Constants.LARGE_PADDING,
              ),
              orderDetailsLayout(),
            ],
          ),
        )
      ),
    );
  }

  addedItemListView() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: viewModel.cartItemList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: singleItem(viewModel.cartItemList[index]),
          onTap: () {},
        );
      },
    );
  }

  singleItem(CartItem cartItem) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: Constants.EXTRA_SMALL_HEIGHT,
                width: Constants.EXTRA_SMALL_WIDTH,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Constants.LARGE_RADIUS)
                  ),
                  color: Colors.grey.shade300
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Constants.LARGE_RADIUS),
                  child: FadeInImage(
                    image: NetworkImage(
                      ApiServices.BASE_URL + '${cartItem.imagePath}',
                    ),
                    placeholder: AssetImage('assets/images/place_holder.jpg'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image(
                        image: AssetImage('assets/images/place_holder.jpg'),
                        fit: BoxFit.cover,
                        height: Constants.EXTRA_SMALL_HEIGHT,
                        width: Constants.EXTRA_SMALL_WIDTH,
                      );
                    },
                    fit: BoxFit.cover,
                    height: Constants.EXTRA_SMALL_HEIGHT,
                    width: Constants.EXTRA_SMALL_WIDTH,
                  ),
                ),
              ),
              SizedBox(
                width: Constants.EXTRA_EXTRA_SMALL_WIDTH,
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          cartItem.itemName!,
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
                      Container(
                        width: Constants.MEDIUM_WIDTH,
                        height: Constants.EXTRA_SMALL_HEIGHT,
                        padding: EdgeInsets.all(Constants.SMALL_PADDING),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(
                        //         Radius.circular(Constants.SMALL_RADIUS)
                        //     ),
                        //     color: Colors.grey.shade300
                        // ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    size: Constants.EXTRA_SMALL_ICON_SIZE,
                                  ),
                                  onPressed: () {
                                    viewModel.decrementQuantity(cartItem);
                                  }
                              ),
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.grey.shade300,
                            ),
                            Spacer(),
                            Text(
                              cartItem.quantity.toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: Constants.MEDIUM_FONT_SIZE,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Spacer(),
                            CircleAvatar(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    size: Constants.EXTRA_SMALL_ICON_SIZE,
                                  ),
                                  onPressed: () {
                                    viewModel.incrementQuantity(cartItem);
                                  }
                              ),
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.grey.shade300,
                            )
                          ],
                        )
                      ),
                    ],
                  )
              ),
              SizedBox(
                width: Constants.EXTRA_SMALL_PADDING,
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      TextButton(
                        child: Icon(
                          Icons.delete,
                          size: Constants.SMALL_ICON_SIZE,
                          color: Colors.red.shade700,
                        ),
                        onPressed: () {
                          showConfirmationDialog(cartItem);
                        },
                      ),
                      Text(
                          '${Constants.TK_SYMBOL}${cartItem.subTotalPrice}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: Constants.LARGE_FONT_SIZE,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          )
                      )
                    ],
                  ),
              )
            ],
          ),
          Divider()
        ],
      )
    );
  }

  orderTypeListView() {
    return Container(
      height: Constants.EXTRA_SMALL_HEIGHT,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.orderTypeList.length,
        itemBuilder: (BuildContext context, int index) => singleOrderType(index),
      ),
    );
  }

  singleOrderType(int index) {
    return Container(
      margin: EdgeInsets.only(right: Constants.SMALL_PADDING),
      child: ChoiceChip(
        padding: EdgeInsets.all(Constants.SMALL_PADDING),
        label: Text(
          viewModel.orderTypeList[index].orderType!,
          style: GoogleFonts.poppins(
            fontSize: Constants.SMALL_FONT_SIZE,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        selectedColor: ColorHelper.PRIMARY_COLOR,
        selected: viewModel.orderTypeIndex == index,
        onSelected: (bool selected) {
          viewModel.setOrderType(selected, index);
        },
      ),
    );
  }

  applyPromoCode() {
    return TextButton(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.card_giftcard,
            color: Colors.yellow.shade900,
          ),
          SizedBox(
            width: Constants.SMALL_PADDING,
          ),
          Text(
            Constants.APPLY_PROMO_CODE,
            style: GoogleFonts.poppins(
              color: Colors.yellow.shade900,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
      onPressed: () async {
        final result = await Navigator.pushNamed(context, AppRoute.APPLY_PROMO_CODE);

        if (result != null) {
          viewModel.setPromoDetails(result as PromoDetails);
        }
      }
    );
  }

  promoCode() {
    return Container(
      padding: EdgeInsets.all(Constants.MEDIUM_PADDING),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(Constants.EXTRA_EXTRA_SMALL_RADIUS)
        ),
        color: Colors.orange.shade100
      ),
      child: Row(
        children: [
          Icon(
            Icons.card_giftcard
          ),
          VerticalDivider(),
          Column(
            children: [
              Text(
                viewModel.promoCode.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: Constants.MEDIUM_FONT_SIZE,
                  fontWeight: FontWeight.w500
                ),
              ),
              ConstrainedBox(
                constraints:BoxConstraints(
                  minHeight: 10,
                  minWidth: 50
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Text(
                      Constants.REMOVE,
                      style: GoogleFonts.poppins(
                          fontSize: Constants.SMALL_FONT_SIZE,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    onTap: () {
                      viewModel.removePromoCode();
                    },
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(Constants.SMALL_PADDING),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(Constants.SMALL_RADIUS)
                ),
                color: Colors.grey.shade300
            ),
            child: Text(
                '${viewModel.promoDiscount} TK',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                  ),
                )
            ),
          )
        ],
      ),
    );
  }

  orderDetailsLayout() {
    return Column(
      children: [
        subTotalLayout(),
        SizedBox(
          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
        ),
        discountLayout(),
        SizedBox(
          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
        ),
        deliveryChargeLayout(),
        SizedBox(
          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
        ),
        totalLayout(),
        SizedBox(
          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
        ),
        confirmOrderButton()
      ],
    );
  }

  subTotalLayout() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              Constants.SUB_TOTAL,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Constants.MEDIUM_FONT_SIZE,
              ),
            )
        ),
        Expanded(
            flex: 1,
            child: Text(
              '${Constants.TK_SYMBOL} ${viewModel.subTotal}',
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Constants.MEDIUM_FONT_SIZE,
              ),
            )
        ),
      ],
    );
  }

  discountLayout() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              Constants.DISCOUNT,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Constants.MEDIUM_FONT_SIZE,
              ),
            )
        ),
        Expanded(
            flex: 1,
            child: Text(
              '${Constants.TK_SYMBOL} ${viewModel.totalDiscount}',
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Constants.MEDIUM_FONT_SIZE,
              ),
            )
        ),
      ],
    );
  }

  deliveryChargeLayout() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              Constants.DELIVERY_CHARGE,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Constants.MEDIUM_FONT_SIZE,
              ),
            )
        ),
        Expanded(
            flex: 1,
            child: Text(
              '${Constants.TK_SYMBOL} ${viewModel.deliveryCharge}',
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: Constants.MEDIUM_FONT_SIZE,
              ),
            )
        ),
      ],
    );
  }

  totalLayout() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              Constants.TOTAL,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: Constants.LARGE_FONT_SIZE,
                  fontWeight: FontWeight.w500
              ),
            )
        ),
        Expanded(
            flex: 1,
            child: Text(
              '${Constants.TK_SYMBOL} ${viewModel.totalPrice}',
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: Constants.LARGE_FONT_SIZE,
                  fontWeight: FontWeight.w500
              ),
            )
        ),
      ],
    );
  }

  confirmOrderButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Constants.EXTRA_SMALL_HEIGHT,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.EXTRA_SMALL_RADIUS)
            ),
            primary: ColorHelper.PRIMARY_COLOR
        ),
        child: Center(
            child: Text(
              Constants.CONFIRM_ORDER,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),
            )
        ),
        onPressed: () {
          viewModel.confirmOrder();
        },
      ),
    );
  }

  showConfirmationDialog(CartItem cartItem) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      headerAnimationLoop: false,
      dismissOnTouchOutside: false,
      title: Constants.DELETE,
      desc: 'Do you really want to remove this item?',
      btnCancelText: Constants.NO,
      btnOkText: Constants.YES,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        viewModel.deleteCartItem(cartItem);
      },
    ).show();
  }

  showApplyPromoModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Constants.SMALL_RADIUS),
          topRight:Radius.circular(Constants.SMALL_RADIUS)
        )
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: Constants.EXTRA_LARGE_HEIGHT,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(Constants.STANDARD_PADDING),
                margin: EdgeInsets.only(top: Constants.MEDIUM_PADDING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Constants.APPLY_PROMO_CODE,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: Constants.MEDIUM_FONT_SIZE
                      ),
                    ),
                    SizedBox(
                      height: Constants.MEDIUM_PADDING,
                    ),
                    promoCodeField(),
                    SizedBox(
                      height: Constants.SMALL_PADDING,
                    ),
                    applyPromotionButton()
                  ],
                ),
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

  promoCodeField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.grey.shade300
          ),
          borderRadius: BorderRadius.circular(Constants.EXTRA_SMALL_RADIUS)
      ),
      child: TextField(
        // controller: phoneNumberTextController,
        textAlign: TextAlign.start,
        cursorColor: Colors.black54,
        keyboardType: TextInputType.text,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: Constants.MEDIUM_FONT_SIZE,
        ),
        decoration: InputDecoration(
          hintText: Constants.PROMO_CODE,
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey.shade500,
            fontSize: Constants.MEDIUM_FONT_SIZE,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(Constants.MEDIUM_PADDING)
        ),
        onChanged: (String newVal) {},
      ),
    );
  }

  applyPromotionButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Constants.EXTRA_SMALL_HEIGHT,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.EXTRA_SMALL_RADIUS)
            ),
            primary: ColorHelper.PRIMARY_COLOR
        ),
        child: Center(
            child: Text(
              Constants.APPLY,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),
            )
        ),
        onPressed: () {},
      ),
    );
  }
}
