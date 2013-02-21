//
//  HRMController.h
//  Heart Rate Measurement
//
//  Created by MAC new on 2/21/13.
//  Copyright (c) 2013 MAC new. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
// #import <UIKit/UIKit.h>

@interface HRMController : NSObject <CBPeripheralDelegate>

@property CBPeripheral *peripheral;

-(id) initWithPeripheral: (CBPeripheral *)peripheral; //our own defined methods including initWithPheiphera
-(void) didConnect;
-(void)didDisconnect;

//storing the UUID's in better place
//static class properties hence + sign (class method)
+(CBUUID *) serviceUUID;
+(CBUUID *) characteristicUUID;

@end
