import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/row_spacing.dart';
import 'package:gaming_startup_ai_agent/src/widgets/text.dart';

class AgentCapability extends StatelessWidget {
  final String svgPath;
  final String title;
  final String body;
  final bool isMobile;

  const AgentCapability({
    super.key,
    required this.svgPath,
    required this.title,
    required this.body,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? Container(
          width: double.maxFinite,
          //height: 190,
          decoration: BoxDecoration(
            color: context.onPrimary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: context.primaryContainer.withOpacity(0.4),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          //padding: EdgeInsets.all(8),
          child: ListTile(
            leading: SvgPicture.asset(
              svgPath,
              width: 32,
              color: context.tertiary,
            ),
            title: KText(
              title,
              fontSize: 14,
              color: context.tertiary,
              fontWeight: FontWeight.w500,
            ),
            subtitle: KText(body, fontSize: 14, textAlign: TextAlign.left),
          ),
          /*Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(svgPath, width: 24, color: context.tertiary),
              RowSpacing(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  KText(
                    title,
                    fontSize: 14,
                    color: context.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                  ColSpacing(8),
                  SizedBox(

                      child: KText(body, fontSize: 15, textAlign: TextAlign.center)),
                ],
              ),
            ],
          )*/
        )
        : Container(
          width: 290,
          height: 190,
          decoration: BoxDecoration(
            color: context.onPrimary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: context.primaryContainer.withOpacity(0.4),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(svgPath, width: 50, color: context.tertiary),
                  RowSpacing(width: 8),
                  KText(title, fontSize: 19, color: context.tertiary),
                ],
              ),
              ColSpacing(16),
              KText(body, fontSize: 20, textAlign: TextAlign.center),
            ],
          ),
        );
  }
}
