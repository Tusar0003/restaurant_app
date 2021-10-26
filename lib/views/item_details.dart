import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/mvvm_builder.widget.dart';
import 'package:pmvvm/views/stateless.view.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/home_view_model.dart';


late BuildContext buildContext;

class ItemDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildContext = context;

    return MVVM(
      view: (_, __) => ItemDetailsView(),
      viewModel: HomeViewModel()
    );
  }
}

// ignore: must_be_immutable
class ItemDetailsView extends StatelessView<HomeViewModel> {

  late HomeViewModel viewModel;

  @override
  Widget render(BuildContext context, HomeViewModel viewModel) {
    this.viewModel = viewModel;

    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: body(),
    );
  }

  floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: ColorHelper.PRIMARY_COLOR,
      child: Icon(
        Icons.shopping_bag_outlined,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pushNamed(buildContext, AppRoute.CART);
      },
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
                    image: NetworkImage(Constants.DEMO_PIZZA_LINK),
                    placeholder: AssetImage('assets/images/place_holder.jpg'),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(buildContext).size.width,
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
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s',
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
                Navigator.pop(buildContext);
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
                      '120 tk',
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
                onPressed: () {  },
              ),
            ),
          )
        ],
      ),
    );
  }
}