import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/home_view_model.dart';


late BuildContext buildContext;

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildContext = context;

    return MVVM(
      view: (_, __) => CartView(),
      viewModel: HomeViewModel()
    );
  }
}

// ignore: must_be_immutable
class CartView extends StatelessView<HomeViewModel> {

  late HomeViewModel viewModel;

  @override
  Widget render(BuildContext context, HomeViewModel viewModel) {
    this.viewModel = viewModel;

    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  appBar() {
    return AppBar(
      title: Text(
        Constants.CART,
        style: GoogleFonts.poppins(
          color: Colors.black
        ),
      ),
      // backgroundColor: ColorHelper.TRANSPARENT_COLOR,
      // elevation: 0,
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
                height: Constants.SIGN_IN_PAGE_PADDING,
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
                height: Constants.SIGN_IN_PAGE_PADDING,
              ),
              totalLayout(),
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
      itemCount: 3,
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
        width: MediaQuery.of(buildContext).size.width,
        // margin: EdgeInsets.only(bottom: Constants.STANDARD_PADDING),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(Constants.LARGE_RADIUS),
                  child: FadeInImage(
                    image: NetworkImage(
                      Constants.DEMO_BURGER_LINK,
                    ),
                    placeholder: AssetImage('assets/images/place_holder.jpg'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image(
                        image: AssetImage('assets/images/place_holder.jpg'),
                        fit: BoxFit.fill,
                        height: Constants.EXTRA_SMALL_HEIGHT,
                        width: Constants.EXTRA_SMALL_WIDTH,
                      );
                    },
                    fit: BoxFit.fill,
                    height: Constants.EXTRA_SMALL_HEIGHT,
                    width: Constants.EXTRA_SMALL_WIDTH,
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
                            'Item Name Test Again',
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
                                      viewModel.decrementQuantity();
                                    }
                                ),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.grey.shade300,
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
                              CircleAvatar(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: Constants.EXTRA_SMALL_ICON_SIZE,
                                    ),
                                    onPressed: () {
                                      viewModel.incrementQuantity();
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
                  width: Constants.EXTRA_EXTRA_SMALL_WIDTH,
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                        '100 tk',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: Constants.LARGE_FONT_SIZE,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        )
                    ),
                )
              ],
            ),
            Divider()
          ],
        )
    );
  }

  orderTypeList() {
    return CustomRadioButton(
      elevation: 3,
      autoWidth: true,
      absoluteZeroSpacing: false,
      enableButtonWrap: false,
      enableShape: true,
      wrapAlignment: WrapAlignment.start,
      unSelectedColor: Theme.of(buildContext).canvasColor,
      buttonLables: [
        'Dine In',
        'Take Away',
      ],
      buttonValues: [
        "Dine In",
        "Take Away",
      ],
      buttonTextStyle: ButtonTextStyle(
        selectedColor: Colors.black,
        unSelectedColor: Colors.black,
        textStyle: GoogleFonts.poppins(
          fontSize: Constants.SMALL_FONT_SIZE,
        )
      ),
      radioButtonValue: (value) {
        print(value);
      },
      selectedColor: ColorHelper.PRIMARY_COLOR,
    );
  }

  orderTypeListView() {
    return Container(
      height: Constants.EXTRA_SMALL_HEIGHT,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
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
          'Order Type $index',
          style: GoogleFonts.poppins(
            fontSize: Constants.SMALL_FONT_SIZE,
            color: Colors.black,
          ),
        ),
        selectedColor: ColorHelper.PRIMARY_COLOR,
        selected: viewModel.value == index,
        onSelected: (bool selected) {
          viewModel.setCategory(selected, index);
        },
      ),
    );
  }

  totalLayout() {
    return Column(
      children: [
        Row(
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
                '10 tk',
                textAlign: TextAlign.end,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: Constants.MEDIUM_FONT_SIZE,
                ),
              )
            ),
          ],
        ),
        SizedBox(
          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
        ),
        Row(
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
                  '0 tk',
                  textAlign: TextAlign.end,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: Constants.MEDIUM_FONT_SIZE,
                  ),
                )
            ),
          ],
        ),
        SizedBox(
          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
        ),
        Row(
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
                '300 tk',
                textAlign: TextAlign.end,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: Constants.LARGE_FONT_SIZE,
                  fontWeight: FontWeight.w500
                ),
              )
            ),
          ],
        ),
        SizedBox(
          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
        ),
        confirmOrderButton()
      ],
    );
  }

  confirmOrderButton() {
    return Container(
      width: MediaQuery.of(buildContext).size.width,
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
          // String number = phoneNumberTextController.text.toString();
          // Provider.of<AuthViewModel>(context, listen: false).checkLogIn(number.replaceAll(' ', ''));
        },
      ),
    );
  }
}
