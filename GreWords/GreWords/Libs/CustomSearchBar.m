#import "CustomSearchBar.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomSearchBar

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        customBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customBackButton.frame = CGRectMake(283, 11, 20, 21);
        
        [customBackButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [customBackButton setBackgroundImage:[UIImage imageNamed:@"findIcon.png"] forState:UIControlStateNormal];
        
        [self addSubview:customBackButton];
        //Set other button states (hightlight, select, etc) here
    }    
    return self;
} 

-(void)drawRect:(CGRect)rect {
    [[[self subviews] objectAtIndex:0] setAlpha:0.0];
    UIImage *image = [UIImage imageNamed: @"UISearchBarBG.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self setShowsCancelButton:NO animated:NO];
    
    UITextField *textfield = [self textView];
    [textfield setBorderStyle:UITextBorderStyleNone];
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        
    textfield.leftView = leftview;
    textfield.clearButtonMode = UITextFieldViewModeNever;
    textfield.backgroundColor = [UIColor clearColor];
    [textfield setBackground:[UIImage imageNamed: @"UISearchBarText.png"]];  
    
    //textfield.layer.borderColor = [[UIColor clearColor] CGColor];
    textfield.textColor = [UIColor colorWithRed:224/255.0 green:210/255.0 blue:193/255.0 alpha:1.0];
    
    
}

-(UIButton*)searchButton
{
    for(id cc in [self subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            if(cc == customBackButton)
                continue;
            UIButton *btn = (UIButton *)cc;
            return btn;
        }
    }
    return nil;
}

-(UITextField*)textView
{
    for(id cc in [self subviews])
    {
        
        if([cc isKindOfClass:[UITextField class]])
        {
            
            UITextField *btn = (UITextField *)cc;
            return btn;
        }
    }
    return nil;
}

-(void)cancelAction {
    UIButton *btn = [self searchButton];
    [btn sendActionsForControlEvents: UIControlEventTouchUpInside];
    [[self textView] resignFirstResponder];
}

@end