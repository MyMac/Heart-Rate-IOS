//
//  ViewController.m
//  Heart Rate Measurement
//
//  Created by MAC new on 2/21/13.
//  Copyright (c) 2013 MAC new. All rights reserved.
//  implementation file

#import "ViewController.h"

@interface ViewController ()
@property CBCentralManager *cm;
@end
 

@implementation ViewController

@synthesize heartRateServiceUUID = _heartRateUUID;
@synthesize measurementLabel;
@synthesize statusLabel;

- (void)viewDidLoad
{
    _heartRateUUID = [CBUUID UUIDWithString:@"180D"];
    [super viewDidLoad];
    cm = [[CBCentralManager alloc] initWithDelegate:self queue:nil];   //initializing the CB central manager
    

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
- (IBAction)connectButtonPressed:(id)sender {
    
    [self.cm scanForPeripheralsWithServices:@[self.heartRateServiceUUID] options: @{CBCentralManagerScanOptionAllowDuplicatesKey: NO}];//doubt      Starting a scan
    NSLog(@"started scanning...");
    
}

//Handling a discovery (when peripheral is discovered)

-(void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Discovered peripheral %@", [peripheral name]);  
}

//New addition by us regarding the state of the bluetooth

- (void) centralManagerDidUpdateState:(CBCentralManager *)central  //Handling the state update
{
    NSLog(@"Central manager did update state : %d", central.state);
    if(central.state == CBCentralManagerStatePoweredOn)
    {
        [self.statusLabel setText:@"Bluetooth is ON"];
    }
    else
{
    [self.statusLabel setText:@"Bluetooth is OFF"];
}
    }

@end
