//
//  ViewController.h
//  Heart Rate Measurement
//
//  Created by MAC new on 2/21/13.
//  Copyright (c) 2013 MAC new. All rights reserved.
//  Header file


#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "HRMController.h"

@interface ViewController : UIViewController <CBCentralManagerDelegate> {
    CBCentralManager *cm;
}

@property (weak, nonatomic) IBOutlet UILabel *measurementLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

//by us
//@property CBUUID *heartRateServiceUUID;

//Newly added property
@property HRMController *hrmController;
//

- (IBAction)connectButtonPressed:(id)sender;



@end
