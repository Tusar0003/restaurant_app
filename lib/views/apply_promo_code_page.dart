import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/apply_promo_code_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class ApplyPromoCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => ApplyPromoCodePageView(),
      viewModel: ApplyPromoCodeViewModel(),
    );
  }
}

// ignore: must_be_immutable
class ApplyPromoCodePageView extends StatelessView<ApplyPromoCodeViewModel> {

  late BuildContext context;
  late ApplyPromoCodeViewModel viewModel;

  @override
  Widget render(BuildContext context, ApplyPromoCodeViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        appBar: Widgets().appBar(Constants.APPLY_PROMO_CODE),
        body: body(),
      )
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(Constants.STANDARD_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          promoCodeField(),
          SizedBox(
            height: Constants.SMALL_PADDING,
          ),
          applyPromotionButton()
        ],
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
      child: TextFormField(
        initialValue: viewModel.promoCode,
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
        onChanged: (String newVal) {
          viewModel.setPromoCode(newVal);
        },
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
        onPressed: () {
          viewModel.applyPromoCode();
        },
      ),
    );
  }
}
