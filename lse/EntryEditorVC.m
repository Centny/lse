//
//  EntryEditorVC.m
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import "EntryEditorVC.h"
@implementation Entry


@end;

@interface EntryEditorVC ()<WKUIDelegate,WKNavigationDelegate>
@end


@implementation EntryEditorVC

-(IBAction)onBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)onRefresh:(id)sender{
    [self.webview reload];
}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(self.webview){
//        return 6;
//    }else{
//        return 0;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    switch (indexPath.row) {
//        case 3:
//            return 290;
//        default:
//            return 100;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewXibCell* cell=[tableView newOrReuseCellWithXib:@"EditorItem"];
//    EditorItem* view=cell.xview;
//    switch(indexPath.row){
//        case 0:{
//            [view set:@"标题:" text:self.editing.title url:nil];
//            break;
//        }
//        case 1:{
//            [view set:@"标签:" text:self.editing.tags url:nil];
//            break;
//        }
//        case 2:{
//            [view set:@"来源:" text:self.editing.from url:nil];
//            break;
//        }
//        case 3:{
//            [view set:@"图片:" text:self.editing.img url:self.editing.img];
//            break;
//        }
//        case 4:{
//            [view set:@"描述:" text:self.editing.desc url:nil];
//            break;
//        }
//    }
//    [view fitSize:FRAM_W(self.view)];
//    FRAME_LOG(view);
//    FRAME_LOG(view.text);
//    return cell;
//}

-(void) loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.editing=[Entry new];
//    self.view.backgroundColor=[UIColor redColor];
    NSLog(@"xx->%@",self.url);
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

-(void)viewDidAppear:(BOOL)animated{
    if(self.webview==nil){
        self.form=[UIView viewWithXib:@"EditorForm"];
        self.form.frame=CGRectMake(0, 0, FRAM_W(self.main), FRAM_H(self.main));
        self.form.hidden=YES;
        [self.main addSubview:self.form];
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        self.form.token=[def objectForKey:@"token"];
        self.form.base=self.url;
        //
        self.webview=[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, FRAM_W(self.wvbase), FRAM_H(self.wvbase)) configuration:[WKWebViewConfiguration new]];
        self.webview.navigationDelegate=self;
        [self.wvbase addSubview:self.webview];
    }
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [self.webview evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable res, NSError * _Nullable error) {
        if(error){
            NSELog(@"-->%@", error);
            return;
        }
        self.form.title.text=res;
    }];

}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSDLog(@"->%@", error);
}

-(IBAction)onProcImg:(id)sender{
    NSString* script=@"var url=''; for (var i in document.images) { var img = document.images[i];if(!img.getBoundingClientRect)continue; var bound = img.getBoundingClientRect(); if (bound && bound.top && bound.top > -100 && bound.top < 150) { url=img.src;break; } } url;";
//    script=@"var rs = []; for (var i in document.images) { var img = document.images[i]; if (img.getBoundingClientRect) { var bound = img.getBoundingClientRect(); rs.push({ src: img.src, top: bound.top }); } else { rs.push({ src: img.src }); } } rs;";
    [self.webview evaluateJavaScript:script completionHandler:^(id _Nullable res, NSError * _Nullable error) {
        if(error){
            NSELog(@"-->%@", error);
            return;
        }
        if([res length]){
            self.form.preview.url=res;
            self.form.image.text=res;
            self.form.hidden=NO;
        }
    }];
}

-(IBAction)onProcDesc:(id)sender{
    [self.webview evaluateJavaScript:@"window.getSelection().toString();" completionHandler:^(id _Nullable res, NSError * _Nullable error) {
        if(error){
            NSELog(@"-->%@", error);
            return;
        }
        self.form.desc.text=res;
        self.form.hidden=NO;
    }];
}

-(IBAction)onEdit:(id)sender{
    if(self.form.hidden){
        [self.edit setTitle:@"View" forState:UIControlStateNormal];
        self.form.hidden=NO;
    }else{
        [self.edit setTitle:@"Edit" forState:UIControlStateNormal];
        self.form.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
