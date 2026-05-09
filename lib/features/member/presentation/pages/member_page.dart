import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/add_member_dialog.dart';

class MemberPage extends ConsumerStatefulWidget {
  const MemberPage({super.key});

  @override
  ConsumerState<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends ConsumerState<MemberPage> {
  final search = TextEditingController();

  void _createMember() {
    showDialog(context: context, builder: (context) => AddMemberDialog());
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(memberDataProvider);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.blue.withValues(alpha: 0.9),
        shape: CircleBorder(),
        child: Center(
          child: IconButton(
            onPressed: _createMember,
            icon: Icon(Icons.person_add_alt, color: AppColor.white),
          ),
        ),
        onPressed: () {},
      ),
      body: Padding(
        padding: globalPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppInput(
              controller: search,
              keyboardType: TextInputType.text,
              labelText: "Recherche...",
              prefixIcon: Icons.search_outlined,
            ),

            SizedBox(height: 16.h),

            Expanded(
              child: members.when(
                data: (members) {
                  return RefreshIndicator(
                    onRefresh: () =>
                        ref.read(memberDataProvider.notifier).refresh(),
                    child: ListView.builder(
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        final member = members[index];

                        return Container(
                          margin: EdgeInsets.only(bottom: 6.h),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColor.blue.withValues(
                                alpha: 0.1,
                              ),
                              radius: 18.r,
                              child: Center(
                                child: AppText(
                                  label:
                                      member.fullName[0] + member.fullName[1],
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            title: AppText(
                              label: member.fullName,
                              fontWeight: FontWeight.w700,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: AppText(label: member.numberPhone),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.visibility_rounded),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, _) {
                  debugPrint("Erreur: $error");
                  return Center(
                    child: AppText(
                      label: "Erreur de connexion au serveur",
                      color: AppColor.red,
                    ),
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}
