import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/home_page/models/promo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    this.enableShadow,
    this.width,
    required this.promoItem,
  });

  final bool? enableShadow;
  final Promo promoItem;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.homePagePromoDetailsRoute, arguments: {
          'promoItemId': promoItem.idPromo,
        });
      },
      borderRadius: BorderRadius.circular(15.r),
      child: Hero(
        tag: 'promo_${promoItem.idPromo}',
        child: Container(
          width: width ?? 282.w,
          height: 188.h,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15.r),
            image: DecorationImage(
              image: CachedNetworkImageProvider(promoItem.foto ??
                  'https://cdn-site.gojek.com/uploads/PROMO_EDUKASI_COBAINGOJEK_FB_Ads_1_29d7243ace/PROMO_EDUKASI_COBAINGOJEK_FB_Ads_1_29d7243ace.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor.withAlpha(150),
                BlendMode.srcATop,
              ),
            ),
            boxShadow: [
              if (enableShadow == true)
                const BoxShadow(
                  color: Color.fromARGB(115, 71, 70, 70),
                  offset: Offset(0, 2),
                  blurRadius: 8,
                ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: promoItem.type.capitalize,
                    style: Get.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                    children: promoItem.type.toLowerCase() == 'voucher'
                        ? []
                        : [
                            TextSpan(
                              text: ' ${promoItem.diskon} %',
                              style: Get.textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = Colors.white,
                              ),
                            ),
                          ],
                  ),
                ),
                Text(
                  promoItem.nama,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
