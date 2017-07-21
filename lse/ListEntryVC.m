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
    self.lastview.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.2].CGColor;
    self.lastview.layer.borderWidth =1.0;
    
    //[self toEntryEidtor:@"https://mp.weixin.qq.com/s/Gc6jp74AVqFYYWSlanibGw"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkPasteboard) name:UIApplicationDidBecomeActiveNotification object:nil];
    if(self.token==nil){
        [self checkToken];
    }else{
        [self checkPasteboard];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

-(void)toLogin{
    [self performSegueWithIdentifier:@"LoginVC" sender:[NSDictionary new]];
}

-(void)onReady{
    [self checkPasteboard];
}

-(void)checkToken{
    self.process.hidden=NO;
    NSUserDefaults* def=[NSUserDefaults standardUserDefaults];
    [def synchronize];
    NSString* stoken=[def objectForKey:@"token"];
    if(stoken==nil||stoken.length<1){
        [self toLogin];
        return;
    }
    [H doGetj:^(URLRequester *req, NSData *data, NSDictionary *json, NSError *err) {
        if(err){
            [self performSelector:@selector(checkToken) withObject:nil afterDelay:3];
            return;
        }
        if([[json checkValueForKey:@"code"]intValue]!=0){
            [self toLogin];
            return;
        }
        NSDictionary* sdata=[json objectForKey:@"data"];
        self.token=[sdata objectForKey:@"token"];
        self.process.hidden=YES;
        [self onReady];
    } url:@"http://sso.kuxiao.cn/sso/api/uinfo?token=%@",stoken];
}

@end
