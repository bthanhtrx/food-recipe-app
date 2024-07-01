import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/core/common/constant.dart';
import 'package:food_recipe_app/providers/app_provider.dart';
import 'package:gap/gap.dart';

class AdvancedSearchDialog extends ConsumerStatefulWidget {
  const AdvancedSearchDialog({super.key});

  @override
  _AdvancedSearchDialogState createState() => _AdvancedSearchDialogState();
}

class _AdvancedSearchDialogState extends ConsumerState<AdvancedSearchDialog> {
  int _servings = 1;
  String _cuisines = '';
  bool _isVegan = false;
  bool _isGlutenFree = false;
  bool _isDairyFree = false;
  bool _isHealthy = false;

  @override
  void initState() {
    _isVegan = ref.read(isVeganProvider);
    _isGlutenFree = ref.read(isGlutenFreeProvider);
    _isDairyFree = ref.read(isDairyFreeProvider);
    _servings = ref.read(servingsProvider);
    _cuisines = ref.read(cuisinesProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.brown.shade400,
      title: Text('Filter'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(10),
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Servings'),
            Slider(
              divisions: 7,
              label: '$_servings',
              value: _servings.toDouble(),
              thumbColor: Colors.blueAccent,
              onChanged: (value) {
                setState(() {
                  _servings = value.toInt();
                });
              },
              max: 8,
              min: 1,
            ),
            Text('Cuisines'),
            DropdownMenu(
              initialSelection: 'No specified',
                menuStyle:
                    MenuStyle(fixedSize: WidgetStatePropertyAll(Size(50, 150))),
                dropdownMenuEntries: Constant.recipeCuisines
                    .map(
                      (e) => DropdownMenuEntry(value: e, label: e,),
                    )
                    .toList()),
            Gap(10),
            Text('Optional'),
            Gap(10),
            SizedBox(
              height: 200,
              width: 300,
              child: GridView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 2,
                ),
                children: [
                  CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(
                      'Vegan',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    value: _isVegan,
                    onChanged: (value) {
                      ref.read(isVeganProvider.notifier).setIsVegan(value!);
                      setState(() {
                        _isVegan = !_isVegan;
                      });
                    },
                  ),
                  CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(
                      'Gluten Free',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    value: _isGlutenFree,
                    onChanged: (value) {
                      ref
                          .read(isGlutenFreeProvider.notifier)
                          .setIsGlutenFree(value!);
                      setState(() {
                        _isGlutenFree = !_isGlutenFree;
                      });
                    },
                  ),
                /*  CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(
                      'Dairy Free',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    value: _isDairyFree,
                    onChanged: (value) {
                      ref
                          .read(isDairyFreeProvider.notifier)
                          .setIsDairyFree(value!);
                      setState(() {
                        _isDairyFree = !_isDairyFree;
                      });
                    },
                  ),
                  CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(
                      'Healthy',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    value: _isHealthy,
                    onChanged: (value) {
                      setState(() {
                        _isHealthy = !_isHealthy;
                      });
                    },
                  ),*/
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          ({
                            'servings': _servings,
                            'cuisines': _cuisines,
                            'isVegan': _isVegan,
                            'isGlutenFree': _isGlutenFree,
                            'isDairyFree': _isDairyFree,
                            'isHealthy': _isHealthy,
                          }));
                    },
                    child: Text('Ok')),
              ],
            )
          ],
        ),
      ],
    );
  }
}
