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

//@synthesize heartRateServiceUUID = _heartRateUUID;
@synthesize measurementLabel;
@synthesize statusLabel;
@synthesize hrmController = _hrmController;
//@synthesize service = _service;
//@synthesize charcteristic = _charcteristic;

- (void)viewDidLoad
{
   // _heartRateUUID = [CBUUID UUIDWithString:@"180D"];
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
    //newly added method
    
    if (self.hrmController) {
        [self.cm cancelPeripheralConnection:self.hrmController.peripheral];
        NSLog(@"Disconnecting Peripheral...");
    }
    
    else{
    
       [self.cm scanForPeripheralsWithServices:@[/*self.heartRateServiceUUID*/HRMController.serviceUUID] options: @{CBCentralManagerScanOptionAllowDuplicatesKey: @ NO}];//doubt      Starting a scan
       NSLog(@"started scanning...");
    }
}

//Handling a discovery (when peripheral is discovered)

-(void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    //NSLog(@"Discovered peripheral %@", [peripheral name]);
    // After getting discovered by peripheral we need to first stopscan, create HRMController and then connect to perpheral/
    [self.cm stopScan];
    self.hrmController = [[HRMController alloc] initWithPeripheral:peripheral];
    [self.cm connectPeripheral:self.hrmController.peripheral options:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey: @YES}];
    NSLog(@"connecting to %@...", self.hrmController.peripheral);
    self.hrmController.delegate = self;//this is declared after defining HRMController Delegate
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

//Handling the connect
-(void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"did connect to %@",[peripheral name]);
    [self.hrmController didConnect];
    [self.connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];//added after dragging connect butten again to change it as outlet
}

-(void) didUpdateMeasurement: (NSNumber *) measurement{
    NSLog(@"updated mesurement in view controller: %@", measurement);
    self.measurementLabel.text = measurement.stringValue;
}

//ading diddisconnectPeripheral

-(void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"Did disconnect peripheral %@",[peripheral name]);
    [self. connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    measurementLabel.text = @"-";
    
    if (self.hrmController.peripheral != peripheral) {
        return;
    }
    [_hrmController didDisconnect];
    _hrmController = nil;
    
}

@end
