import 'package:build/shared/cubit/home_cubit.dart';
import 'package:build/view/components/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../main.dart';
import '../components/component.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  List<DropdownMenuItem<String>> projectNameList = [];
  void fillProjects() {
    projectNameList.clear();
    projects.forEach((element) {
      String? projectName = element.username;
      String? projectid = element.projectId;
      projectNameList.add(
        DropdownMenuItem<String>(
          value: projectid,
          child: Center(
            child: Text(
              projectName!,
              style: TextStyle(color: CustomColors.KmainColor),
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    fillProjects();
  }
  // void currentProject(String value) {
  //   projects.where((element) {
  //     print(element.username == value);
  //     return element.username == value;
  //   });
  // }

  List<Map<String, dynamic>> projectMap = [];

  String? dropdownvalue;
  final List<TextEditingController> _controllers = [];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) => MyApp()), (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is GetProjectSuccess) {
              fillProjects();
              print("This is on Restart $progressprecent");
            }
          },
          builder: (context, state) {
            HomeCubit homeCubit = HomeCubit.get(context);
            // homeCubit.projectModel!.progress = progressprecent;

            void _showSheet() {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  final GlobalKey<FormState> _dialogFormKey =
                      GlobalKey<FormState>();
                  final TextEditingController _textEditingController =
                      TextEditingController();

                  // this widget shows the Bottom Sheet for the Income.
                  return SingleChildScrollView(
                    child: BalanceBottomSheet(
                        screenSize: screenSize,
                        dialogFormKey: _dialogFormKey,
                        textEditingController: _textEditingController,
                        homeCubit: homeCubit),
                  );
                },
              ).then((value) {
                setState(() {
                  progressprecent = value;
                  homeCubit.updateProgress(
                    projectId: dropdownvalue!,
                    progress: progressprecent,
                  );
                });
              });
            }

            return ConditionalBuilderRec(
              condition: state is! GetProjectLoading,
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (homeCubit.userModel?.role == 'Agent')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text(
                            'Choose A Project',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            child: DropdownButton(
                              value: dropdownvalue,
                              items: projectNameList,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                  selectedProject = dropdownvalue!;
                                  homeCubit.getProject(id: dropdownvalue);
                                  print(selectedProject);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilderRec(
                    fallback: (context) => const Center(
                      child: Text('Please Choose a Project'),
                    ),
                    condition: homeCubit.projectModel?.userID != null,
                    builder: (context) => Column(children: [
                      Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: images.length,
                            itemBuilder: (context, index, realIndex) {
                              final urlImage = images[index];
                              return Container(
                                margin: const EdgeInsets.only(left: 15),
                                width: screenSize.width * 0.9,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black12,
                                  image: DecorationImage(
                                    image: NetworkImage(urlImage),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                                height: 200,
                                enableInfiniteScroll: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    activeIndex = index;
                                  });
                                }),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AnimatedSmoothIndicator(
                            activeIndex: activeIndex,
                            count: images.length,
                            effect: const WormEffect(
                              activeDotColor: Colors.blueAccent,
                              dotWidth: 10,
                              dotHeight: 10,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Project Progress',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            if (homeCubit.userModel?.role == 'Agent')
                              IconButton(
                                onPressed: () {
                                  _showSheet();
                                },
                                icon: const Icon(Icons.more_horiz),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: screenSize.width * 0.8,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: LinearProgressIndicator(
                              value: progressprecent / 10,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                              backgroundColor: Colors.black12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Latest Feeds',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ConditionalBuilderRec(
                                fallback: (context) =>
                                    const CircularProgressIndicator(),
                                condition: homeCubit.feeds.isNotEmpty,
                                builder: (context) => homeCubit.feeds.isNotEmpty
                                    ? SizedBox(
                                        height: screenSize.height * 0.5,
                                        child: ListView.builder(
                                          itemCount: homeCubit.feeds.length,
                                          itemBuilder: ((context, index) {
                                            _controllers
                                                .add(TextEditingController());
                                            return Column(
                                              children: [
                                                Card(
                                                  elevation: 5,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                bottom: 20,
                                                                top: 20),
                                                        decoration: const BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                        .grey))),
                                                        width: double.infinity,
                                                        child: Text(
                                                          homeCubit.feeds[index]
                                                              .feed!,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      if (homeCubit.feeds[index]
                                                              .feedImages !=
                                                          '')
                                                        GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  content: Image
                                                                      .network(
                                                                    homeCubit
                                                                        .feeds[
                                                                            index]
                                                                        .feedImages!,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                Image.network(
                                                              homeCubit
                                                                  .feeds[index]
                                                                  .feedImages!,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      if (homeCubit.commentList
                                                          .isNotEmpty)
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: homeCubit
                                                                      .commentList
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    var commentIndex =
                                                                        homeCubit
                                                                            .commentList[index];
                                                                    return SizedBox(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                40,
                                                                            height:
                                                                                40,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              image: DecorationImage(
                                                                                image: NetworkImage(
                                                                                  commentIndex.profileImage,
                                                                                ),
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            child:
                                                                                Text(commentIndex.comment),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                        ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: 100,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 15),
                                                              child: Container(
                                                                width: 40,
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        NetworkImage(
                                                                      homeCubit
                                                                          .userModel!
                                                                          .profileImage!,
                                                                    ),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: screenSize
                                                                      .width *
                                                                  0.6,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    _controllers[
                                                                        index],
                                                              ),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  homeCubit
                                                                      .sendComment(
                                                                    commentId: homeCubit
                                                                        .feeds[
                                                                            index]
                                                                        .feedId!,
                                                                    projectId:
                                                                        selectedProject,
                                                                    userComment:
                                                                        _controllers[index]
                                                                            .text,
                                                                  );
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.send,
                                                                  size: 14,
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                )
                                              ],
                                            );
                                          }),
                                        ),
                                      )
                                    : const Center(
                                        child: Text('There is no Feeds'),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
