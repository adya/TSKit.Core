// - Since: 11/25/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

#import <Foundation/Foundation.h>
#import "ExceptionThrower.h"

@implementation ExceptionThrower

- (BOOL)tryPerforming:(void(^)(void))block error:(__autoreleasing NSError **)error {
    @try {
        block();
        return YES;
    }
    @catch (NSException* exception) {
        NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] initWithDictionary: exception.userInfo];
        [userInfo setValue: exception.callStackSymbols forKey: @"callStackSymbols"];
        [userInfo setValue: exception.reason forKey: @"reason"];
        [userInfo setValue: exception forKey: @"exception"];
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo: userInfo];
        return NO;
    }
}

@end
