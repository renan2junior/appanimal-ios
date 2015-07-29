//
//  ViewController.m
//  AppAnimal
//
//  Created by renanjunior on 27/07/15.
//  Copyright (c) 2015 renanjunior. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"Carregando ...";
    
    
    
    
    [self performSelector:@selector(testProgress) withObject:nil afterDelay:4.0];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)testProgress{
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddBt:(id)sender {
    
    NSLog(@"Apertei Aqui");
    
}
@end
