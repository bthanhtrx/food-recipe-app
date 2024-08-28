import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/firebase_auth_service.dart';
import 'package:food_recipe_app/providers/app_provider.dart';
import 'package:food_recipe_app/widgets/authentication.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    nameController.text = ref.watch(userNameProvider);

    final authState = ref.watch(currentUserStream);

    return Scaffold(
        body: authState.when(
      data: (data) {
        if(data == null) {
          return  SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                      clipBehavior: Clip.none,
                      // alignment: Alignment.center,
                      children: [
                        Container(
                          child: Image.asset('assets/images/profile.jpg'),
                          margin: const EdgeInsets.only(bottom: 50),
                        ),
                        const Positioned(
                            bottom: 0,
                            right: 50,
                            left: 50,
                            child: CircleAvatar(
                              child: Icon(
                                Icons.account_circle_outlined,
                                size: 100,
                              ),
                              radius: 50,
                            )),
                      ]),
                  const Text('Sign in for more personalized recipes recommendation.'),
                  const Authentication()
                ]),
          );
        }
        return Column(children: [
          Stack(
              clipBehavior: Clip.none,
              // alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: Image.asset('assets/images/profile.jpg'),
                ),
                const Positioned(
                    bottom: 0,
                    right: 50,
                    left: 50,
                    child: CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 100,
                      ),
                    )),
                Positioned(
                        top: 30,
                        right: 10,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Do you want to sign out?',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        ref.read(firebaseAuthServiceProvider).signOut();
                                        Navigator.pop(context);
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                      }),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                          ),
                        ))
              ]),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  data.displayName ?? 'User',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 25),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text('Your Name'),
                //     const Spacer(),
                //     Expanded(
                //       child: TextField(
                //         onTapOutside: (event) {
                //           FocusScope.of(context).unfocus();
                //         },
                //         controller: nameController,
                //         decoration: InputDecoration(
                //             hintText: 'Name',
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10),
                //                 borderSide: const BorderSide(width: 1))),
                //         onSubmitted: (value) {
                //           if (ref.read(currentUser) != null) {
                //             ref.read(currentUser)?.updateDisplayName(value);
                //             // FirestoreService().updateUser();
                //           } else {
                //             ref
                //                 .read(userNameProvider.notifier)
                //                 .setUserName(value.trim());
                //           }
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Mode'),
                    Switch(
                      value: ref.watch(isDarkMode),
                      onChanged: (value) {
                        ref.read(appThemeProvider.notifier).state =
                            ref.watch(appThemeProvider) == ThemeMode.dark
                                ? ThemeMode.light
                                : ThemeMode.dark;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Unit of measurement'),
                    DropdownMenu(
                      initialSelection: ref.watch(unitMeasurementProvider),
                      dropdownMenuEntries: ['us', 'metric']
                          .map(
                            (e) => DropdownMenuEntry(label: e, value: e),
                          )
                          .toList(),
                      inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onSelected: (value) {
                        ref
                            .read(unitMeasurementProvider.notifier)
                            .setUnitMeasurement(value!);
                      },
                    )
                  ],
                ),
              ],
            ),
          )
        ]);
      },
      error: (error, stackTrace) {},
      loading: () => CircularProgressIndicator(),
    ));
  }
}
