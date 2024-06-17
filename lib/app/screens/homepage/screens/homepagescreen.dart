import 'package:denomination/app/screens/homepage/provider/homepageprovider.dart';
import 'package:denomination/app/screens/homepage/screens/historyScreen.dart';
import 'package:denomination/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class HomepageScreen extends StatefulWidget {
  HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      backgroundColor: Colors.black,
      floatingActionButton: context.read<HomepageProvider>().totalSum == 0
          ? null
          : ExpandableFab(
              key: _key,
              openButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const Icon(
                    Icons.electric_bolt,
                    color: Colors.white,
                  ),
                  fabSize: ExpandableFabSize.regular,
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  angle: 0),
              closeButtonBuilder: FloatingActionButtonBuilder(
                size: 56,
                builder: (BuildContext context, void Function()? onPressed,
                    Animation<double> progress) {
                  return FloatingActionButton(
                    backgroundColor: Colors.blue,
                    shape: const CircleBorder(),
                    onPressed: onPressed,
                    child: const Icon(
                      Icons.electric_bolt,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              distance: 70,
              type: ExpandableFabType.up,
              overlayStyle: ExpandableFabOverlayStyle(
                color: Colors.black.withOpacity(0.5),
                // blur: 5,
              ),
              children: [
                FloatingActionButton.small(
                  heroTag: null,
                  child: const Icon(Icons.restart_alt),
                  onPressed: () {
                    _key.currentState!.toggle();
                    context.read<HomepageProvider>().clearAllFields();
                  },
                ),
                FloatingActionButton.small(
                  heroTag: null,
                  child: const Icon(Icons.download),
                  onPressed: () {
                    TextEditingController name = TextEditingController();
                    _key.currentState!.toggle();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          var category = [
                            'General',
                            'Income',
                            'Expense',
                          ];
                          var dropdownvalue = 'General';
                          if (context.read<HomepageProvider>().currentNote !=
                              null) {
                            dropdownvalue = context
                                .read<HomepageProvider>()
                                .currentNote!
                                .category;
                            name.text = context
                                .read<HomepageProvider>()
                                .currentNote!
                                .name;
                          }

                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 25.h,
                                            )),
                                      ],
                                    ),
                                    StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function())
                                              setState) {
                                        return DropdownButton(
                                          isExpanded: true,
                                          value: dropdownvalue,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: category.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                        height: 120.h,
                                        child: TextField(
                                          controller: name,
                                          maxLines: 2,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(),
                                            border: OutlineInputBorder(),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 150.h,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        onPressed: () {
                                          if (context
                                                  .read<HomepageProvider>()
                                                  .currentNote !=
                                              null) {
                                            context
                                                .read<HomepageProvider>()
                                                .updateNote(
                                                    name.text, dropdownvalue);
                                          } else {
                                            context
                                                .read<HomepageProvider>()
                                                .saveData(
                                                    name.text.isEmpty
                                                        ? ""
                                                        : name.text,
                                                    dropdownvalue);
                                          }

                                          Navigator.pop(context);
                                        },
                                        color: Colors.black,
                                        child: const Text(
                                          "Save",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
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
                top: 20,
                right: 0,
                child: PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return HistoryScreen();
                        }));
                      },
                      value: 1,
                      child: const Row(
                        children: [
                          Icon(Icons.history),
                          SizedBox(
                            width: 10,
                          ),
                          Text("History")
                        ],
                      ),
                    ),
                  ],
                  color: Colors.grey,
                  elevation: 2,
                ),
              ),
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
                    value.totalSum != 0
                        ? Text(
                            "${value.formatsum(value.totalSum)}",
                            style: TextStyle(
                                fontSize: 22.h,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        : const SizedBox(),
                    value.totalSum != 0
                        ? Text(
                            softWrap: true,
                            "${toBeginningOfSentenceCase(NumberToWordsEnglish.convert(value.totalSum))} Only/-",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18.h,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        : const SizedBox(),
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
