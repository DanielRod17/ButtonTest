//
//  EPLOrderCheck.m
//  ButtonTest
//
//  Created by itsupport on 10/12/17.
//  Copyright (c) 2017 EP Logistics, LLC. All rights reserved.
//

#import "EPLOrderCheck.h"
#import "EPLViewController.h"

@interface EPLOrderCheck ()

@end

@implementation EPLOrderCheck

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)thAttempt:(id)sender {
    NSString *token = _Tokenito.text;
    if(_Tokenito.text.length == 0) {
        token = [NSString stringWithFormat:@"ciertoFail"];
    }
    NSString *URLmao = [NSString stringWithFormat:@"https://eplserver.net/erp/tools/BoxPalletID/Token&.php?Token="];
    URLmao = [URLmao stringByAppendingString:token];
    NSURL *targetURL = [NSURL URLWithString:URLmao];
    NSURLRequest *requost = [NSURLRequest requestWithURL:targetURL];
    NSData *data = [NSURLConnection sendSynchronousRequest:requost returningResponse:nil error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    if([dataString isEqualToString:@"Exists"]){
    EPLViewController *second = [[EPLViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:second animated:YES completion:NULL];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Token" message:@"Check and Enter Again" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        [alert release];

    }
}
- (void)dealloc {
    [_Tokenito release];
    [super dealloc];
}
@end
