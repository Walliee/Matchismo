//
//  Deck.h
//  Matchismo
//
//  Created by Anshul Mehra on 12/27/13.
//  Copyright (c) 2013 Anshul Mehra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
