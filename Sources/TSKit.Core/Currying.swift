// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Curries a function with two arguments into a sequence of partial functions.
///
/// Currying is the technique of converting a function that takes multiple arguments into a sequence of functions that each takes a single argument.
/// For example, currying a function `f` that takes two arguments `(a, b)`
/// ```
/// func f(_ a: Int, _ b: Int) -> Int
/// ```
/// creates a sequence of three functions `r(a)(b)`.
/// - Returns: A curried function `r(a)(b)` that expects the first argument of the initial function.
public func curry<A, B, R>(_ f: @escaping (A, B) -> R) -> (A) -> (B) -> R {
    { a in { b in f(a, b) } }
}

/// Curries a function with three arguments into a sequence of partial functions.
///
/// Currying is the technique of converting a function that takes multiple arguments into a sequence of functions that each takes a single argument.
/// For example, currying a function `f` that takes three arguments `(a, b, c)`
/// ```
/// func f(_ a: Int, _ b: Int, _ c: Int) -> Int
/// ```
/// creates a sequence of three functions `r(a)(b)(c)`.
/// - Returns: A curried function `r(a)(b)(c)` that expects the first argument of the initial function.
public func curry<A, B, C, R>(_ f: @escaping (A, B, C) -> R) -> (A) -> (B) -> (C) -> R {
    { a in { b in { c in f(a, b, c) } } }
}

/// Curries a function with four arguments into a sequence of partial functions.
///
/// Currying is the technique of converting a function that takes multiple arguments into a sequence of functions that each takes a single argument.
/// For example, currying a function `f` that takes four arguments `(a, b, c, d)`
/// ```
/// func f(_ a: Int, _ b: Int, _ c: Int, _ d: Int) -> Int
/// ```
/// creates a sequence of four functions `r(a)(b)(c)(d)`.
/// - Returns: A curried function `r(a)(b)(c)(d)` that expects the first argument of the initial function.
public func curry<A, B, C, D, R>(_ f: @escaping (A, B, C, D) -> R) -> (A) -> (B) -> (C) -> (D) -> R {
    { a in { b in { c in { d in f(a, b, c, d) } } } }
}

/// Curries a function with five arguments into a sequence of partial functions.
///
/// Currying is the technique of converting a function that takes multiple arguments into a sequence of functions that each takes a single argument.
/// For example, currying a function `f` that takes five arguments `(a, b, c, d, e)`
/// ```
/// func f(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int) -> Int
/// ```
/// creates a sequence of five functions `r(a)(b)(c)(d)(e)`.
/// - Returns: A curried function `r(a)(b)(c)(d)(e)` that expects the first argument of the initial function.
public func curry<A, B, C, D, E, R>(_ f: @escaping (A, B, C, D, E) -> R) -> (A) -> (B) -> (C) -> (D) -> (E) -> R {
    { a in { b in { c in { d in { e in f(a, b, c, d, e) } } } } }
}

/// Curries a function with six arguments into a sequence of partial functions.
///
/// Currying is the technique of converting a function that takes multiple arguments into a sequence of functions that each takes a single argument.
/// For example, currying a function `f` that takes six arguments `(a, b, c, d, e, g)`
/// ```
/// func f(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int, _ g: Int) -> Int
/// ```
/// creates a sequence of six functions `r(a)(b)(c)(d)(e)(g)`.
/// - Returns: A curried function `r(a)(b)(c)(d)(e)(g)` that expects the first argument of the initial function.
public func curry<A, B, C, D, E, G, R>(_ f: @escaping (A, B, C, D, E, G) -> R) -> (A) -> (B) -> (C) -> (D) -> (E) -> (G) -> R {
    { a in { b in { c in { d in { e in { g in f(a, b, c, d, e, g) } } } } } }
}
