import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/router.dart';
import 'package:rejolute/screen/register_screen/bloc/register_screen_bloc.dart';
import 'package:rejolute/screen/register_screen/bloc/register_screen_event.dart';
import 'package:rejolute/screen/register_screen/bloc/register_screen_state.dart';
import 'package:rejolute/util/app_utils.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/custom_button.dart';
import 'package:rejolute/util/font.dart';
import 'package:rejolute/util/main_utils.dart';
import 'package:rejolute/util/string_resource.dart';
import 'package:rejolute/widget/app_logo.dart';
import 'package:rejolute/widget/custom_app_text_field.dart';
import 'package:rejolute/widget/custom_scaffold.dart';
import 'package:rejolute/widget/custom_text.dart';
import 'package:rejolute/widget/loading_animation.dart';
import 'package:rejolute/widget/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc? registerBloc;
  @override
  void initState() {
    super.initState();
    registerBloc = BlocProvider.of<RegisterBloc>(context);

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
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (BuildContext context, RegisterState state) {
        if (state is RegisterInitialState) {
          if (state.error != null) {
            AppUtils.showToast(state.error!);
          }
        }
        if (state is RegisterSuccessState) {
          Navigator.pushNamed(context, AppRoutes.HOME_TAB_SCREEN);
        }
      },
      bloc: registerBloc,
      child: BlocBuilder<RegisterBloc, RegisterState>(
        bloc: registerBloc,
        builder: (BuildContext context, RegisterState state) {
          print(state);
          return AbsorbPointer(
            absorbing: state is RegisterLoadingState,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanDown: (_) {
                    AppUtils.hideKeyBoard(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height - 30),
                        //height: MediaQuery.of(context).size.height - 30,
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 30),
                            CachedNetworkImage(
                              imageUrl: "",
                              placeholder: (context, url) =>
                                  LoadingAnimationIndicator(),
                              errorWidget: (context, url, error) => AppLogo(
                                height: 100,
                                width: 300,
                              ),
                            ),
                            // else
                            //   AppLogo(
                            //     height: 100,
                            //     width: 300,
                            //   )
                            // else

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.10,
                            ),

                            CustomText("Sign Up",
                                textAlign: TextAlign.center,
                                fontSize: 30,
                                font: Font.SfUiSemibold,
                                color: ColorResource.PRIMARY),
                            SizedBox(
                              height: 20,
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            AutofillGroup(
                              child: Column(
                                children: [
                                  buildEmailTextBox(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buildPasswordTextBox(),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            buildRegisterButton(),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.LOGIN_SCREEN);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: CustomText("Login Now"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (state is RegisterLoadingState) LoadingAnimationIndicator()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildRegisterButton() {
    return Container(
      child: CustomButton(
        "Sign Up",
        borderWidth: 1,
        buttonWidth: 150,
        borderColor: ColorResource.BRIGHT_BLUE_007AFF,
        borderRadius: 8,
        color: ColorResource.BRIGHT_BLUE_007AFF,
        onPressed: onRegisterButtonPressed,
        buttonTextColor: Colors.white,
        buttonTextSize: 16,
        verticalPadding: 10,
        horizontalPadding: 50,
      ),
    );
  }

  Widget buildTextBox({
    @required TextEditingController? textEditingController,
    @required String? fieldName,
    @required FocusNode? focusNode,
    FocusNode? nextFocusNode,
    bool isRequired = false,
    bool isNextDone = false,
    String? errorText,
    Function? onSubmitFunc,
    int? minLines,
    String? hintText,
    bool isEmail = false,
    bool isNumber = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerTitle(
          title: fieldName,
          isRequired: isRequired,
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: ColorResource.GREY_PALE_F2F4F8,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormFieldWidget(
            controller: textEditingController,
            hintText: hintText == null ? ("Enter a " + fieldName!) : hintText,
            textColor: ColorResource.PRIMARY,
            focusNode: focusNode,
            primaryColor: ColorResource.PRIMARY,
            textInputType: isEmail
                ? TextInputType.emailAddress
                : isNumber
                    ? TextInputType.number
                    : TextInputType.text,
            // textInputType: TextInputType.numberWithOptions(decimal: true),
            actionKeyboard:
                (isNextDone) ? TextInputAction.next : TextInputAction.done,
            enabledBorderColor: Colors.transparent,
            focusedBorderColor: Colors.transparent,
            lstTextInputFormatter: isNumber
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*")),
                    // LengthLimitingTextInputFormatter(5),
                  ]
                : null,
            onValueChanged: (value) {
              //addProductScreenBloc.add(AddDiscountValueChangeEvent(value));
            },
            borderUnderlineColor: Colors.transparent,
            hintTextSize: 14,
            inputTextSize: 14,
            minLines: minLines,
            onSubmitField: (value) {
              if (onSubmitFunc != null) onSubmitFunc();
            },
          ),
        ),
        SizedBox(
          height: 2,
        ),
        if (errorText != null)
          if (errorText.isNotEmpty)
            CustomText(
              errorText,
              color: Colors.red,
            ),
      ],
    );
  }

  Widget headerTitle({@required String? title, @required bool? isRequired}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontFamily: Font.SfUiMedium.value,
              color: Colors.black,
            ),
          ),
          if (isRequired!)
            TextSpan(
              text: "*",
              style: TextStyle(
                fontFamily: Font.SfUiBlack.value,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildEmailTextBox() {
    return CustomAppTextField(
        textBoxName: StringResource.EMAIL,
        txtFocus: registerBloc!.emailControllerFocus,
        errorText: registerBloc!.emailErrorText,
        minWidthText: 60,
        txtFormField: TextFormFieldWidget(
          controller: registerBloc!.emailTextEditingController,
          autofillHint: [AutofillHints.username],
          hintText: StringResource.ENTER_EMAIL_ADDRESS,
          textColor: ColorResource.PRIMARY,
          focusNode: registerBloc!.emailControllerFocus,
          primaryColor: ColorResource.PRIMARY,
          textInputType: TextInputType.emailAddress,
          actionKeyboard: TextInputAction.next,
          enabledBorderColor: Colors.transparent,
          focusedBorderColor: Colors.transparent,
          borderUnderlineColor: Colors.transparent,
          hintTextSize: 14,
          inputTextSize: 14,
          onSubmitField: (value) {
            changeFocus(context, registerBloc!.emailControllerFocus,
                registerBloc!.passwordControllerFocus);
          },
        ));
  }

  Widget buildPasswordTextBox() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (RegisterState previousState, RegisterState currentState) {
        if (currentState is RegisterInitialState ||
            currentState is RegisterPasswordVisibilityToggleEvent)
          return true;
        else
          return false;
      },
      bloc: registerBloc,
      builder: (context, state) {
        return CustomAppTextField(
            textBoxName: StringResource.PASSWORD,
            txtFocus: registerBloc!.passwordControllerFocus,
            errorText: registerBloc!.passwordErrorText,
            isSuffixicon: true,
            minWidthText: 60,
            txtFormField: TextFormFieldWidget(
              controller: registerBloc!.passwordTextEditingController,
              autofillHint: [AutofillHints.password],
              hintText: StringResource.ENTER_PASSWORD,
              textColor: ColorResource.PRIMARY,
              focusNode: registerBloc!.passwordControllerFocus,
              primaryColor: ColorResource.PRIMARY,
              textInputType: TextInputType.emailAddress,
              actionKeyboard: TextInputAction.done,
              enabledBorderColor: Colors.transparent,
              focusedBorderColor: Colors.transparent,
              borderUnderlineColor: Colors.transparent,
              hintTextSize: 14,
              inputTextSize: 14,
              obscureText: registerBloc!.isPasswordVisible,
              prefixIcon: Icon(Icons.keyboard_hide),
              suffixIcon: registerBloc!.passwordSuffixIcon,
              maxLines: 1,
              suffixIconSize: 20,
              suffixIconColor: ColorResource.PRIMARY,
              onSuffixIconPressed: onTogglePasswordPressed,
              onSubmitField: (value) {
                onRegisterButtonPressed();
              },
            ));
      },
    );
    // return Container(
    //   padding: EdgeInsets.only(left: 10, right: 10),
    //   decoration: BoxDecoration(
    //       color: ColorResource.GREY_PALE_F2F4F8,
    //       border: Border(
    //         bottom: (RegisterBloc.passwordControllerFocus.hasFocus)
    //             ? BorderSide(color: ColorResource.BRIGHT_BLUE_007AFF, width: 1)
    //             : BorderSide(color: ColorResource.GREY_DARK_232326, width: 1),
    //       )),
    //   child: Row(
    //     children: [
    //       CustomText(
    //         StringResource.PASSWORD,
    //         font: Font.SfUiHeavy,
    //         fontSize: 14,
    //       ),
    //       SizedBox(
    //         width: 10,
    //       ),
    //       Expanded(
    //           child: TextFormFieldWidget(
    //         controller: RegisterBloc.passwordTextEditingController,
    //         hintText: StringResource.COULD_YOU_REMEMBER_It,
    //         textColor: ColorResource.PRIMARY_191F4A,
    //         focusNode: RegisterBloc.passwordControllerFocus,
    //         primaryColor: ColorResource.PRIMARY_191F4A,
    //         textInputType: TextInputType.emailAddress,
    //         actionKeyboard: TextInputAction.done,
    //         enabledBorderColor: Colors.transparent,
    //         focusedBorderColor: Colors.transparent,
    //         borderUnderlineColor: Colors.transparent,
    //         hintTextSize: 14,
    //         inputTextSize: 14,
    //         obscureText: true,
    //         prefixIcon: Icon(Icons.keyboard_hide),
    //         onSubmitField: () {},
    //       ))
    //     ],
    //   ),
    // );
  }

  onTogglePasswordPressed() {
    registerBloc!.add(RegisterPasswordVisibilityToggleEvent());
  }

  onRegisterButtonPressed() {
    AppUtils.hideKeyBoard(context);
    // Navigator.pushNamed(
    //   context,
    //   AppRoutes.HOME_TAB_SCREEN,
    // );
    registerBloc!.add(RegisterButtonPressedEvent());
  }
}
