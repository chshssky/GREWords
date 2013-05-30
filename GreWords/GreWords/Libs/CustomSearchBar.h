#import <UIKit/UIKit.h>

@protocol CustomSearchBarDelegate

-(void)customCancelButtonHit;

@end

@interface CustomSearchBar : UISearchBar {
    id<CustomSearchBarDelegate> delegate;
    UIButton *customBackButton;

    UIButton *originalBtn;
}
@property (nonatomic, assign) id<CustomSearchBarDelegate> delegate;

-(void)cancelAction;
@end
