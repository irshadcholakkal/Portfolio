import 'package:flutter/material.dart';

import '../statics/key_holders.dart';
import '../statics/data_values.dart';
import '../theme/app_theme.dart';
import '../widgets/button_text.dart';
import '../widgets/text_pairs.dart';
import '../widgets/container_card.dart';
import '../widgets/container_banner.dart';
import '../widgets/frame_title.dart';

class DS2AboutMe extends StatelessWidget {
  const DS2AboutMe({Key? key}) : super(key: key);

  Widget bio(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPairs().type1(
                  title: DataValues.aboutMeFullNameTitle,
                  description: DataValues.aboutMeFullNameDescription,
                ),
                const SizedBox(height: 15.0),
                TextPairs().type1(
                  title: DataValues.aboutMeGenderTitle,
                  description: DataValues.aboutMeGenderDescription,
                ),
                const SizedBox(height: 30.0),
                TextPairs().type1(
                  title: DataValues.aboutMeDobTitle,
                  description: DataValues.aboutMeDobDescription,
                ),
                const SizedBox(height: 30.0),
                TextPairs().type1(
                  title: DataValues.aboutMeLocationTitle,
                  description: DataValues.aboutMeLocationDescription,
                ),
                // const SizedBox(height: 30.0),
                // TextPairs().type1(
                //   title: DataValues.aboutMeLanguageTitle,
                //   description: DataValues.aboutMeLanguageDescription,
                // ),

                // const SizedBox(height: 15.0),
                // TextPairs().type1(
                //   title: DataValues.aboutMeHobbiesTitle,
                //   description: DataValues.aboutMeHobbiesDescription,
                // ),

              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextPairs().type4(title: 'Education'),
                // const SizedBox(height: 10.0),
                // TextPairs().type5(
                //   title: 'MCA',
                //   description: 'University of Calicut\nOctober 2021 to August 2023',

                // ),
                // const SizedBox(height: 20.0),
                // TextPairs().type5(
                //   title: 'BCA',
                //   description: 'University of Calicut\nJune 2018 to August 2021',
                // ),
                const SizedBox(height: 30.0),
                 SelectableText(
                DataValues.aboutMeSkillsTitle,
                style: AppThemeData.darkTheme.textTheme.titleMedium),
                for(int i=0;i<DataValues.aboutMeSkillsDescriptionImage.length;i++)...{
                TextPairs().type1(
                  heights: 0,
                  widget:Image.asset(DataValues.aboutMeSkillsDescriptionImage[i], height: 20.0, width: 20.0) ,
                  title:'',

                  description: DataValues.aboutMeSkillsDescription[i],
                ),
                }
                // const SizedBox(height: 30.0),

              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: KeyHolders.aboutKey,
      // color: AppThemeData.backgroundGrey,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FrameTitle(
                title: DataValues.aboutMeTitle,
                description: DataValues.aboutMeDescription),
            const SizedBox(height: 40.0),
            bio(context),
            const SizedBox(height: 35.0),

          ],
        ),
      ),
    );
  }
}
