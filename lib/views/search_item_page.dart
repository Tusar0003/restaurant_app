import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/mvvm_builder.widget.dart';
import 'package:pmvvm/views/stateless.view.dart';
import 'package:restaurant_app/models/item.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/search_item_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class SearchItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => SearchItemPageView(),
      viewModel: SearchItemViewModel()
    );
  }
}

// ignore: must_be_immutable
class SearchItemPageView extends StatelessView<SearchItemViewModel> {

  late BuildContext context;
  late SearchItemViewModel viewModel;

  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget render(BuildContext context, SearchItemViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        appBar: Widgets().appBar(Constants.SEARCH),
        body: body(),
      )
    );
  }

  body() {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: Constants.STANDARD_PADDING,
        left: Constants.STANDARD_PADDING,
        right: Constants.STANDARD_PADDING
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search your desired item',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: Constants.EXTRA_LARGE_FONT_SIZE,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(
            height: Constants.MEDIUM_PADDING,
          ),
          searchBar(),
          SizedBox(
            height: Constants.MEDIUM_PADDING,
          ),
          searchItemListView()
        ],
      ),
    );
  }

  searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Constants.EXTRA_SMALL_HEIGHT,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.all(
          Radius.circular(Constants.SMALL_RADIUS)
        )
      ),
      child: TextFormField(
        controller: searchTextEditingController,
        cursorColor: Colors.black54,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: '${Constants.SEARCH_ITEMS} . . .',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(
            Constants.MEDIUM_PADDING
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: Visibility(
            visible: viewModel.isClearIconVisible,
            child: TextButton(
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
              ),
              onPressed: () {
                viewModel.setSearchString('');
                searchTextEditingController.clear();
                viewModel.getSearchItemList();

                // Future.delayed(Duration(seconds: 1), () {
                //   viewModel.getSearchItemList();
                // });
              },
            ),
          )
        ),
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: Constants.MEDIUM_FONT_SIZE,
        ),
        onChanged: (newVal) {
          viewModel.setSearchString(newVal);
          viewModel.getSearchItemList();

          // Future.delayed(Duration(seconds: 1), () {
          //   viewModel.getSearchItemList();
          // });
        },
      ),
    );
  }

  searchItemListView() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: Constants.EXTRA_SMALL_HEIGHT),
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: viewModel.searchItemList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: singleSearchItem(viewModel.searchItemList[index]),
            onTap: () async {
              await Navigator.pushNamed(
                  context,
                  AppRoute.ITEM_DETAILS,
                  arguments: viewModel.searchItemList[index]
              );
            },
          );
        },
      )
    );
  }

  singleSearchItem(Item item) {
    return Container(
        width: MediaQuery.of(context).size.width,
        // height: 50,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                Spacer(),
                Container(
                  padding: EdgeInsets.all(Constants.EXTRA_SMALL_PADDING),
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
            ),
            Divider()
          ],
        )
    );
  }
}
