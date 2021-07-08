import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/router.dart';
import 'package:rejolute/screen/add_category_screen/bloc/add_category_bloc.dart';
import 'package:rejolute/screen/add_category_screen/bloc/add_category_event.dart';
import 'package:rejolute/screen/add_category_screen/bloc/add_category_state.dart';
import 'package:rejolute/util/app_utils.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/custom_button.dart';
import 'package:rejolute/util/image_resource.dart';
import 'package:rejolute/widget/custom_app_bar.dart';
import 'package:rejolute/widget/custom_scaffold.dart';
import 'package:rejolute/widget/custom_text.dart';
import 'package:rejolute/widget/loading_animation.dart';
import 'package:rejolute/widget/text_form_field.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  AddCategoryBloc? addCategoryBloc;
  @override
  void initState() {
    super.initState();
    addCategoryBloc = BlocProvider.of<AddCategoryBloc>(context);

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => buildAfterComplete(context));
  }

  buildAfterComplete(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: ColorResource.BACKGROUND_WHITE,
      isBottomReSize: true,
      body: Container(
        child: layout(),
        color: ColorResource.BACKGROUND_WHITE,
      ),
    );
  }

  Widget layout() {
    return BlocListener<AddCategoryBloc, AddCategoryState>(
      listener: (BuildContext context, AddCategoryState state) {
        if (state is AddCategoryInitialState) {
          if (state.error != null) {
            AppUtils.showToast(state.error!);
          }
        }
        if (state is CategorySuccessState) {
          AppUtils.showToast("Category Successfully added",
              backgroundColor: Colors.green);
          Navigator.pop(context);
        }
      },
      bloc: addCategoryBloc,
      child: BlocBuilder<AddCategoryBloc, AddCategoryState>(
        bloc: addCategoryBloc,
        builder: (BuildContext context, AddCategoryState state) {
          print(state);
          return buildMainBody(state);
        },
      ),
    );
  }

  Widget buildMainBody(AddCategoryState state) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppBarCustom(),
          Expanded(
            child: state is AddCategoryLoadingState
                ? LoadingAnimationIndicator()
                : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            "Add Category",
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildNameTextField(),
                          SizedBox(
                            height: 10,
                          ),
                          buildSaveButton(),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildNameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: ColorResource.PRIMARY.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      // margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(left: 10, top: 0, bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextFormFieldWidget(
                controller: addCategoryBloc!.txtNameController,
                hintText: "Enter Category Name",
                errorText: addCategoryBloc!.nameErrortext,
                hintTextSize: 16,
                hintTextColor: ColorResource.PRIMARY,
                inputTextSize: 16,
                textColor: ColorResource.PRIMARY,
                enabledBorderColor: ColorResource.PRIMARY.withOpacity(0),
                focusedBorderColor: Colors.transparent,
                borderUnderlineColor: Colors.transparent,
                maxLines: 1,
                ignorePadding: true,
                textInputType: TextInputType.emailAddress,
                onSubmitField: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSaveButton() {
    return Container(
      child: CustomButton(
        "Save",
        borderWidth: 1,
        buttonWidth: 150,
        borderColor: ColorResource.BRIGHT_BLUE_007AFF,
        borderRadius: 8,
        color: ColorResource.BRIGHT_BLUE_007AFF,
        onPressed: () {
          addCategoryBloc!.add(SubmitEvent());
        },
        buttonTextColor: Colors.white,
        buttonTextSize: 16,
        verticalPadding: 10,
        horizontalPadding: 50,
      ),
    );
  }

  Widget buildAppBarCustom() {
    return CustomAppBar(
      appBarBackgroundColor: ColorResource.PRIMARY,
      centerWidget: Image.asset(
        ImageResource.APP_LOGO,
        height: 30,
      ),
    );
  }
}
