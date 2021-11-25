// - Since: 11/25/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 An object that runs passed block in Objectve-C environment and propagates raised NSException as NSError.
 */
@interface ExceptionThrower : NSObject

/**
 Executes given block and sets the error if an NSException has been raised during execution.
 */
- (BOOL)tryPerforming:(void(^)(void))block error:(__autoreleasing NSError **)error
NS_SWIFT_NAME(catchException(in:));

@end

NS_ASSUME_NONNULL_END
