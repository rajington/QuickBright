//
//  QBAppDelegate.h
//  QuickBright
//
//  Created by Rajarshi Nigam 27/12/11.
//  MIT License
//

#import <UIKit/UIKit.h>

@class QBTableViewController;

@interface QBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) QBTableViewController *viewController;

- (void)launchQuickSwitch;

@end