import 'package:animations/animations.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/models/category.dart';
import 'package:restaurant_app/models/item.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/home_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => HomePageView(),
      viewModel: HomeViewModel()
    );
  }
}

// ignore: must_be_immutable
class HomePageView extends StatelessView<HomeViewModel> {

  late BuildContext context;
  late HomeViewModel viewModel;

  @override
  Widget render(BuildContext context, HomeViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        appBar: appBar(),
        drawer: drawer(),
        body: body(),
        floatingActionButton: floatingActionButton(),
      )
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
              Navigator.pushNamed(context, AppRoute.MY_PROFILE);
            },
          ),
          // ListTile(
          //   title: const Text(Constants.MY_ADDRESS),
          //   leading: Icon(
          //       Icons.location_city
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            title: const Text(Constants.MY_ORDERS),
            leading: Icon(
                Icons.fastfood
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.MY_ORDERS);
            },
          ),
          // ListTile(
          //   title: const Text(Constants.VOUCHERS),
          //   leading: Icon(
          //       Icons.card_giftcard
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            title: const Text(Constants.NOTIFICATIONS),
            leading: Icon(
                Icons.notifications
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.NOTIFICATIONS);
            },
          ),
          ListTile(
            title: const Text(Constants.SIGN_OUT),
            leading: Icon(
                Icons.exit_to_app
            ),
            onTap: () {
              Navigator.pop(context);
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
              // bottomLeft: Radius.circular(Constants.MEDIUM_RADIUS),
              bottomRight: Radius.circular(Constants.LARGE_RADIUS)
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
    return FloatingActionButton.extended(
      backgroundColor: ColorHelper.PRIMARY_COLOR,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(Constants.SMALL_RADIUS)
      //   )
      // ),
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
    return Container(
      padding: EdgeInsets.only(
        top: Constants.SMALL_PADDING,
        left: Constants.STANDARD_PADDING
      ),
      child: viewModel.isRecommendedItemEmpty ?
              bodyWithoutRecommendedList() :
              bodyWithRecommendedList(),
    );
  }

  bodyWithRecommendedList() {
    return Column(
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
        recommendedItemListView(),
        SizedBox(
          height: Constants.SMALL_PADDING,
        ),
        categoryListView(),
        SizedBox(
          height: Constants.LARGE_PADDING,
        ),
        categoryWiseItemListView()
      ],
    );
  }

  bodyWithoutRecommendedList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        categoryListView(),
        SizedBox(
          height: Constants.LARGE_PADDING,
        ),
        categoryWiseItemListView()
      ],
    );
  }

  recommendedItemListView() {
    return Container(
      height: Constants.LARGE_HEIGHT,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.recommendedItemList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: singleRecommendedItem(viewModel.recommendedItemList[index]),
            onTap: () async {
              await Navigator.pushNamed(
                  context,
                  AppRoute.ITEM_DETAILS,
                  arguments: viewModel.recommendedItemList[index]
              );
              viewModel.getCartItemNumber();
            },
          );
        },
      ),
    );
  }

  singleRecommendedItem(Item item) {
    return Container(
      width: Constants.LARGE_WIDTH,
      margin: EdgeInsets.only(right: Constants.SMALL_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: Constants.LARGE_WIDTH,
            height: Constants.RECOMMENDED_IMAGE_HEIGHT,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(Constants.SMALL_RADIUS)
              ),
              color: Colors.grey.shade300
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Constants.SMALL_RADIUS),
              child: FadeInImage(
                image: NetworkImage(ApiServices.BASE_URL + '${item.imagePath}'),
                placeholder: AssetImage('assets/images/place_holder.jpg'),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image(
                    image: AssetImage('assets/images/place_holder.jpg'),
                    fit: BoxFit.cover,
                    height: Constants.RECOMMENDED_IMAGE_HEIGHT,
                    width: Constants.LARGE_WIDTH,
                  );
                },
                fit: BoxFit.cover,
                width: Constants.LARGE_WIDTH,
                height: Constants.RECOMMENDED_IMAGE_HEIGHT,
              ),
            ),
          ),
          SizedBox(
            height: Constants.SMALL_PADDING,
          ),
          Text(
              item.itemName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: Constants.MEDIUM_FONT_SIZE,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )
          ),
          SizedBox(
            height: Constants.EXTRA_SMALL_PADDING,
          ),
          Row(
            children: [
              RatingBarIndicator(
                rating: item.averageRating.toString() == 'null' ? 0 : item.averageRating!,
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
              SizedBox(
                width: Constants.EXTRA_SMALL_PADDING,
              ),
              Text(
                item.averageRating.toString() == 'null' ? '0.0' : item.averageRating.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: Constants.SMALL_FONT_SIZE,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                height: 35,
                padding: EdgeInsets.all(Constants.SMALL_PADDING),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Constants.SMALL_RADIUS)
                    ),
                    color: Colors.grey.shade300
                ),
                child: Text(
                    '${item.price} TK',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: Constants.SMALL_FONT_SIZE,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),
                    )
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                ),
                onPressed: () {
                  viewModel.addToCart(item);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  categoryListView() {
    return Container(
      height: Constants.EXTRA_SMALL_HEIGHT,
      alignment: Alignment.center,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.categoryList.length,
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
          viewModel.categoryList[index].categoryName!,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),
        selectedColor: ColorHelper.PRIMARY_COLOR,
        selected: viewModel.categoryIndex == index,
        autofocus: true,
        onSelected: (bool selected) {
          viewModel.setCategory(selected, index);
        },
      ),
    );
  }

  categoryWiseItemListView() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: Constants.STANDARD_PADDING),
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: viewModel.itemList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: singleCategoryWiseItem(viewModel.itemList[index]),
            onTap: () async {
              await Navigator.pushNamed(
                  context,
                  AppRoute.ITEM_DETAILS,
                  arguments: viewModel.itemList[index]
              );
              viewModel.getCartItemNumber();
            },
          );
        },
      )
    );
  }

  singleCategoryWiseItem(Item item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: Constants.SMALL_HEIGHT,
                width: Constants.SMALL_WIDTH,
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
                      ApiServices.BASE_URL + '${item.imagePath}',
                    ),
                    placeholder: AssetImage('assets/images/place_holder.jpg'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image(
                        image: AssetImage('assets/images/place_holder.jpg'),
                        fit: BoxFit.cover,
                        height: Constants.SMALL_HEIGHT,
                        width: Constants.SMALL_WIDTH,
                      );
                    },
                    fit: BoxFit.cover,
                    height: Constants.SMALL_HEIGHT,
                    width: Constants.SMALL_WIDTH,
                  ),
                )
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
                          item.itemName!,
                          maxLines: 2,
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
                      Container(
                        padding: EdgeInsets.all(Constants.SMALL_PADDING),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Constants.SMALL_RADIUS)
                            ),
                            color: Colors.grey.shade300
                        ),
                        child: Text(
                            '${item.price} TK',
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
                        onPressed: () {
                          viewModel.addToCart(item);
                        },
                      ),
                      SizedBox(
                        height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                      ),
                      RatingBarIndicator(
                        rating: item.averageRating.toString() == 'null' ? 0 : item.averageRating!,
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
