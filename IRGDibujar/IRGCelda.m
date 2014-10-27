//
//  IRGCelda.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGCelda.h"

@interface IRGCelda ()

@end

@implementation IRGCelda

- (instancetype) initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame
                    colorDelBorde:[UIColor redColor]];
}


- (instancetype) initWithFrame:(CGRect)frame
                 colorDelBorde:(UIColor *)colorDelBorde{

    self = [super initWithFrame:frame];
    if (self){
        self.colorDelBorde = colorDelBorde;
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.delegado celdaPulsada:self];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds ];
    [self.colorDelBorde setStroke];
    path.lineWidth = 1;
    [path stroke];
}

-(void) setColorDelBorde:(UIColor *)colorDelBorde{
    _colorDelBorde = colorDelBorde;
    NSLog(@"%@",_colorDelBorde);
}

@end
