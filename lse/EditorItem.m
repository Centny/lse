//
//  EditorItem.m
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import "EditorItem.h"

@implementation EditorItem

-(void)set:(NSString*)lable text:(NSString*)text url:(NSString*)url{
    self.label.text=lable;
    self.text.text=text;
    self.preview.url=url;
}

-(void)fitSize:(CGFloat)width{
    self.text.frame=CGRectMake(FRAM_X(self.text), FRAM_Y(self.text), width-FRAM_X(self.text), FRAM_H(self.text));
    self.label.frame=CGRectMake(FRAM_X(self.label), FRAM_Y(self.label), FRAM_W(self.label), FRAM_H(self.text));
    self.preview.frame=CGRectMake(FRAM_X(self.preview), FRAM_Y(self.text)+FRAM_H(self.text)+10, FRAM_W(self.preview), FRAM_H(self.preview));
//    if(self.preview.url==nil){
        self.frame=CGRectMake(0, 0, width, 100);
//    }else{
//        self.frame=CGRectMake(0, 0, width, FRAM_Y(self.preview)+FRAM_H(self.preview));
//    }
}

@end
