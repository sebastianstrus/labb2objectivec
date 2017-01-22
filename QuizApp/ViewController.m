//
//  ViewController.m
//  QuizApp
//
//  Created by Sebastian Strus on 20/01/17.
//  Copyright © 2017 Sebastian Strus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nrQuestionLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UILabel *answerInfo;
@property (weak, nonatomic) IBOutlet UILabel *resultInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnNextQuestion;
@property (weak, nonatomic) IBOutlet UIButton *btnPlayAgain;

@end







@implementation ViewController

NSMutableArray *questions;
NSArray *q0, *q1, *q2, *q3, *q4, *q5, *q6, *q7, *q8, *q9;
int nrCurrentQuestion;
BOOL notAnswered;
int points;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
}


// improves the appearance of the application
- (void)setNiceView {
    self.btn1.layer.borderWidth = 1.0f;
    self.btn2.layer.borderWidth = 1.0f;
    self.btn3.layer.borderWidth = 1.0f;
    self.btn4.layer.borderWidth = 1.0f;
    self.btnNextQuestion.layer.borderWidth = 1.0f;
    self.btnPlayAgain.layer.borderWidth = 1.0f;
}


// set question, right answer and wrong answers
- (void)setData {
    q0 = [[NSArray alloc] initWithObjects: @"Sverige", @"Stockholm", @"Goteborg", @"Malmo", @"Uppsala", nil];//nil
    q1 = [[NSArray alloc] initWithObjects: @"Polen", @"Krakow", @"Warszawa", @"Wroclaw", @"Gdansk", nil];
    q2 = [[NSArray alloc] initWithObjects: @"Tyskland", @"Munchen", @"Hamburg", @"Berlin", @"Köln", nil];
    q3 = [[NSArray alloc] initWithObjects: @"Spanien", @"Bilbao", @"Barcelona", @"Valencia", @"Madrid", nil];
    q4 = [[NSArray alloc] initWithObjects: @"Norge", @"Oslo", @"Stavanger", @"Bergen", @"Trondheim", nil];
    q5 = [[NSArray alloc] initWithObjects: @"Frankrike", @"Lyon", @"Paris", @"Marseille", @"Nice", nil];
    q6 = [[NSArray alloc] initWithObjects: @"Italien", @"Neapel", @"Milano", @"Rom", @"Turin", nil];
    q7 = [[NSArray alloc] initWithObjects: @"Portugal", @"Funchal", @"Porto", @"Braga", @"Lissabon", nil];
    q8 = [[NSArray alloc] initWithObjects: @"Grekland", @"Aten", @"Thessaloniki", @"Patra", @"Larissa", nil];
    q9 = [[NSArray alloc] initWithObjects: @"Danmark", @"Arhus", @"Kopenhamn", @"Odense", @"Aalborg", nil];
    questions = [[NSMutableArray alloc] initWithObjects: q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, nil];//nil
    nrCurrentQuestion = 1;
    self.btnPlayAgain.hidden=YES;
    self.resultInfo.hidden=YES;
    self.nrQuestionLabel.text = [NSString stringWithFormat: @"Fråga: %d/5", nrCurrentQuestion];
    points = 0;
    self.answerInfo.text = @"";
    [self giveQuestion];
    [self setNiceView];
    notAnswered = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Four guess buttons connected to this function.
- (IBAction)guessPressed:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    
    
    // check if two words fit together (country - capital)
    BOOL ok0 = [[[btn titleLabel] text] isEqualToString:@"Stockholm"] && [[_questionLabel text] isEqualToString:@"Sverige"];
    BOOL ok1 = ([[[btn titleLabel] text] isEqualToString:@"Warszawa"] && [[_questionLabel text] isEqualToString:@"Polen"]);
    BOOL ok2 = ([[[btn titleLabel] text] isEqualToString:@"Berlin"] && [[_questionLabel text] isEqualToString:@"Tyskland"]);
    BOOL ok3 = ([[[btn titleLabel] text] isEqualToString:@"Madrid"] && [[_questionLabel text] isEqualToString:@"Spanien"]);
    BOOL ok4 = ([[[btn titleLabel] text] isEqualToString:@"Oslo"] && [[_questionLabel text] isEqualToString:@"Norge"]);
    BOOL ok5 = ([[[btn titleLabel] text] isEqualToString:@"Paris"] && [[_questionLabel text] isEqualToString:@"Frankrike"]);
    BOOL ok6 = ([[[btn titleLabel] text] isEqualToString:@"Rom"] && [[_questionLabel text] isEqualToString:@"Italien"]);
    BOOL ok7 = ([[[btn titleLabel] text] isEqualToString:@"Lissabon"] && [[_questionLabel text] isEqualToString:@"Portugal"]);
    BOOL ok8 = ([[[btn titleLabel] text] isEqualToString:@"Aten"] && [[_questionLabel text] isEqualToString:@"Grekland"]);
    BOOL ok9 = ([[[btn titleLabel] text] isEqualToString:@"Kopenhamn"] && [[_questionLabel text] isEqualToString:@"Danmark"]);
    
    // check if if answer is correct
    if (ok0 || ok1 || ok2 || ok3 || ok4 || ok5 || ok6 || ok7 || ok8 || ok9)
    {
        self.answerInfo.textColor = [UIColor colorWithRed:0 green:256 blue:0 alpha:1.0];
        if (notAnswered) {
            points++;
            notAnswered = NO;
            self.answerInfo.text = @"Rätt! (+1)";
        } else {
            self.answerInfo.text = @"Rätt!";
        }
        self.resultInfo.text = [NSString stringWithFormat: @"Resultat: %d/5 poäng.", points];
    } else {
        self.answerInfo.text = @"Fel!";
        self.answerInfo.textColor = [UIColor colorWithRed:204 green:0 blue:0 alpha:1.0];
        notAnswered = NO;
    }
}

// button next question
- (IBAction)nextQuestion:(UIButton *)sender {
    notAnswered = YES;
    self.answerInfo.text = @"";
    if(nrCurrentQuestion < 5) {
        nrCurrentQuestion++;
        [self giveQuestion];
        self.nrQuestionLabel.text = [NSString stringWithFormat: @"Fråga: %d/5", nrCurrentQuestion];
        
    } else {
        self.btnPlayAgain.hidden=NO;
        self.resultInfo.hidden=NO;
        self.resultInfo.text = [NSString stringWithFormat: @"Resultat: %d/5 poäng.", points];
    }
}

- (void)giveQuestion {
    NSUInteger k = [questions count];
    NSUInteger qInArray = (arc4random() % k);
    
    
    //TODO: shuffle answers.
    
    // set question:
    self.questionLabel.text = [[questions objectAtIndex: qInArray]objectAtIndex: 0];
    [self.btn1 setTitle:[[questions objectAtIndex: qInArray]objectAtIndex: 1] forState:UIControlStateNormal];
    [self.btn2 setTitle:[[questions objectAtIndex: qInArray]objectAtIndex: 2] forState:UIControlStateNormal];
    [self.btn3 setTitle:[[questions objectAtIndex: qInArray]objectAtIndex: 3] forState:UIControlStateNormal];
    [self.btn4 setTitle:[[questions objectAtIndex: qInArray]objectAtIndex: 4] forState:UIControlStateNormal];
    // remove used question:
    [questions removeObjectAtIndex:qInArray];
}

// play again button pressed, set data again
- (IBAction)playAgain:(UIButton *)sender {
    [self setData];
}


@end






