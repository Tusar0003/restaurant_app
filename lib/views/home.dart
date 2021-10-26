import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/home_view_model.dart';


late BuildContext buildContext;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildContext = context;

    return MVVM(
      view: (_, __) => HomeView(),
      viewModel: HomeViewModel()
    );
  }
}

// ignore: must_be_immutable
class HomeView extends StatelessView<HomeViewModel> {

  late HomeViewModel viewModel;

  @override
  Widget render(BuildContext context, HomeViewModel viewModel) {
    this.viewModel = viewModel;

    return Scaffold(
      appBar: appBar(),
      drawer: drawer(),
      body: body(),
      floatingActionButton: floatingActionButton(),
    );
  }

  appBar() {
    return AppBar(
      title: Text(
        'Hello, User!',
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: Constants.MEDIUM_FONT_SIZE
        ),
      ),
      // centerTitle: true,
      backgroundColor: ColorHelper.TRANSPARENT_COLOR,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications_active_outlined),
          onPressed: () {},
        )
      ],
    );
  }

  drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          drawerHeader(),
          ListTile(
            title: const Text(Constants.MY_PROFILE),
            leading: Icon(
              Icons.person_outlined
            ),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
          ListTile(
            title: const Text(Constants.MY_ADDRESS),
            leading: Icon(
                Icons.location_city
            ),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
          ListTile(
            title: const Text(Constants.CURRENT_ORDERS),
            leading: Icon(
                Icons.fastfood
            ),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
          ListTile(
            title: const Text(Constants.PREVIOUS_ORDERS),
            leading: Icon(
                Icons.history_outlined
            ),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
          ListTile(
            title: const Text(Constants.VOUCHERS),
            leading: Icon(
                Icons.card_giftcard
            ),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
          ListTile(
            title: const Text(Constants.NOTIFICATIONS),
            leading: Icon(
                Icons.notifications
            ),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
          ListTile(
            title: const Text(Constants.SIGN_OUT),
            leading: Icon(
                Icons.exit_to_app
            ),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
        ],
      ),
    );
  }

  drawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
          color: ColorHelper.PRIMARY_COLOR,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Constants.MEDIUM_RADIUS),
              bottomRight: Radius.circular(Constants.MEDIUM_RADIUS)
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Text(
          //   'Tech Island Ltd.',
          //   style: GoogleFonts.poppins(
          //     color: Colors.black,
          //     fontSize: Constants.LARGE_FONT_SIZE,
          //     fontWeight: FontWeight.bold
          //   ),
          // ),
          SizedBox(
            height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Constants.LARGE_RADIUS),
                child: FadeInImage(
                  image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/RedDot_Burger.jpg/285px-RedDot_Burger.jpg',
                  ),
                  placeholder: AssetImage('assets/images/place_holder.jpg'),
                  fit: BoxFit.fill,
                  height: Constants.SMALL_HEIGHT,
                  width: Constants.SMALL_WIDTH,
                ),
              ),
              SizedBox(
                width: Constants.EXTRA_EXTRA_SMALL_WIDTH,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Username',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: Constants.MEDIUM_FONT_SIZE,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(
                    height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                  ),
                  Text(
                    '+8801521234567',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: Constants.SMALL_FONT_SIZE,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
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
    return Container(
      padding: EdgeInsets.only(
        top: Constants.SMALL_PADDING,
        left: Constants.STANDARD_PADDING
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constants.RECOMMENDED,
              style: GoogleFonts.poppins(
                  fontSize: Constants.EXTRA_LARGE_FONT_SIZE,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(
              height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
            ),
            recommended(),
            SizedBox(
              height: Constants.STANDARD_PADDING,
            ),
            categoryListView(),
            SizedBox(
              height: Constants.STANDARD_PADDING,
            ),
            categoryWiseItemListView()
          ],
        ),
      ),
    );
  }

  recommended() {
    return Container(
      height: Constants.MEDIUM_HEIGHT,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: singleRecommendedItem(),
            onTap: () {
              Navigator.pushNamed(buildContext, AppRoute.ITEM_DETAILS);
            },
          );
        },
      ),
    );
  }

  singleRecommendedItem() {
    return Container(
      width: Constants.LARGE_WIDTH,
      margin: EdgeInsets.only(right: Constants.SMALL_PADDING),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(Constants.SMALL_RADIUS),
            child: FadeInImage(
              image: NetworkImage(Constants.DEMO_PIZZA_LINK),
              placeholder: AssetImage('assets/images/place_holder.jpg'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image(
                  image: AssetImage('assets/images/place_holder.jpg'),
                  fit: BoxFit.fill,
                  height: Constants.RECOMMENDED_IMAGE_HEIGHT,
                  width: Constants.LARGE_WIDTH,
                );
              },
              fit: BoxFit.fill,
              width: Constants.LARGE_WIDTH,
              height: Constants.RECOMMENDED_IMAGE_HEIGHT,
            ),
          ),
          SizedBox(
            height: Constants.SMALL_PADDING,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Chicken Cheese Burger',
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
                    padding: EdgeInsets.all(Constants.SMALL_PADDING),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Constants.SMALL_RADIUS)
                        ),
                        color: Colors.grey.shade300
                    ),
                    child: Text(
                        '100 tk',
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
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                          Icons.add_shopping_cart
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: Constants.EXTRA_SMALL_PADDING,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: ColorHelper.PRIMARY_COLOR,
                        ),
                        Text(
                          '4.3',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: Constants.MEDIUM_FONT_SIZE,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    // RatingBarIndicator(
                    //   rating: 3.5,
                    //   itemSize: Constants.EXTRA_EXTRA_SMALL_WIDTH,
                    //   direction: Axis.horizontal,
                    //   unratedColor: Colors.grey[300],
                    //   itemCount: 5,
                    //   // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    //   itemBuilder: (context, _) => Icon(
                    //     Icons.star,
                    //     color: ColorHelper.PRIMARY_COLOR,
                    //   ),
                    // ),
                  ],
                )
              )
            ],
          )
        ],
      ),
    );
  }

  categoryListView() {
    return Container(
      height: Constants.EXTRA_SMALL_HEIGHT,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) => singleCategory(index),
      ),
    );
  }

  singleCategory(int index) {
    return Container(
      margin: EdgeInsets.only(right: Constants.SMALL_PADDING),
      child: ChoiceChip(
        padding: EdgeInsets.all(Constants.SMALL_PADDING),
        label: Text(
          'Category $index',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600
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

  categoryWiseItemListView() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: singleCategoryWiseItem(),
          onTap: () {
            Navigator.pushNamed(buildContext, AppRoute.ITEM_DETAILS);
          },
        );
      },
    );
  }

  singleCategoryWiseItem() {
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
                        height: Constants.SMALL_HEIGHT,
                        width: Constants.SMALL_WIDTH,
                      );
                    },
                    fit: BoxFit.fill,
                    height: Constants.SMALL_HEIGHT,
                    width: Constants.SMALL_WIDTH,
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
                          padding: EdgeInsets.all(Constants.SMALL_PADDING),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Constants.SMALL_RADIUS)
                              ),
                              color: Colors.grey.shade300
                          ),
                          child: Text(
                              '100 tk',
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
                ),
                SizedBox(
                  width: Constants.EXTRA_EXTRA_SMALL_WIDTH,
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                              Icons.add_shopping_cart
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                        ),
                        RatingBarIndicator(
                          rating: 3.5,
                          itemSize: Constants.EXTRA_EXTRA_SMALL_WIDTH,
                          direction: Axis.horizontal,
                          unratedColor: Colors.grey[300],
                          itemCount: 5,
                          // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: ColorHelper.PRIMARY_COLOR,
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
            Divider()
          ],
        )
    );
  }
}
