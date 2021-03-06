    //
//  CardGameViewController.m
//  Matchismo
//
//  Created by Anshul Mehra on 12/27/13.
//  Copyright (c) 2013 Anshul Mehra. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutlet UIButton *redealButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *gameModeButton;
@property (weak, nonatomic) IBOutlet UILabel *gameMoveLabel;
@end

@implementation CardGameViewController

- (IBAction)touchGameModeButton:(UISegmentedControl *)sender
{
    [self setMode];
}

- (IBAction)touchRedealButton:(UIButton *)sender
{
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    [self updateUI];
    self.gameModeButton.enabled = YES;
    [self setMode];
    
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = (int) [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = (int) [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int) self.game.score];
    }
    self.gameModeButton.enabled = NO;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (void)setMode
{
    if (self.gameModeButton.selectedSegmentIndex == 0){
        [self.game setMode:NO];
    } else {
        [self.game setMode:YES];
    }
}

- (void)updateGameMoveLabel
{
    
}

@end
