//
//  QBTableViewController.m
//  QuickBright
//
//  Created by Rajarshi Nigam 27/12/11.
//  MIT License
//

#import "QBTableViewController.h"
#import "QBConstants.h"
#import "QBSettingsWarningViewController.h"

@implementation QBTableViewController
@synthesize highBrightnessSliderCell;
@synthesize highBrightness;
@synthesize brightnessSwitch;
@synthesize lowBrightness;
@synthesize lowBrightnessSliderCell;
@synthesize brightnessSwitchCell;

@synthesize prevIndexPath = _prevIndexPath;
@synthesize defaults = _defaults;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    brightnessSwitch.offText = @"";
    brightnessSwitch.offTintColor = [UIColor lightGrayColor];
    brightnessSwitch.offImage = [UIImage imageNamed:@"HighSwitch.png"];
    
    brightnessSwitch.onText = @"";
    brightnessSwitch.onTintColor = [UIColor darkGrayColor];
    brightnessSwitch.onImage = [UIImage imageNamed:@"LowSwitch.png"];
    
    brightnessSwitch.clipsToBounds = YES;
    brightnessSwitch.glossy = NO;
    brightnessSwitch.transform = CGAffineTransformMakeRotation( M_PI / 2 );
    
    // the only way the view has loaded to this point is if Quick Switch is disabled
    [self setPrevIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
}

- (void)viewDidUnload
{
    [self setHighBrightnessSliderCell:nil];
    [self setLowBrightnessSliderCell:nil];
    [self setBrightnessSwitchCell:nil];
    [self setBrightnessSwitch:nil];
    [self setHighBrightness:nil];
    [self setLowBrightness:nil];
    [self setPrevIndexPath:nil];
    [self setDefaults:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self setDefaults:[NSUserDefaults standardUserDefaults]];
    [self userDefaultsDidChange];
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(userDefaultsDidChange)
												 name:NSUserDefaultsDidChangeNotification
											   object:[self defaults]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
    [super viewDidDisappear:animated];
}


- (void)userDefaultsDidChange {
    [highBrightness setValue:[[self defaults] floatForKey:QBHighBrightnessKey] animated:NO];
    [lowBrightness setValue:[[self defaults] floatForKey:QBLowBrightnessKey] animated:NO];
    if( [brightnessSwitch isOn] ){
        [[UIScreen mainScreen] setBrightness:[lowBrightness value]];
    } else {
        [[UIScreen mainScreen] setBrightness:[highBrightness value]];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1){
        return NSLocalizedString(@"QUICK_SWITCH_TITLE", @"The title for Quick Switch that is displayed as the Quick Switch options table header");
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 1){
        return NSLocalizedString(@"QUICK_SWITCH_DESC", @"The description for Quick Switch that is displayed as the Quick Switch options table footer");
    }
    return nil;
}

- (void)checkCell:(UITableViewCell *)cell {
	[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	[[cell textLabel] setTextColor:[UIColor colorWithRed:56.0/255.0 green:84.0/255.0 blue:135.0/255.0 alpha:1.0]];
}

- (void)unCheckCell:(UITableViewCell *)cell {
	[cell setAccessoryType:UITableViewCellAccessoryNone];
	[[cell textLabel] setTextColor:[UIColor darkTextColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                return highBrightnessSliderCell;
                break;
                
            case 1:
                return brightnessSwitchCell;
                break;
                
            case 2:
                return lowBrightnessSliderCell;
                break;
                
            default:
                return nil;
                break;
        }
    } else {
        static NSString *CellIdentifier = @"QuickSwitchModeCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        if ([indexPath isEqual:[self prevIndexPath]]){
            [self checkCell:cell];
        }
        
        switch (indexPath.row) {
            case 0:
                [cell.textLabel setText:NSLocalizedString(@"QUICK_SWITCH_MODE_DISABLED", @"The disabled Quick Switch mode cell text")];
                break;
                
            case 1:
                [cell.textLabel setText:NSLocalizedString(@"QUICK_SWITCH_MODE_SWITCH", @"The switch and exit Quick Switch mode cell text")];
                break;
                
            case 2:
                [cell.textLabel setText:NSLocalizedString(@"QUICK_SWITCH_MODE_SYSTEM", @"The system brightness Quick Switch mode cell text")];
                break;
                
            default:
                break;
        } 
        
        return cell;
    }
}
                                                          
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                return highBrightnessSliderCell.bounds.size.height;
                break;
                
            case 1:
                return brightnessSwitchCell.bounds.size.height;
                break;
                
            case 2:
                return lowBrightnessSliderCell.bounds.size.height;
                break;
                
            default:
                return 0;
                break;
        }
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                [self highBrightnessChanged];
                break;
                
            case 1:
                [brightnessSwitch setOn:![brightnessSwitch isOn] animated:YES];
                break;
                
            case 2:
                [self lowBrightnessChanged];
                break;
                
            default:
                break;
        }
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (![indexPath isEqual:[self prevIndexPath]]){
            [self unCheckCell:[tableView cellForRowAtIndexPath:[self prevIndexPath]]];
            [self checkCell:[tableView cellForRowAtIndexPath:indexPath]];
            
            [self setPrevIndexPath:indexPath];
            
            switch (indexPath.row) {
                case 0:
                    [[self defaults] setValue:QBQuickSwitchDisabled forKey:QBQuickSwitchKey];
                    break;
                    
                case 1:
                    [[self defaults] setValue:QBQuickSwitchSwitchAndExit forKey:QBQuickSwitchKey];
                    break;
                    
                case 2:
                    [[self defaults] setValue:QBQuickSwitchSwitchAndExit forKey:QBQuickSwitchKey];
                    break;
                    
                default:
                    break;
            }
            
            if (indexPath.row != 0) {
                QBSettingsWarningViewController *warning = [[QBSettingsWarningViewController new] autorelease];
                [self presentModalViewController:warning animated:YES];
            }
        }
    }
}

- (void)dealloc {
    [highBrightnessSliderCell release];
    [lowBrightnessSliderCell release];
    [brightnessSwitchCell release];
    [brightnessSwitch release];
    [highBrightness release];
    [lowBrightness release];
    [_prevIndexPath release];
    [_defaults release];
    [super dealloc];
}
- (IBAction)highBrightnessChanged {
    if([brightnessSwitch isOn]){
        [brightnessSwitch setOn:NO animated:YES ignoreControlEvents:YES];
    }
    if([highBrightness value] < [lowBrightness value]){
        [lowBrightness setValue:[highBrightness value] animated:NO];
    }
    
    [[UIScreen mainScreen] setBrightness:[highBrightness value]];
}

- (IBAction)lowBrightnessChanged {
    if(![brightnessSwitch isOn]){
        [brightnessSwitch setOn:YES animated:YES ignoreControlEvents:YES];
    }
    if([lowBrightness value] > [highBrightness value]){
        [highBrightness setValue:[lowBrightness value] animated:NO];
    }
    
    [[UIScreen mainScreen] setBrightness:[lowBrightness value]];
}

- (IBAction)brightnessChanged {
    if([brightnessSwitch isOn]){
        [[UIScreen mainScreen] setBrightness:[lowBrightness value]];
    } else {
        [[UIScreen mainScreen] setBrightness:[highBrightness value]];
    }
}

- (IBAction)saveBrightnessDefaults {
    [[self defaults] setValuesForKeysWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [NSNumber numberWithFloat:[lowBrightness value]], QBLowBrightnessKey,
                                                    [NSNumber numberWithFloat:[highBrightness value]], QBHighBrightnessKey, nil]];
}

@end