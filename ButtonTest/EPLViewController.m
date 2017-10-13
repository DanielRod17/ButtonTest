//
//  EPLViewController.m
//  ButtonTest
//
//  Created by EP Logistics, LLC. on 10/5/17.
//  Copyright (c) 2017 EP Logistics, LLC. All rights reserved.
//

#import "EPLViewController.h"

@interface EPLViewController ()

@end

@implementation EPLViewController

BOOL flag = 0;
NSString *Barcodote;

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    linea =[Linea sharedDevice];
    [linea addDelegate:self];
    [linea connect];
    [super viewDidLoad];
    [self.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    /////
    
    ////
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_PalletIDLabel release];
    [_PalletInput release];
    [_LocationLabel release];
    [_LocationInput release];
    [_StatusLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setPalletIDLabel:nil];
    [self setLocationLabel:nil];
    [self setPalletInput:nil];
    [self setLocationInput:nil];
    [super viewDidUnload];
}
//////////////////////////////////////////////////////
-(void)barcodeData:(NSString *)barcode type:(int)type {
    
    // You can use this data as you wish
    // Here I write barcode data into the console
    Barcodote = barcode;
    /////
    if(flag == 0){
        _PalletInput.text=Barcodote;
        flag = 1;
    }else{
        _LocationInput.text=Barcodote;
    }
    /////
}         
//////////////////////////////////////////////////////
/*- (IBAction)ScanButton:(id)sender {
    if(flag == 0){
        _PalletInput.text=Barcodote;
        flag = 1;
    }else{
        _LocationInput.text=Barcodote;
    }
}*/
/////////////////////////////////////////////////////
- (IBAction)ClearButton:(id)sender {
    flag = 0;
    _PalletInput.text=[NSString stringWithFormat:@""];
    _LocationInput.text=[NSString stringWithFormat:@""];
}

- (IBAction)SetButton:(id)sender {
    NSString *screenPallet = _PalletInput.text;
    NSString *screenLocation = _LocationInput.text;
    if(_PalletInput.text.length > 0 && _LocationInput.text.length > 0){
        //////
        NSURL *targetURL = [NSURL URLWithString:@"https://eplserver.net/erp/tools/BoxPalletID/fasfsa.php"];
        NSURLRequest *requost = [NSURLRequest requestWithURL:targetURL];
        NSData *data = [NSURLConnection sendSynchronousRequest:requost returningResponse:nil error:nil];
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        //_StatusLabel.text=dataString;
        if([dataString isEqualToString:@"Active"]){
        //////
            /*NSString *post = [NSString stringWithFormat:@"Pallet="];
            post = [post stringByAppendingString:screenPallet];
            post = [post stringByAppendingString:@"&Location="];
            post = [post stringByAppendingString:screenLocation];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL
            URLWithString:@"https://eplserver.net/erp/tools/BoxPalletID/Token&.php"]
            cachePolicy:NSURLRequestUseProtocolCachePolicy
            timeoutInterval:10.0];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
            NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];*/
            NSString *URLmao = [NSString stringWithFormat:@"https://eplserver.net/erp/tools/BoxPalletID/Token&.php?Pallet="];
            URLmao = [URLmao stringByAppendingString:screenPallet];
            URLmao = [URLmao stringByAppendingString:@"&Location="];
            URLmao = [URLmao stringByAppendingString:screenLocation];
            NSURL *targetURL = [NSURL URLWithString:URLmao];
            NSURLRequest *requost = [NSURLRequest requestWithURL:targetURL];
            NSData *data = [NSURLConnection sendSynchronousRequest:requost returningResponse:nil error:nil];
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            if([dataString isEqualToString:@"Success"]){
            ////////////////////////////////////
            flag = 0;
            _PalletInput.text=[NSString stringWithFormat:@""];
            _LocationInput.text=[NSString stringWithFormat:@""];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Updated!" message:@"Location Assigned" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
            [alert release];
            }else{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Pallet ID" message:@"Please Check your Inputs" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
                [alert release];

            }
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Connection Lost" message:@"Please Check your Internet Settings" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
            [alert release];
        }
    }
}
@end
