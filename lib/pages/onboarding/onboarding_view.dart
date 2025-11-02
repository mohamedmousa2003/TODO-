import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_note/core/const/colors.dart';
import '../../core/const/constString.dart';
import '../home/home_view.dart';
import 'Onboarding_items.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});
  static String routeName = "OnboardingOneScreen";

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();
  bool lastPage = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;

            return PageView.builder(
              controller: pageController,
              itemCount: controller.items.length,
              onPageChanged: (index) {
                setState(() => lastPage = index == controller.items.length - 1);
              },
              itemBuilder: (context, index) {
                final item = controller.items[index];
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.06,
                      vertical: height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: index != controller.items.length - 1
                              ? TextButton(
                            onPressed: () {
                              pageController.jumpToPage(
                                  controller.items.length - 1);
                            },
                            child: Text(
                              ConstString.skip,
                              style: GoogleFonts.aBeeZee(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: blueColor,
                              ),
                            ),
                          )
                              : const SizedBox(height: 40),
                        ),

                        SizedBox(height: height * 0.02),

                        Image.asset(
                          item.image,
                          height: height * 0.35,
                          fit: BoxFit.contain,
                        ),

                        SizedBox(height: height * 0.04),

                        SmoothPageIndicator(
                          controller: pageController,
                          count: controller.items.length,
                          effect: const SlideEffect(
                            spacing: 10.0,
                            radius: 20.0,
                            dotWidth: 45,
                            dotHeight: 8,
                            activeDotColor: blueColor,
                          ),
                          onDotClicked: (index) {
                            pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),

                        SizedBox(height: height * 0.05),

                        // Animated Title
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            item.title,
                            key: ValueKey(item.title),
                            style: GoogleFonts.aBeeZee(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: blueColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: height * 0.02),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            item.description,
                            key: ValueKey(item.description),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: grayColor,
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.08),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (index != 0)
                              TextButton(
                                onPressed: () {
                                  pageController.previousPage(
                                    duration:
                                    const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  ConstString.back,
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: blueColor,
                                  ),
                                ),
                              )
                            else
                              const SizedBox(),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blueColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 13),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (index != controller.items.length - 1) {
                                  pageController.nextPage(
                                    duration:
                                    const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, HomeView.routeName);
                                }
                              },
                              child: Text(
                                index == controller.items.length - 1
                                    ? ConstString.getStarted
                                    : ConstString.next,
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
