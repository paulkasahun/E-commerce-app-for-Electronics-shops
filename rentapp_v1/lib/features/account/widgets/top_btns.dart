import 'package:flutter/material.dart';
import 'package:rentapp_v1/features/account/services/services.dart';
import 'package:rentapp_v1/features/account/widgets/account_btn.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            AccountButton(
              onTap: () {},
              text: "Turn Rented",
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logout(context),
            ),
            AccountButton(
              text: 'Wish List',
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }
}
