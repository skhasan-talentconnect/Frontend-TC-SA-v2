import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart' show SColor, STextStyles;

class STextField extends StatefulWidget {
  const STextField({
    required this.controller,
    this.items,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.enable = true,
    this.validator,
    this.onChanged,
    this.dividerHeight,
    super.key,
  }) : _isDropDown = false,
       _isPassword = false;

  const STextField.dropdown({
    required this.controller,
    required this.items,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.enable = true,
    this.validator,
    this.onChanged,
    this.dividerHeight,
    super.key,
  }) : _isDropDown = true,
       _isPassword = false;

  const STextField.password({
    required this.controller,
    this.items,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.enable = true,
    this.validator,
    this.onChanged,
    this.dividerHeight,
    super.key,
  }) : _isDropDown = false,
       _isPassword = true;

  final bool _isDropDown;
  final bool _isPassword;

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final bool? enable;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<String>? items;
  final double? dividerHeight;
  final String? Function(String? val)? validator;
  final void Function(String? val)? onChanged;

  @override
  State<STextField> createState() => _STextFieldState();
}

class _STextFieldState extends State<STextField> {
  final _isExpanded = ValueNotifier<bool>(false);
  final _isVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          widget._isDropDown
              ? () {
                if (widget.enable ?? true) {
                  final hasItems = (widget.items ?? []).isNotEmpty;
                  if (!hasItems) {
                    _isExpanded.value = false;
                    return;
                  }

                  _isExpanded.value = !_isExpanded.value;
                }
              }
              : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: SColor.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: SColor.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.prefixIcon ?? SizedBox.shrink(),
                if (widget.prefixIcon != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    color: SColor.terTextColor,
                    width: 1,
                    height: widget.dividerHeight ?? 35,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.label != null) ...[
                        Text(
                          widget.label ?? '',
                          style: STextStyles.s12W600.copyWith(
                            color: SColor.secTextColor,
                          ),
                        ),
                      ],
                      ValueListenableBuilder(
                        valueListenable: _isVisible,
                        builder:
                            (_, visible, __) => TextFormField(
                              controller: widget.controller,
                              readOnly: widget._isDropDown,
                              enabled: widget.enable ?? true,
                              obscureText: widget._isPassword && !visible,
                              obscuringCharacter: '*',
                              onTap:
                                  widget._isDropDown
                                      ? () {
                                        if (widget.enable ?? true) {
                                          final hasItems =
                                              (widget.items ?? []).isNotEmpty;
                                          if (!hasItems) {
                                            _isExpanded.value = false;
                                            return;
                                          }

                                          _isExpanded.value =
                                              !_isExpanded.value;
                                        }
                                      }
                                      : null,
                              validator: widget.validator,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: widget.hint ?? '',
                                hintStyle: STextStyles.s14W400.copyWith(
                                  color: SColor.terTextColor,
                                ),
                                isDense: true,
                              ),
                              style: STextStyles.s16W400.copyWith(
                                color: SColor.secTextColor,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                widget._isDropDown
                    ? GestureDetector(
                      onTap: () {
                        if (widget.enable ?? true) {
                          final hasItems = (widget.items ?? []).isNotEmpty;
                          if (!hasItems) {
                            _isExpanded.value = false;
                            return;
                          }

                          _isExpanded.value = !_isExpanded.value;
                        }
                      },
                      child: ValueListenableBuilder(
                        valueListenable: _isExpanded,
                        builder:
                            (context, value, child) => Icon(
                              value
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: SColor.secTextColor,
                            ),
                      ),
                    )
                    : widget._isPassword
                    ? Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: GestureDetector(
                        onTap: () {
                          _isVisible.value = !_isVisible.value;
                        },
                        child: ValueListenableBuilder(
                          valueListenable: _isVisible,
                          builder:
                              (context, visible, child) => Icon(
                                visible
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined,
                                color: SColor.secTextColor,
                              ),
                        ),
                      ),
                    )
                    : widget.suffixIcon ?? SizedBox.shrink(),
              ],
            ),
            if (widget._isDropDown) ...[
              ValueListenableBuilder(
                valueListenable: _isExpanded,
                builder: (context, value, child) {
                  return value
                      ? Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.sizeOf(context).height * 0.2,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((widget.items ?? []).isNotEmpty) ...[Divider()],
                            Flexible(
                              child: ListView.builder(
                                itemCount: widget.items?.length ?? 0,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  final item = widget.items?[index] ?? '';
                                  return GestureDetector(
                                    onTap: () {
                                      // update controller first
                                      widget.controller.text = item;

                                      // then call onChanged with the new value
                                      if (widget.onChanged != null) {
                                        widget.onChanged!(item);
                                      }

                                      // finally close the dropdown
                                      _isExpanded.value = false;
                                    },

                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            item,
                                            style: STextStyles.s16W400.copyWith(
                                              color: SColor.secTextColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                      : SizedBox.shrink();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
