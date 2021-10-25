import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: ColorHelper.TRANSPARENT_COLOR,
      elevation: 0,
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(Constants.STANDARD_PADDING),
      child: SingleChildScrollView(
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
          ],
        ),
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
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/RedDot_Burger.jpg/285px-RedDot_Burger.jpg',
                    ),
                    placeholder: AssetImage('assets/images/place_holder.jpg'),
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
}
