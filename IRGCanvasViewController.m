//
//  IRGCanvasViewController.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGCanvasViewController.h"
#import "IRGCeldaViewController.h"
#import "IRGAlmacenDeCeldas.h"
#import "IRGPincelRelleno.h"



@interface IRGCanvasViewController ()

- (IBAction)accionRellenar:(UIButton *)sender;

- (IBAction)accionPintar:(UIButton *)sender;

@end

@implementation IRGCanvasViewController


-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Dibujar";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int posicionX =0;
    int posicionY = 100;
    int ancho =20;
    int alto =20;
    
    for (int coordenadax = posicionX;coordenadax<self.view.frame.size.width;coordenadax += ancho){
        
        for (int coordenadaY = posicionY;coordenadaY<self.view.frame.size.height;coordenadaY+= alto){
            
        IRGCeldaViewController *celda = [[IRGCeldaViewController alloc] initWithPosicionX:coordenadax
                                                                                posicionY:coordenadaY
                                                                                    ancho:ancho
                                                                                    alto:alto];
        IRGCelda *celdaTmp = celda.view;
        IRGAlmacenDeCeldas * almacenDeCeldasTmp = [IRGAlmacenDeCeldas sharedAlmacenDeCeldas];
        [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] añadirCelda:celdaTmp];
        [self.view addSubview:celda.view];
        }}
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

- (IBAction)accionRellenar:(id)sender {
    [IRGPincelRelleno sharedPincelRelleno].modoPintar = FALSE;
}

- (IBAction)accionPintar:(UIButton *)sender {
    [IRGPincelRelleno sharedPincelRelleno].modoPintar = true;
}
@end
