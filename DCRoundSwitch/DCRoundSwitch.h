//
//  DCRoundSwitch.h
//
//  Created by Patrick Richards on 28/06/11.
//  MIT License.
//
//  http://twitter.com/patr
//  http://domesticcat.com.au/projects
//  http://github.com/domesticcatsoftware/DCRoundSwitch
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class DCRoundSwitchToggleLayer;
@class DCRoundSwitchOutlineLayer;
@class DCRoundSwitchKnobLayer;

@interface DCRoundSwitch : UIControl
{
	@private
		DCRoundSwitchOutlineLayer *outlineLayer;
		DCRoundSwitchToggleLayer *toggleLayer;
		DCRoundSwitchKnobLayer *knobLayer;
		CAShapeLayer *clipLayer;
		BOOL ignoreTap;
}

@property (nonatomic, getter=isOn) BOOL on;				// default: NO
@property (nonatomic, assign) BOOL glossy;              // default: YES

@property (nonatomic, retain) UIColor *onTintColor;		// default: blue (matches normal UISwitch)
@property (nonatomic, retain) UIColor *offTintColor;    // default: white
@property (nonatomic, copy)  NSString *onText;			// default: 'ON' - not automatically localized!
@property (nonatomic, retain) UIColor *onTextColor;
@property (nonatomic, retain) UIColor *onTextShadowColor;

@property (nonatomic, copy)  NSString *offText;			// default: 'OFF' - not automatically localized!
@property (nonatomic, retain) UIColor *offTextColor;
@property (nonatomic, retain) UIColor *offTextShadowColor;
@property (nonatomic, retain) UIImage *onImage;         // default: nil - drawn behind text
@property (nonatomic, retain) UIImage *offImage;        // default: nil - drawn behind text

- (void)setOn:(BOOL)newOn animated:(BOOL)animated;
- (void)setOn:(BOOL)newOn animated:(BOOL)animated ignoreControlEvents:(BOOL)ignoreControlEvents;

@end
