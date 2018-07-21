// TODO: Early access. No documentation, no usages.
// TODO: Implement different combinations of optional and non-optional inputs and outputs.

precedencegroup ChainingPrecedence {
    lowerThan: TernaryPrecedence
    higherThan: AssignmentPrecedence
    associativity: left
}

infix operator => : ChainingPrecedence
infix operator =>? : ChainingPrecedence
infix operator ==> : ChainingPrecedence
infix operator ==>? : ChainingPrecedence

func ==><A, B>(_ lhs: A, _ rhs: (A) throws -> B) rethrows -> B {
    return try rhs(lhs)
}


@discardableResult
func ==><A>(_ lhs: A, _ rhs: (A) throws -> Void) rethrows -> A {
    try rhs(lhs)
    return lhs
}

@discardableResult
func ==><A>(_ lhs:  () throws -> A, _ rhs: (A) throws -> Void) rethrows -> A {
    let a = try lhs()
    try rhs(a)
    return a
}

func ==><A, B>(_ lhs: () throws -> A, _ rhs: (A) throws -> B) rethrows -> B {
    return try rhs(try lhs())
}

func ==>?<A, B>(_ lhs: A?, _ rhs: (A) throws -> B?) rethrows -> B? {
    return try lhs.flatMap(rhs)
}

func ==>?<A, B>(_ lhs: () throws -> A?, _ rhs: (A) throws -> B?) rethrows -> B? {
    return try lhs().flatMap(rhs)
}

func =><A, B, C>(_ lhs: @escaping (A) -> B, _ rhs: @escaping (B) -> C) -> (A) -> C {
    return { rhs(lhs($0)) }
}

func =><A, B, C>(_ lhs: @escaping (A) -> B?, _ rhs: @escaping (B) -> C?) -> (A) -> C? {
    return { lhs($0).flatMap(rhs) }
}

func =><A, B>(_ lhs: @escaping (A) -> B, _ rhs: @escaping (B) -> Void) -> (A) -> B {
    return {
        let b = lhs($0)
        rhs(b)
        return b
    }
}

func =>?<A, B>(_ lhs: @escaping (A) -> B?, _ rhs: @escaping (B) -> Void) -> (A) -> B? {
    return {
        let b = lhs($0)
        b.flatMap(rhs)
        return b
    }
}

func =>?<A>(_ lhs: @escaping () -> A?, _ rhs: @escaping (A) -> Void) -> () -> A? {
    return {
        let a = lhs()
        a.flatMap(rhs)
        return a
    }
}
