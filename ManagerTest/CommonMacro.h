//
//  CommonMacro.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

//Screen
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEFULTTABBARHEIGHT 49
#define TITLESECTION_HEIGHT 40

//Color
#define Color(R,G,B)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define ColorWithAlpha(R,G,B,A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//Font
#define Font(S)         [UIFont systemFontOfSize:S]
#define MediumFont(S)   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.2)?[UIFont systemFontOfSize:S weight:UIFontWeightMedium]:[UIFont boldSystemFontOfSize:S]
#define BoldFont(S)     [UIFont boldSystemFontOfSize:S]

//Weak Self
#define WS(weakSelf)     __weak typeof(self) weakSelf = self
//strongSelf
#define StrS(strongSelf)   __strong typeof(self) strongSelf = weakSelf;

//Log
#if DEVELOPMENT
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//SAVE
#define Save(a,b) [[NSUserDefaults standardUserDefaults] setObject:a forKey:b]; [[NSUserDefaults standardUserDefaults] synchronize]
#define KImage(imageName)  [UIImage imageNamed:imageName]

//System info
#define kappversion [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"]
#define kdevicetype [[UIDevice currentDevice]systemVersion]
#define kdevicename [[UIDevice currentDevice]systemName]

#endif /* CommonMacro_h */
