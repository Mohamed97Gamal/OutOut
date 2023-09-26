import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/providers/my_profile_provider.dart';
import 'package:flairstechsuite_mobile/screens/home/pages/employee/myemployee_profile_page.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeTile extends StatelessWidget {
  final EmployeeProfileDTO employee;
  final Color? backgroundColor;
  final Widget? leading, trailing;
  final EdgeInsetsGeometry margin;

  const EmployeeTile({
    Key? key,
    required this.employee,
    required this.backgroundColor,
    this.margin = const EdgeInsetsDirectional.only(start: 16, end: 56, top: 8),
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: margin,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: Colors.grey, width: 0.7),
        ),
        child: InkWell(
          onTap: () async {
            final userId =
                await Provider.of<MyProfileProvider>(context, listen: false)
                    .get(force: true)
                    .then((value) => value.result!.id!);
            if (userId == employee.id) {
              Navigation.navToMyProfile(context);
            } else {
              Navigation.navToViewEmployeeProfile(context, employee.id);
            }
          },
          child: Container(
            color: backgroundColor,
            alignment: Alignment.center,
            child: ListTile(
              leading: leading,
              title: Text(
                employee.fullName!,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Color(0xff131315),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Text(
                employee.title ?? "",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Color(0xff131315),
                    ),
              ),
              trailing: trailing,
            ),
          ),
        ),
      ),
    );
  }
}
