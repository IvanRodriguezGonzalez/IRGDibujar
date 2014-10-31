//
//  IRGAlmacenDeCeldas.h
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 27/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IRGCeldaViewController;

@interface IRGAlmacenDeCeldas : NSObject

+ (instancetype) sharedAlmacenDeCeldas;

- (void) añadirCelda: (IRGCeldaViewController *)celda;

- (NSArray *) allItems;

@end
