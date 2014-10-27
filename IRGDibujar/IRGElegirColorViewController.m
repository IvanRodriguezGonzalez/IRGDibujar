//
//  IRGElegirColorViewController.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGElegirColorViewController.h"
#import "IRGPincelRelleno.h"
#import "IRGPincelNormal.h"

@interface IRGElegirColorViewController ()
- (IBAction)azulPulsado:(UIButton *)sender;
- (IBAction)verdePulsado:(UIButton *)sender;

@end

@implementation IRGElegirColorViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Color";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)azulPulsado:(UIButton *)sender {
    [IRGPincelRelleno sharedPincelRelleno].colorDelRelleno = [UIColor blueColor];
}

- (IBAction)verdePulsado:(UIButton *)sender {
    [IRGPincelRelleno sharedPincelRelleno].colorDelRelleno = [UIColor greenColor];
}
@end
