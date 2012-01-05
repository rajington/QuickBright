//
//  QBTableViewController.h
//  QuickBright
//
//  Created by Rajarshi Nigam 27/12/11.
//  MIT License
//

#import <UIKit/UIKit.h>
#import "DCRoundSwitch.h"

@interface QBTableViewController : UITableViewController {
    NSIndexPath *_prevIndexPath;
    NSUserDefaults *_defaults;
}

@property (nonatomic, retain) NSIndexPath *prevIndexPath;
@property (nonatomic, retain) NSUserDefaults *defaults;

@property (retain, nonatomic) IBOutlet UISlider *highBrightness;
@property (retain, nonatomic) IBOutlet UISlider *lowBrightness;
@property (retain, nonatomic) IBOutlet DCRoundSwitch *brightnessSwitch;

@property (retain, nonatomic) IBOutlet UITableViewCell *lowBrightnessSliderCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *brightnessSwitchCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *highBrightnessSliderCell;

- (IBAction)highBrightnessChanged;
- (IBAction)lowBrightnessChanged;
- (IBAction)brightnessChanged;
- (IBAction)saveBrightnessDefaults;

- (void)userDefaultsDidChange;

@end
