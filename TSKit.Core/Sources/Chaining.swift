// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

// TODO: Early access. No documentation, no usages.
// TODO: Implement different combinations of optional and non-optional inputs and outputs.

precedencegroup ChainingPrecedence {
    lowerThan: AdditionPrecedence
    higherThan: AssignmentPrecedence
    associativity: left
}

infix operator => : ChainingPrecedence
infix operator =>? : ChainingPrecedence
infix operator ==> : ChainingPrecedence
infix operator ==>? : ChainingPrecedence

public func ==><A, B>(_ lhs: A, _ rhs: (A) throws -> B) rethrows -> B {
    return try rhs(lhs)
}


@discardableResult
public func ==><A>(_ lhs: A, _ rhs: (A) throws -> Void) rethrows -> A {
    try rhs(lhs)
    return lhs
}

@discardableResult
public func ==><A>(_ lhs:  () throws -> A, _ rhs: (A) throws -> Void) rethrows -> A {
    let a = try lhs()
    try rhs(a)
    return a
}

public func ==><A, B>(_ lhs: () throws -> A, _ rhs: (A) throws -> B) rethrows -> B {
    return try rhs(try lhs())
}

public func ==>?<A, B>(_ lhs: A?, _ rhs: (A) throws -> B?) rethrows -> B? {
    return try lhs.flatMap(rhs)
}

public func ==>?<A, B>(_ lhs: () throws -> A?, _ rhs: (A) throws -> B?) rethrows -> B? {
    return try lhs().flatMap(rhs)
}

public func =><A, B, C>(_ lhs: @escaping (A) -> B, _ rhs: @escaping (B) -> C) -> (A) -> C {
    return { rhs(lhs($0)) }
}

public func =><A, B, C>(_ lhs: @escaping (A) -> B?, _ rhs: @escaping (B) -> C?) -> (A) -> C? {
    return { lhs($0).flatMap(rhs) }
}

public func =><A, B>(_ lhs: @escaping (A) -> B, _ rhs: @escaping (B) -> Void) -> (A) -> B {
    return {
        let b = lhs($0)
        rhs(b)
        return b
    }
}

public func =><A>(_ lhs: @escaping () -> A, _ rhs: @escaping (A) -> Void) -> () -> A {
    return {
        let a = lhs()
        rhs(a)
        return a
    }
}

public func =>?<A, B>(_ lhs: @escaping (A) -> B?, _ rhs: @escaping (B) -> Void) -> (A) -> B? {
    return {
        let b = lhs($0)
        b.flatMap(rhs)
        return b
    }
}

public func =>?<A>(_ lhs: @escaping () -> A?, _ rhs: @escaping (A) -> Void) -> () -> A? {
    return {
        let a = lhs()
        a.flatMap(rhs)
        return a
    }
}

public func curry<A, B, C>(f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}


public func curry<A, B, C, D>(f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in { b in { c in f(a, b, c) } } }
}
