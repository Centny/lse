//
//  LoginVC.m
//  lse
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Centny. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onLogin:(id)sender{
    if(self.usr.text.length<1||self.pwd.text.length<1){
        return;
    }
    [H doGetj:^(URLRequester *req, NSData *data, NSDictionary *json, NSError *err) {
        if(err||[[json checkValueForKey:@"code"]intValue]!=0){
            UIAlertView* view=[[UIAlertView alloc]initWithTitle:@"登录失败" message:@"登录失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [view show];
            return;
        }
        NSDictionary* sdata=[json valueForKey:@"data"];
        NSUserDefaults* def=[NSUserDefaults standardUserDefaults];
        [def setObject:[sdata objectForKey:@"token"] forKey:@"token"];
        [def synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    } url:@"http://sso.kuxiao.cn/sso/api/login?usr=%@&pwd=%@&source=PC",self.usr.text,self.pwd.text];
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
