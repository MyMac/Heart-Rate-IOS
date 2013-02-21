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
@protocol HRMControllerDelegate <NSObject>
-(void) didUpdateMeasurement: (NSNumber *) measurement;
@end

@interface HRMController : NSObject <CBPeripheralDelegate>

//property for HRMdelegate
@property id<HRMControllerDelegate> delegate;

@property CBPeripheral *peripheral;

//service and characteristic reference
@property CBService *service;
@property CBCharacteristic *charcteristic;
//

//defining the delegate


-(id) initWithPeripheral: (CBPeripheral *)peripheral; //our own defined methods including initWithPheiphera
-(void) didConnect;
-(void)didDisconnect;

//storing the UUID's in better place
//static class properties hence + sign (class method)
+(CBUUID *) serviceUUID;
+(CBUUID *) characteristicUUID;
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;

@end
