//
//  HSGlobal.h
//  TR7TreesV3
//
//  Created by hoomsun on 16/6/14.
//  Copyright © 2016年 hoomsun. All rights reserved.
//



#ifndef Archive_CESGlobal_h
#define Archive_CESGlobal_h

#pragma mark - Font Value

// hxb 专用字体
#define HXB_Text_Font(s)                    [UIFont fontWithName:@"DINMittelschrift LT Alternate" size:(s)]
#define HXB_DetailText_Font(s)              [UIFont systemFontOfSize:(s)]
#define HXB_New_BoldFont(s)                 [UIFont fontWithName:@"DINMittelschrift LT Alternate" size:(s)]

//纯黑字体
#define BLACK_TEXT_COLOR                RGB(66,66,66)
#define BIG_TEXT_FONT(s)                       ([UIFont fontWithName:@"Helvetica" size:s])  //大字体用最细的字体
//label.font = [UIFont fontWithName:@"Helvetica" size:15.f];

//pingfang 普通
#define kHXBFont_PINGFANGSC_REGULAR(s)        ([UIFont fontWithName:@"PingFangSC-Regular" size:kScrAdaptationH(s)])
#define kHXBFont_HelveticaNeue_Medium_REGULAR(s)        ([UIFont fontWithName:@"HelveticaNeue-Medium" size:kScrAdaptationH(s)])
#define kHXBFont_HelveticaNeue_REGULAR(s)        ([UIFont fontWithName:@"HelveticaNeue" size:kScrAdaptationH(s)])
#define kHXBFont_MicrosoftYaHei_REGULAR(s)        ([UIFont fontWithName:@"MicrosoftYaHei" size:kScrAdaptationH(s)])
//pingfang 750 普通
#define kHXBFont_PINGFANGSC_REGULAR_750(s)        ([UIFont fontWithName:@"PingFangSC-Regular" size:kScrAdaptationH750(s)])




//pingfang light
#define PINGFANG_LIGHT(s)        ([UIFont fontWithName:@"PingFangSC-Light" size:s])

#define PINGFANG_Thin(s)        ([UIFont fontWithName:@"PingFangSC-Thin" size:s])

#define PINGFANG_Medium(s)        ([UIFont fontWithName:@"PingFangSC-Medium" size:s])

#define PINGFANG_Semibold(s)        ([UIFont fontWithName:@"PingFangSC-Semibold" size:s])

#define PINGFANG_SC_LIGHT(s)                    ([UIFont fontWithName:@".PingFang-SC-Light" size:s])


//字号库(PT)
#define SIZ1        48
#define SIZ2        40
#define SIZ3        32
#define SIZ4        30
#define SIZ5        29
#define SIZ6        23
#define SIZ7        22
#define SIZ8        19
#define SIZ9        18
#define SIZ10        17
#define SIZ11        16
#define SIZ12        15
#define SIZ13        14
#define SIZ14        13
#define SIZ15        12
#define SIZ16        11
#define SIZ17        10
#define SIZ18        26



/*
 
 Family: Copperplate
	Font: Copperplate-Light
	Font: Copperplate
	Font: Copperplate-Bold
 Family: Heiti SC
 Family: Iowan Old Style
	Font: IowanOldStyle-Italic
	Font: IowanOldStyle-Roman
	Font: IowanOldStyle-BoldItalic
	Font: IowanOldStyle-Bold
 Family: Kohinoor Telugu
	Font: KohinoorTelugu-Regular
	Font: KohinoorTelugu-Medium
	Font: KohinoorTelugu-Light
 Family: Thonburi
	Font: Thonburi
	Font: Thonburi-Bold
	Font: Thonburi-Light
 Family: Heiti TC
 Family: Courier New
	Font: CourierNewPS-BoldMT
	Font: CourierNewPS-ItalicMT
	Font: CourierNewPSMT
	Font: CourierNewPS-BoldItalicMT
 Family: Gill Sans
	Font: GillSans-Italic
	Font: GillSans-Bold
	Font: GillSans-BoldItalic
	Font: GillSans-LightItalic
	Font: GillSans
	Font: GillSans-Light
	Font: GillSans-SemiBold
	Font: GillSans-SemiBoldItalic
	Font: GillSans-UltraBold
 Family: Apple SD Gothic Neo
	Font: AppleSDGothicNeo-Bold
	Font: AppleSDGothicNeo-Thin
	Font: AppleSDGothicNeo-UltraLight
	Font: AppleSDGothicNeo-Regular
	Font: AppleSDGothicNeo-Light
	Font: AppleSDGothicNeo-Medium
	Font: AppleSDGothicNeo-SemiBold
 Family: Marker Felt
	Font: MarkerFelt-Thin
	Font: MarkerFelt-Wide
 Family: Avenir Next Condensed
	Font: AvenirNextCondensed-BoldItalic
	Font: AvenirNextCondensed-Heavy
	Font: AvenirNextCondensed-Medium
	Font: AvenirNextCondensed-Regular
	Font: AvenirNextCondensed-HeavyItalic
	Font: AvenirNextCondensed-MediumItalic
	Font: AvenirNextCondensed-Italic
	Font: AvenirNextCondensed-UltraLightItalic
	Font: AvenirNextCondensed-UltraLight
	Font: AvenirNextCondensed-DemiBold
	Font: AvenirNextCondensed-Bold
	Font: AvenirNextCondensed-DemiBoldItalic
 Family: Tamil Sangam MN
	Font: TamilSangamMN
	Font: TamilSangamMN-Bold
 Family: Helvetica Neue
	Font: HelveticaNeue-Italic
	Font: HelveticaNeue-Bold
	Font: HelveticaNeue-UltraLight
	Font: HelveticaNeue-CondensedBlack
	Font: HelveticaNeue-BoldItalic
	Font: HelveticaNeue-CondensedBold
	Font: HelveticaNeue-Medium
	Font: HelveticaNeue-Light
	Font: HelveticaNeue-Thin
	Font: HelveticaNeue-ThinItalic
	Font: HelveticaNeue-LightItalic
	Font: HelveticaNeue-UltraLightItalic
	Font: HelveticaNeue-MediumItalic
	Font: HelveticaNeue
 Family: Gurmukhi MN
	Font: GurmukhiMN-Bold
	Font: GurmukhiMN
 Family: Times New Roman
	Font: TimesNewRomanPSMT
	Font: TimesNewRomanPS-BoldItalicMT
	Font: TimesNewRomanPS-ItalicMT
	Font: TimesNewRomanPS-BoldMT
 Family: Georgia
	Font: Georgia-BoldItalic
	Font: Georgia 
	Font: Georgia-Italic
	Font: Georgia-Bold
 Family: Apple Color Emoji
	Font: AppleColorEmoji
 Family: Arial Rounded MT Bold
	Font: ArialRoundedMTBold
 Family: Kailasa
	Font: Kailasa-Bold
	Font: Kailasa
 Family: Kohinoor Devanagari
	Font: KohinoorDevanagari-Light
	Font: KohinoorDevanagari-Regular
	Font: KohinoorDevanagari-Semibold
 Family: Kohinoor Bangla
	Font: KohinoorBangla-Semibold
	Font: KohinoorBangla-Regular
	Font: KohinoorBangla-Light
 Family: Chalkboard SE
	Font: ChalkboardSE-Bold
	Font: ChalkboardSE-Light
	Font: ChalkboardSE-Regular
 Family: Sinhala Sangam MN
	Font: SinhalaSangamMN-Bold
	Font: SinhalaSangamMN
 Family: PingFang TC
	Font: PingFangTC-Medium
	Font: PingFangTC-Regular
	Font: PingFangTC-Light
	Font: PingFangTC-Ultralight
	Font: PingFangTC-Semibold
	Font: PingFangTC-Thin
 Family: Gujarati Sangam MN
	Font: GujaratiSangamMN-Bold
	Font: GujaratiSangamMN
 Family: Damascus
	Font: DamascusLight
	Font: DamascusBold
	Font: DamascusSemiBold
	Font: DamascusMedium
	Font: Damascus
 Family: Noteworthy
	Font: Noteworthy-Light
	Font: Noteworthy-Bold
 Family: Geeza Pro
	Font: GeezaPro
	Font: GeezaPro-Bold
 Family: Avenir
	Font: Avenir-Medium
	Font: Avenir-HeavyOblique
	Font: Avenir-Book
	Font: Avenir-Light
	Font: Avenir-Roman
	Font: Avenir-BookOblique
	Font: Avenir-Black
	Font: Avenir-MediumOblique
	Font: Avenir-BlackOblique
	Font: Avenir-Heavy
	Font: Avenir-LightOblique
	Font: Avenir-Oblique
 Family: Academy Engraved LET
	Font: AcademyEngravedLetPlain
 Family: Mishafi
	Font: DiwanMishafi
 Family: Futura
	Font: Futura-CondensedMedium
	Font: Futura-CondensedExtraBold
	Font: Futura-Medium
	Font: Futura-MediumItalic
 Family: Farah
	Font: Farah
 Family: Kannada Sangam MN
	Font: KannadaSangamMN
	Font: KannadaSangamMN-Bold
 Family: Arial Hebrew
	Font: ArialHebrew-Bold
	Font: ArialHebrew-Light
	Font: ArialHebrew
 Family: Arial
	Font: ArialMT
	Font: Arial-BoldItalicMT
	Font: Arial-BoldMT
	Font: Arial-ItalicMT
 Family: Party LET
	Font: PartyLetPlain
 Family: Chalkduster
	Font: Chalkduster
 Family: Hoefler Text
	Font: HoeflerText-Italic
	Font: HoeflerText-Regular
	Font: HoeflerText-Black
	Font: HoeflerText-BlackItalic
 Family: Optima
	Font: Optima-Regular
	Font: Optima-ExtraBlack
	Font: Optima-BoldItalic
	Font: Optima-Italic
	Font: Optima-Bold
 Family: Palatino
	Font: Palatino-Bold
	Font: Palatino-Roman
	Font: Palatino-BoldItalic
	Font: Palatino-Italic
 Family: Lao Sangam MN
	Font: LaoSangamMN
 Family: Malayalam Sangam MN
	Font: MalayalamSangamMN-Bold
	Font: MalayalamSangamMN
 Family: Al Nile
	Font: AlNile-Bold
	Font: AlNile
 Family: Bradley Hand
	Font: BradleyHandITCTT-Bold
 Family: PingFang HK
	Font: PingFangHK-Ultralight
	Font: PingFangHK-Semibold
	Font: PingFangHK-Thin
	Font: PingFangHK-Light
	Font: PingFangHK-Regular
	Font: PingFangHK-Medium
 Family: Trebuchet MS
	Font: Trebuchet-BoldItalic
	Font: TrebuchetMS
	Font: TrebuchetMS-Bold
	Font: TrebuchetMS-Italic
 Family: Helvetica
	Font: Helvetica-Bold
	Font: Helvetica
	Font: Helvetica-LightOblique
	Font: Helvetica-Oblique
	Font: Helvetica-BoldOblique
	Font: Helvetica-Light
 Family: Courier
	Font: Courier-BoldOblique
	Font: Courier
	Font: Courier-Bold
	Font: Courier-Oblique
 Family: Cochin
	Font: Cochin-Bold
	Font: Cochin
	Font: Cochin-Italic
	Font: Cochin-BoldItalic
 Family: Hiragino Mincho ProN
	Font: HiraMinProN-W6
	Font: HiraMinProN-W3
 Family: Devanagari Sangam MN
	Font: DevanagariSangamMN
	Font: DevanagariSangamMN-Bold
 Family: Oriya Sangam MN
	Font: OriyaSangamMN
	Font: OriyaSangamMN-Bold
 Family: Snell Roundhand
	Font: SnellRoundhand-Bold
	Font: SnellRoundhand
	Font: SnellRoundhand-Black
 Family: Zapf Dingbats
	Font: ZapfDingbatsITC
 Family: Bodoni 72
	Font: BodoniSvtyTwoITCTT-Bold
	Font: BodoniSvtyTwoITCTT-Book
	Font: BodoniSvtyTwoITCTT-BookIta
 Family: Verdana
	Font: Verdana-Italic
	Font: Verdana-BoldItalic
	Font: Verdana
	Font: Verdana-Bold
 Family: American Typewriter
	Font: AmericanTypewriter-CondensedLight
	Font: AmericanTypewriter
	Font: AmericanTypewriter-CondensedBold
	Font: AmericanTypewriter-Light
	Font: AmericanTypewriter-Bold
	Font: AmericanTypewriter-Condensed
 Family: Avenir Next
	Font: AvenirNext-UltraLight
	Font: AvenirNext-UltraLightItalic
	Font: AvenirNext-Bold
	Font: AvenirNext-BoldItalic
	Font: AvenirNext-DemiBold
	Font: AvenirNext-DemiBoldItalic
	Font: AvenirNext-Medium
	Font: AvenirNext-HeavyItalic
	Font: AvenirNext-Heavy
	Font: AvenirNext-Italic
	Font: AvenirNext-Regular
	Font: AvenirNext-MediumItalic
 Family: Baskerville
	Font: Baskerville-Italic
	Font: Baskerville-SemiBold
	Font: Baskerville-BoldItalic
	Font: Baskerville-SemiBoldItalic
	Font: Baskerville-Bold
	Font: Baskerville
 Family: Khmer Sangam MN
	Font: KhmerSangamMN
 Family: Didot
	Font: Didot-Italic
	Font: Didot-Bold
	Font: Didot
 Family: Savoye LET
	Font: SavoyeLetPlain
 Family: Bodoni Ornaments
	Font: BodoniOrnamentsITCTT
 Family: Symbol
	Font: Symbol
 Family: Menlo
	Font: Menlo-Italic
	Font: Menlo-Bold
	Font: Menlo-Regular
	Font: Menlo-BoldItalic
 Family: Bodoni 72 Smallcaps
	Font: BodoniSvtyTwoSCITCTT-Book
 Family: Papyrus
	Font: Papyrus
	Font: Papyrus-Condensed
 Family: Hiragino Sans
	Font: HiraginoSans-W3
	Font: HiraginoSans-W6
 
 Family: PingFang SC
	Font: PingFangSC-Ultralight
	Font: PingFangSC-Regular
	Font: PingFangSC-Semibold
	Font: PingFangSC-Thin
	Font: PingFangSC-Light
	Font: PingFangSC-Medium
	Font: .PingFang-SC-Light
 Family: Euphemia UCAS
	Font: EuphemiaUCAS-Italic
	Font: EuphemiaUCAS
	Font: EuphemiaUCAS-Bold
 Family: Telugu Sangam MN
 Family: Bangla Sangam MN
 Family: Zapfino
	Font: Zapfino
 Family: Bodoni 72 Oldstyle
	Font: BodoniSvtyTwoOSITCTT-Book
	Font: BodoniSvtyTwoOSITCTT-Bold
	Font: BodoniSvtyTwoOSITCTT-BookIt
 
 
 
 */


#endif

