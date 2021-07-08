import 'package:flutter/material.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/font.dart';
import 'package:rejolute/widget/custom_text.dart';
import 'package:rejolute/widget/text_form_field.dart';

class CustomAppTextField extends StatefulWidget {
  FocusNode? txtFocus;
  final String? textBoxName;
  final Widget? txtFormField;
  double? minWidthText;
  bool? isMaxWidth;
  bool? isReadOnly;
  String? errorText;
  Color? errorColor;
  bool? isSuffixicon;
  CustomAppTextField(
      {@required this.textBoxName,
      this.txtFocus,
      @required this.txtFormField,
      this.minWidthText,
      this.isMaxWidth = false,
      this.isReadOnly = false,
      this.errorText,
      this.isSuffixicon = false,
      this.errorColor = ColorResource.RED_FF6C5F});
  @override
  _CustomAppTextFieldState createState() => _CustomAppTextFieldState();
}

class _CustomAppTextFieldState extends State<CustomAppTextField> {
  bool isavailablemax = false;
  bool isavailablemin = false;
  @override
  void initState() {
    super.initState();
    if (widget.isMaxWidth != null) {
      if (widget.isMaxWidth!) {
        if (widget.minWidthText != null) {
          isavailablemax = true;
        }
      }
    }
    if (!isavailablemax) {
      if (widget.minWidthText != null) {
        isavailablemin = true;
      }
    }
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => buildAfterComplete(context));
  }

  buildAfterComplete(BuildContext context) {
    if (widget.txtFocus != null) {
      widget.txtFocus!.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      // padding:
      //     EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: (widget.isReadOnly!)
                    ? ColorResource.GREY_PALE_F2F4F8
                    : (widget.txtFocus != null)
                        ? (widget.txtFocus!.hasFocus)
                            ? ColorResource.GREY_PALE_F2F4F8
                            : ColorResource.BACKGROUND_WHITE
                        : ColorResource.BACKGROUND_WHITE,
                border: Border(
                  bottom: (widget.errorText == null)
                      ? (widget.txtFocus != null)
                          ? (widget.txtFocus!.hasFocus)
                              ? BorderSide(
                                  color: ColorResource.BRIGHT_BLUE_007AFF,
                                  width: 1)
                              : BorderSide(
                                  color: ColorResource.GREY_DARK_232326,
                                  width: 1)
                          : BorderSide(
                              color: ColorResource.GREY_DARK_232326, width: 1)
                      : BorderSide(color: ColorResource.RED_FF6C5F, width: 1),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isavailablemax)
                  Container(
                    width: widget.minWidthText,
                    // constraints: BoxConstraints(maxWidth: widget.minWidthText ?? 0),
                    child: CustomText(
                      widget.textBoxName!,
                      font: Font.SfUiMedium,
                      fontSize: 14,
                      color: (widget.txtFocus != null)
                          ? (widget.txtFocus!.hasFocus)
                              ? ColorResource.BRIGHT_BLUE_007AFF
                              : Colors.black
                          : Colors.black,
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(minWidth: widget.minWidthText ?? 0),
                    child: CustomText(
                      widget.textBoxName!,
                      font: Font.SfUiMedium,
                      fontSize: 14,
                      color: (widget.txtFocus != null)
                          ? (widget.txtFocus!.hasFocus)
                              ? ColorResource.BRIGHT_BLUE_007AFF
                              : Colors.black
                          : Colors.black,
                    ),
                  ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  padding:
                      EdgeInsets.only(top: (widget.isSuffixicon!) ? 10 : 0),
                  child: widget.txtFormField,
                ))
              ],
            ),
          ),
          if (widget.errorText != null)
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: CustomText(
                widget.errorText!,
                fontSize: 14,
                color: widget.errorColor,
              ),
            )
        ],
      ),
    );
    // EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
  }
}
