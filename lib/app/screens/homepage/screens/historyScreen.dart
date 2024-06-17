import 'package:denomination/app/screens/homepage/model/note_model.dart';
import 'package:denomination/app/screens/homepage/provider/homepageprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<NoteModel>> getNotes() async {
    final box = Hive.box<NoteModel>('notes');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          "History",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder:
            (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No history available.');
          } else {
            var notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                Color amountcolor = notes[index].category == 'General'
                    ? Colors.blue
                    : notes[index].category == 'Income'
                        ? Colors.green
                        : Colors.red;

                final formattedDate =
                    DateFormat('MMMM d, y').format(notes[index].date);
                final formattedTime =
                    DateFormat('hh:mm a').format(notes[index].date);
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Slidable(
                    startActionPane:
                        ActionPane(motion: const BehindMotion(), children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await notes[index].delete();
                          setState(() {});
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          context
                              .read<HomepageProvider>()
                              .editNote(notes[index]);
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.blue,
                        icon: Icons.edit,
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          final content = context
                              .read<HomepageProvider>()
                              .generateShareContent(notes[index]);
                          Share.share(content);
                        },
                        backgroundColor: Colors.green,
                        icon: Icons.share,
                      ),
                    ]),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey.withOpacity(.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notes[index].category,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\u{20B9}  ${context.read<HomepageProvider>().formatsum(notes[index].totalSum)}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: amountcolor,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    formattedDate,
                                    style:
                                        const TextStyle(color: Colors.white54),
                                  ),
                                  Text(
                                    formattedTime,
                                    style:
                                        const TextStyle(color: Colors.white54),
                                  )
                                ],
                              )
                            ],
                          ),
                          notes[index].name == ''
                              ? const SizedBox()
                              : Text(
                                  notes[index].name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
