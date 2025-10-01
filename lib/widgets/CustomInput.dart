import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorProps {
  final bool isError;
  final String? text;
  final Color? color;

  ErrorProps({required this.isError, this.text, this.color});
}

class CustomInput extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final String? iconSvg; // pass SVG string (xml)
  final bool secureTextEntry;
  final bool enabled;
  final ErrorProps? error;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final String? placeholder;
  final ValueChanged<String>? onChanged;

  const CustomInput({
    super.key,
    this.label,
    this.icon,
    this.iconSvg,
    this.secureTextEntry = false,
    this.enabled = true,
    this.error,
    this.controller,
    this.keyboardType,
    this.textStyle,
    this.placeholder,
    this.onChanged,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isFocused = false;
  late bool secure;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    secure = widget.secureTextEntry;
    _focusNode = FocusNode();

    // Listeners for focus/blur
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 16,
              color: isFocused
                  ? Colors.green
                  : (widget.error?.isError == true
                        ? widget.error?.color ?? Colors.red
                        : Colors.grey),
            ),
          ),
        // const SizedBox(height: 5),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.error?.isError == true
                  ? widget.error?.color ?? Colors.red
                  : (isFocused ? Colors.green : Colors.black),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              if (widget.icon != null)
                Icon(
                  widget.icon,
                  color: isFocused ? Colors.green : Colors.black,
                  size: 20,
                ),
              if (widget.iconSvg != null)
                SvgPicture.string(
                  widget.iconSvg!,
                  height: 20,
                  width: 20,
                  color: isFocused ? Colors.green : Colors.black,
                ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  focusNode: _focusNode, // 👈 attaches focus
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  style:
                      widget.textStyle ??
                      const TextStyle(fontSize: 16, color: Colors.black),
                  obscureText: secure,
                  enabled: widget.enabled,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
              if (widget.secureTextEntry)
                GestureDetector(
                  onTap: () => setState(() => secure = !secure),
                  child: Icon(
                    secure ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                    color: Colors.grey.shade700,
                  ),
                ),
            ],
          ),
        ),
        if (widget.error?.isError == true)
          Padding(
            padding: const EdgeInsets.only(top: 3, left: 5),
            child: Text(
              widget.error?.text ?? '',
              style: TextStyle(
                fontSize: 12,
                color: widget.error?.color ?? Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
