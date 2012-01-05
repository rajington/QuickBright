//
//  QBAppDelegate.m
//  QuickBright
//
//  Created by Rajarshi Nigam 27/12/11.
//  MIT License
//

#import "QBAppDelegate.h"

#import "QBTableViewController.h"
#import "QBConstants.h"

@implementation QBAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)launchQuickSwitch{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys: 
                                [NSNumber numberWithFloat:QBHighBrightnessDefault], QBHighBrightnessKey,
                                [NSNumber numberWithFloat:QBLowBrightnessDefault], QBLowBrightnessKey,
                                QBQuickSwitchDisabled, QBQuickSwitchKey, nil]];
    
    float highBrightness = [defaults floatForKey:QBHighBrightnessKey];
    float lowBrightness = [defaults floatForKey:QBLowBrightnessKey];
    
    if(highBrightness < lowBrightness){
        [defaults setValue:[NSNumber numberWithFloat:lowBrightness] forKey:QBHighBrightnessKey];
        [defaults setValue:[NSNumber numberWithFloat:highBrightness] forKey:QBLowBrightnessKey];
        highBrightness = [defaults floatForKey:QBHighBrightnessKey];
        lowBrightness = [defaults floatForKey:QBLowBrightnessKey];
    }
    
    NSString *quickSwitch = [defaults stringForKey:QBQuickSwitchKey];
    
    if([quickSwitch isEqualToString:QBQuickSwitchSwitchAndExit]){
        UIScreen *screen = [UIScreen mainScreen];
        float currentBrightness = [screen brightness];
        
        if ( (highBrightness - currentBrightness) > (currentBrightness - lowBrightness) ){
            [screen setBrightness:highBrightness];
        } else {
            [screen setBrightness:lowBrightness];
        }
        exit(0);
    } else if([quickSwitch isEqualToString:QBQuickSwitchSetSystem]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Brightness"]];
    }
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self launchQuickSwitch];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[QBTableViewController alloc] initWithNibName:@"QBTableViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self launchQuickSwitch];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
