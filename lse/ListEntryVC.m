//
//  ListEntryVC.m
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import "ListEntryVC.h"

@interface ListEntryVC ()

@end

@implementation ListEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self toEntryEidtor:@"https://mp.weixin.qq.com/s/Gc6jp74AVqFYYWSlanibGw"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkPasteboard];
}

-(void)toEntryEidtor:(NSString*)url{
    self.last=url;
    self.lastview.text=url;
    [self performSegueWithIdentifier:@"EntryEditorVC" sender:[NSDictionary dictionaryWithObjectsAndKeys:url,@"url", nil]];
}

-(void)checkPasteboard{
    NSString* text=[UIPasteboard generalPasteboard].string;
    if([text hasPrefix:@"http://"]||[text hasPrefix:@"https://"]){
        if(![text isEqualToString:self.last]){
            [self toEntryEidtor:text];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destination = segue.destinationViewController;
    NSDictionary* args=sender;
    [destination setValuesForKeysWithDictionary:args];
}

-(IBAction)onEdit:(id)sender{
    if(self.lastview.text.length){
        [self toEntryEidtor:self.lastview.text];
    }
}

-(IBAction)onWeb:(id)sender{
    NSString* url=@"http://links.dev.gdy.io/";
    [self performSegueWithIdentifier:@"WebVC" sender:[NSDictionary dictionaryWithObjectsAndKeys:url,@"url", nil]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
