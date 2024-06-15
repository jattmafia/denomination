import 'package:denomination/app/screens/homepage/provider/homepageprovider.dart';
import 'package:denomination/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          buildimage(),
          Expanded(
            child: SingleChildScrollView(
              child: buildfields(),
            ),
          )
        ],
      ),
    );
  }

  buildimage() {
    return Consumer<HomepageProvider>(
      builder: (BuildContext context, HomepageProvider value, Widget? child) {
        return SizedBox(
          height: 160.h,
          child: Stack(
            children: [
              Assets.images.currencyBanner.image(
                  height: 180.h, width: double.infinity, fit: BoxFit.cover),
              Positioned(
                bottom: 20,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.totalSum != 0 ? "Total Amount" : "Denomination",
                      style: TextStyle(
                          fontSize: 22.h,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${value.formatsum(value.totalSum)}",
                      style: TextStyle(
                          fontSize: 22.h,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      softWrap: true,
                      "${toBeginningOfSentenceCase(NumberToWordsEnglish.convert(value.totalSum))} Only/-",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18.h,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  buildfields() {
    return Consumer<HomepageProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 2000",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs2000fieldController,
                        onCancelTap: () {
                          value.clearrs2000();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isNotEmpty) {
                            value.multiplyrs2000();
                            value.calculatetotal();
                          } else {
                            value.clearrs2000();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total2000)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 1000",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs1000fieldController,
                        onCancelTap: () {
                          value.clearrs1000();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs1000();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs1000();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total1000)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 500",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs500fieldController,
                        onCancelTap: () {
                          value.clearrs500();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs500();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs500();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total500)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 200",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs200fieldController,
                        onCancelTap: () {
                          value.clearrs200();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs200();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs200();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total200)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 100",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs100fieldController,
                        onCancelTap: () {
                          value.clearrs100();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs100();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs100();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total100)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 50",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs50fieldController,
                        onCancelTap: () {
                          value.clearrs50();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs50();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs50();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total50)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 20",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs20fieldController,
                        onCancelTap: () {
                          value.clearrs20();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs20();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs20();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total20)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 10",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs10fieldController,
                        onCancelTap: () {
                          value.clearrs10();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs10();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs10();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total10)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 5",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs5fieldController,
                        onCancelTap: () {
                          value.clearrs5();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs5();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs5();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total5)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 2",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs2fieldController,
                        onCancelTap: () {
                          value.clearrs2();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs2();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs2();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total2)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\u{20B9} 1",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                        Text(
                          "x",
                          style: TextStyle(color: Colors.white, fontSize: 19.h),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: textFieldWidget(
                        controller: value.rs1fieldController,
                        onCancelTap: () {
                          value.clearrs1();
                          value.calculatetotal();
                        },
                        onchange: (p0) {
                          if (p0.isEmpty) {
                            value.clearrs1();
                            value.calculatetotal();
                          } else {
                            value.multiplyrs1();
                            value.calculatetotal();
                          }
                        },
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "= \u{20B9} ${value.formatsum(value.total1)}",
                    style: TextStyle(color: Colors.white, fontSize: 19.h),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget textFieldWidget(
    {required TextEditingController controller,
    required Function(String) onchange,
    required Function() onCancelTap}) {
  return TextFormField(
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.white),
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
    ],
    decoration: InputDecoration(
        suffixIcon: controller.text.isNotEmpty
            ? GestureDetector(
                onTap: onCancelTap,
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                  size: 18.h,
                ),
              )
            : null,
        contentPadding: EdgeInsets.only(
          bottom: 45.h / 2,
        ),
        fillColor: Colors.white.withOpacity(.3),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.white))),
    onChanged: onchange,
  );
}
