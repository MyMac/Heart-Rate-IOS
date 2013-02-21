//
//  ViewController.h
//  Heart Rate Measurement
//
//  Created by MAC new on 2/21/13.
//  Copyright (c) 2013 MAC new. All rights reserved.
//  Header file


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)connectButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *measurementLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
