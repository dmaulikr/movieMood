//
//  SKYViewController.m
//  MovieMood
//
//  Created by Aaron Sky on 1/30/14.
//  Copyright (c) 2014 Sky Apps. All rights reserved.
//

#import "SKYViewController.h"
#import "SKYResultViewController.h"
#import "JLTMDbClient.h"
#import "SKYColorAnalyser.h"
#import "TLAlertView.h"
#import "SKYInfoViewController.h"

@interface SKYViewController ()
@property (nonatomic, retain) SKYColorAnalyser *colorAnalyser;
@property (nonatomic, retain) SKYColorPickerScrollView *contentScrollView;
@property (nonatomic, retain) NSDictionary *currentPorps;
@end

@implementation SKYViewController {
    UIDynamicAnimator* _animator;
    NSDictionary* results;
}

@synthesize colorAnalyser = _colorAnalyser;
@synthesize contentScrollView = _contentScrollView;
@synthesize currentPorps = _currentPorps;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize size = self.view.bounds.size;
    CGSize infoButtonSize = CGSizeMake(30.f, 30.f);
    
    _contentScrollView = [[SKYColorPickerScrollView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x,
                                                                        self.view.bounds.origin.y,
                                                                        size.width,
                                                                        size.height)];
    
    _contentScrollView.colorViewDelegate = self;
    _contentScrollView.delegate = self;
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [infoButton setFrame:CGRectMake(20,
                                    (_contentScrollView.bounds.size.height * .8) - infoButtonSize.height,
                                    infoButtonSize.width, infoButtonSize.height)];
    [infoButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    [_contentScrollView addSubview:infoButton];
    [self.view addSubview:_contentScrollView];
    _colorAnalyser = [[SKYColorAnalyser alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)colorDidChange:(id) sender {
    _contentScrollView.alwaysBounceVertical = false;
    _contentScrollView.colorIndicator.backgroundColor = _contentScrollView.colorWheel.currentColor;
    UIColor *complement = [_colorAnalyser calculateComplementaryWithColor: _contentScrollView.colorWheel.currentColor];
    [_contentScrollView changeSelectButtonColorWithColor: complement];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowResults"]) {
        SKYResultViewController* resultVC = [segue destinationViewController];
        resultVC.movieProps = _currentPorps;
        resultVC.selectedColor = _contentScrollView.colorWheel.currentColor;
    }
    
    else if([[segue identifier] isEqualToString:@"InfoSegue"]){
        SKYInfoViewController *nextVC = [segue destinationViewController];
        
        NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
        [viewControllers addObject:[[UIViewController alloc] initWithNibName:@"AboutView" bundle:nil]];
        [nextVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
    }
}

-(void)selectButtonPressed:(id)sender {
    _currentPorps = [_colorAnalyser analyzeColor: _contentScrollView.colorWheel.currentColor];
    [self performSegueWithIdentifier:@"ShowResults" sender:self];
}

-(void)infoButtonPressed:(id) sender {
    [self performSegueWithIdentifier:@"InfoSegue" sender:self];
}
@end
