//
//  ViewController.m
//  Lab03
//
//  Created by Alejandra B on 28/01/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import "Menu.h"
#import "VarGlobal.h"

@interface Menu ()

@end

@implementation Menu

- (void)viewDidLoad {
    [super viewDidLoad];
    intFlag = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAdd:(id)sender {
    intFlag = 1;
    
}
- (IBAction)btnDelete:(id)sender {
     intFlag = 2;
    NSLog(@"%lu", (unsigned long)intFlag);
}
@end
