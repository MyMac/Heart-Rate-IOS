//
//  HRMController.m
//  Heart Rate Measurement
//
//  Created by MAC new on 2/21/13.
//  Copyright (c) 2013 MAC new. All rights reserved.
//

#import "HRMController.h"

@implementation HRMController

@synthesize peripheral = _peripheral;

//initialization method to store the CBperipheral reference and set its delegate to the HRMcntroller object

-(id)initWithPeripheral:(CBPeripheral *)peripheral
{
    if ([super init])
    {
        _peripheral = peripheral;
        _peripheral.delegate = self;
    }
    return self;
    
    }
-(void) didConnect
{
    
}
-(void) didDisconnect
{
    
}

@end
