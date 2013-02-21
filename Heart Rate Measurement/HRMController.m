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
@synthesize service = _service;
@synthesize charcteristic = _charcteristic;
@synthesize delegate = _delegate;

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
    [self.peripheral discoverServices:@[HRMController.serviceUUID]];//scanning for service
     NSLog(@"started scan for services...");
}
-(void) didDisconnect
{
    [self.peripheral setNotifyValue: NO forCharacteristic:self.charcteristic];
    
}

+(CBUUID*) serviceUUID{
    return [CBUUID UUIDWithString:@"i80D"];
}

+(CBUUID*) characteristicUUID{
    return [CBUUID UUIDWithString:@"2A37"];
}

//discover service and characteristic needed

-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    for (CBService *s in peripheral.services){
        if([s.UUID isEqual:HRMController.serviceUUID]){
            NSLog(@"found heart rate service");
            self.service = s;
            [self.peripheral discoverCharacteristics:@[HRMController.characteristicUUID] forService:self.service];
        }
    }
}

//after the required characyeristic discovered
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for( CBCharacteristic *c in service.characteristics){
        if([c.UUID isEqual:HRMController.characteristicUUID]){
            NSLog(@"found heart rate measurement characteristic.");
            self.charcteristic = c;
        }
    }
    [self.peripheral setNotifyValue:YES forCharacteristic:self.charcteristic];//enabling the notifications
}

//after receving notifications we must check for any uodates in characeristic value(here heart rate measurement)

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    NSUInteger *flags = (NSUInteger *) [[[characteristic value] subdataWithRange:NSMakeRange(0,1)]bytes];
    
    NSUInteger length;
    if(*flags & 0x01)
    {
        length = 2;
    }
    else
    {
        length = 1;
    }
    NSUInteger *measurement = (NSUInteger *) [[[characteristic value]subdataWithRange:NSMakeRange(1, length)]bytes];
    
    [self .delegate didUpdateMeasurement:@(*measurement)];
}


@end
