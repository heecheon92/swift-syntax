// This test file has been translated from swift/test/Parse/try.swift

import XCTest

final class TryTests: XCTestCase {
  func testTry1() {
    AssertParse(
      """
      // Intentionally has lower precedence than assignments and ?:
      infix operator %%%% : LowPrecedence
      precedencegroup LowPrecedence {
        associativity: none
        lowerThan: AssignmentPrecedence
      }
      func %%%%<T, U>(x: T, y: U) -> Int { return 0 }
      """
    )
  }

  func testTry2() {
    AssertParse(
      """
      // Intentionally has lower precedence between assignments and ?:
      infix operator %%% : MiddlingPrecedence
      precedencegroup MiddlingPrecedence {
        associativity: none
        higherThan: AssignmentPrecedence
        lowerThan: TernaryPrecedence
      }
      func %%%<T, U>(x: T, y: U) -> Int { return 1 }
      """
    )
  }

  func testTry3() {
    AssertParse(
      """
      func foo() throws -> Int { return 0 }
      func bar() throws -> Int { return 0 }
      """
    )
  }

  func testTry4() {
    AssertParse(
      """
      var x = try foo() + bar()
      x = try foo() + bar()
      x += try foo() + bar()
      x += try foo() %%%% bar() 
      x += try foo() %%% bar()
      x = foo() + try bar()
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 4: result of operator '%%%%' is unused
        // TODO: Old parser expected error on line 4: call can throw but is not marked with 'try'
        // TODO: Old parser expected error on line 4: 'try' following assignment operator does not cover everything to its right
        // TODO: Old parser expected note on line 4: did you mean to use 'try'?, Fix-It replacements: 21 - 21 = 'try '
        // TODO: Old parser expected note on line 4: did you mean to handle error as optional value?, Fix-It replacements: 21 - 21 = 'try? '
        // TODO: Old parser expected note on line 4: did you mean to disable error propagation?, Fix-It replacements: 21 - 21 = 'try! '
        // TODO: Old parser expected error on line 6: call can throw but is not marked with 'try'
        // TODO: Old parser expected error on line 6: 'try' cannot appear to the right of a non-assignment operator
        // TODO: Old parser expected note on line 6: did you mean to use 'try'?, Fix-It replacements: 5 - 5 = 'try '
        // TODO: Old parser expected note on line 6: did you mean to handle error as optional value?, Fix-It replacements: 5 - 5 = 'try? '
        // TODO: Old parser expected note on line 6: did you mean to disable error propagation?, Fix-It replacements: 5 - 5 = 'try! '
      ]
    )
  }

  func testTry5() {
    AssertParse(
      """
      var y = true ? try foo() : try bar() + 0
      var z = true ? try foo() : try bar() %%% 0
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'try' following conditional operator does not cover everything to its right
      ]
    )
  }

  func testTry6() {
    AssertParse(
      """
      var a = try! foo() + bar()
      a = try! foo() + bar()
      a += try! foo() + bar()
      a += try! foo() %%%% bar() 
      a += try! foo() %%% bar()
      a = foo() + try! bar()
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 4: result of operator '%%%%' is unused
        // TODO: Old parser expected error on line 4: call can throw but is not marked with 'try'
        // TODO: Old parser expected error on line 4: 'try!' following assignment operator does not cover everything to its right
        // TODO: Old parser expected note on line 4: did you mean to use 'try'?, Fix-It replacements: 22 - 22 = 'try '
        // TODO: Old parser expected note on line 4: did you mean to handle error as optional value?, Fix-It replacements: 22 - 22 = 'try? '
        // TODO: Old parser expected note on line 4: did you mean to disable error propagation?, Fix-It replacements: 22 - 22 = 'try! '
        // TODO: Old parser expected error on line 6: call can throw but is not marked with 'try'
        // TODO: Old parser expected error on line 6: 'try!' cannot appear to the right of a non-assignment operator
        // TODO: Old parser expected note on line 6: did you mean to use 'try'?, Fix-It replacements: 5 - 5 = 'try '
        // TODO: Old parser expected note on line 6: did you mean to handle error as optional value?, Fix-It replacements: 5 - 5 = 'try? '
        // TODO: Old parser expected note on line 6: did you mean to disable error propagation?, Fix-It replacements: 5 - 5 = 'try! '
      ]
    )
  }

  func testTry7() {
    AssertParse(
      """
      var b = true ? try! foo() : try! bar() + 0
      var c = true ? try! foo() : try! bar() %%% 0
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'try!' following conditional operator does not cover everything to its right
      ]
    )
  }

  func testTry8() {
    AssertParse(
      """
      infix operator ?+= : AssignmentPrecedence
      func ?+=(lhs: inout Int?, rhs: Int?) {
        lhs = lhs! + rhs!
      }
      """
    )
  }

  func testTry9() {
    AssertParse(
      """
      var i = try? foo() + bar()
      let _: Double = i 
      i = try? foo() + bar()
      i ?+= try? foo() + bar()
      i ?+= try? foo() %%%% bar() 
      i ?+= try? foo() %%% bar()
      _ = foo() == try? bar() 
      _ = (try? foo()) == bar() 
      _ = foo() == (try? bar()) 
      _ = (try? foo()) == (try? bar())
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Int?' to specified type 'Double'
        // TODO: Old parser expected warning on line 5: result of operator '%%%%' is unused
        // TODO: Old parser expected error on line 5: call can throw but is not marked with 'try'
        // TODO: Old parser expected error on line 5: 'try?' following assignment operator does not cover everything to its right
        // TODO: Old parser expected note on line 5: did you mean to use 'try'?, Fix-It replacements: 23 - 23 = 'try '
        // TODO: Old parser expected note on line 5: did you mean to handle error as optional value?, Fix-It replacements: 23 - 23 = 'try? '
        // TODO: Old parser expected note on line 5: did you mean to disable error propagation?, Fix-It replacements: 23 - 23 = 'try! '
        // TODO: Old parser expected error on line 7: call can throw but is not marked with 'try'
        // TODO: Old parser expected error on line 7: 'try?' cannot appear to the right of a non-assignment operator
        // TODO: Old parser expected note on line 7: did you mean to use 'try'?, Fix-It replacements: 5 - 5 = 'try '
        // TODO: Old parser expected note on line 7: did you mean to handle error as optional value?, Fix-It replacements: 5 - 5 = 'try? '
        // TODO: Old parser expected note on line 7: did you mean to disable error propagation?, Fix-It replacements: 5 - 5 = 'try! '
        // TODO: Old parser expected error on line 8: call can throw but is not marked with 'try'
        // TODO: Old parser expected note on line 8: did you mean to use 'try'?, Fix-It replacements: 21 - 21 = 'try '
        // TODO: Old parser expected note on line 8: did you mean to handle error as optional value?, Fix-It replacements: 21 - 21 = 'try? '
        // TODO: Old parser expected note on line 8: did you mean to disable error propagation?, Fix-It replacements: 21 - 21 = 'try! '
        // TODO: Old parser expected error on line 9: call can throw but is not marked with 'try'
        // TODO: Old parser expected note on line 9: did you mean to use 'try'?, Fix-It replacements: 5 - 5 = 'try '
        // TODO: Old parser expected note on line 9: did you mean to handle error as optional value?, Fix-It replacements: 5 - 5 = 'try? '
        // TODO: Old parser expected note on line 9: did you mean to disable error propagation?, Fix-It replacements: 5 - 5 = 'try! '
      ]
    )
  }

  func testTry10() {
    AssertParse(
      """
      let j = true ? try? foo() : try? bar() + 0
      let k = true ? try? foo() : try? bar() %%% 0
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'try?' following conditional operator does not cover everything to its right
      ]
    )
  }

  func testTry11() {
    AssertParse(
      """
      try #^DIAG_1^#let singleLet = foo() 
      try #^DIAG_2^#var singleVar = foo() 
      try #^DIAG_3^#let uninit: Int 
      try #^DIAG_4^#let (destructure1, destructure2) = (foo(), bar()) 
      try #^DIAG_5^#let multi1 = foo(), multi2 = bar() //  expected-error 2 {{call can throw but is not marked with 'try'}}
      class TryDecl { 
        #^DIAG_6^#try let singleLet = foo() 
        #^DIAG_7^#try var singleVar = foo() 
        #^DIAG_8^#try 
        func method() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'try' must be placed on the initial value expression, Fix-It replacements: 1 - 5 = '', 21 - 21 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 2: 'try' must be placed on the initial value expression, Fix-It replacements: 1 - 5 = '', 21 - 21 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 3: 'try' must be placed on the initial value expression
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 4: 'try' must be placed on the initial value expression, Fix-It replacements: 1 - 5 = '', 40 - 40 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 5: 'try' must be placed on the initial value expression
        // TODO: Old parser expected note on line 5: did you mean to use 'try'?, Fix-It replacements: 18 - 18 = 'try '
        // TODO: Old parser expected note on line 5: did you mean to use 'try'?, Fix-It replacements: 34 - 34 = 'try '
        // TODO: Old parser expected note on line 5: did you mean to handle error as optional value?, Fix-It replacements: 18 - 18 = 'try? '
        // TODO: Old parser expected note on line 5: did you mean to handle error as optional value?, Fix-It replacements: 34 - 34 = 'try? '
        // TODO: Old parser expected note on line 5: did you mean to disable error propagation?, Fix-It replacements: 18 - 18 = 'try! '
        // TODO: Old parser expected note on line 5: did you mean to disable error propagation?, Fix-It replacements: 34 - 34 = 'try! '
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected note on line 6: in declaration of 'TryDecl'
        // TODO: Old parser expected error on line 7: 'try' must be placed on the initial value expression, Fix-It replacements: 3 - 7 = '', 23 - 23 = 'try '
        // TODO: Old parser expected error on line 7: call can throw, but errors cannot be thrown out of a property initializer
        DiagnosticSpec(locationMarker: "DIAG_6", message: "unexpected text 'try' before variable"),
        // TODO: Old parser expected error on line 8: 'try' must be placed on the initial value expression, Fix-It replacements: 3 - 7 = '', 23 - 23 = 'try '
        // TODO: Old parser expected error on line 8: call can throw, but errors cannot be thrown out of a property initializer
        DiagnosticSpec(locationMarker: "DIAG_7", message: "unexpected text 'try' before variable"),
        // TODO: Old parser expected error on line 9: expected declaration
        DiagnosticSpec(locationMarker: "DIAG_8", message: "unexpected text 'try' before function"),
      ]
    )
  }

  func testTry12() {
    AssertParse(
      """
      func test() throws -> Int {
        try #^DIAG_1^#while true { 
          try #^DIAG_2^#break 
        }
        try #^DIAG_3^#throw #^DIAG_4^#
        ; // Reset parser.
        try #^DIAG_5^#return 
        ; // Reset parser.
        try #^DIAG_6^#throw foo() 
        try #^DIAG_7^#return foo() 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'try' cannot be used with 'while'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 3: 'try' cannot be used with 'break'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 5: 'try' must be placed on the thrown expression, Fix-It replacements: 3 - 7 = '', 3 - 3 = 'try '
        // TODO: Old parser expected error on line 5: expected expression in 'throw' statement
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected expression in 'try' expression"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected expression in 'throw' statement"),
        // TODO: Old parser expected error on line 7: 'try' cannot be used with 'return'
        // TODO: Old parser expected error on line 7: non-void function should return a value
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 9: 'try' must be placed on the thrown expression, Fix-It replacements: 3 - 7 = '', 13 - 13 = 'try '
        // TODO: Old parser expected error on line 9: thrown expression type 'Int' does not conform to 'Error'
        DiagnosticSpec(locationMarker: "DIAG_6", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 10: 'try' must be placed on the returned expression, Fix-It replacements: 3 - 7 = '', 14 - 14 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_7", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry13() {
    AssertParse(
      #"""
      // Test operators.
      func *(a : String, b : String) throws -> Int { return 42 }
      let _ = "foo"
              *  
              "bar"
      let _ = try! "foo"*"bar"
      let _ = try? "foo"*"bar"
      let _ = (try? "foo"*"bar") ?? 0
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: operator can throw but expression is not marked with 'try'
        // TODO: Old parser expected note on line 4: did you mean to use 'try'?, Fix-It replacements: 9 - 9 = 'try '
        // TODO: Old parser expected note on line 4: did you mean to handle error as optional value?, Fix-It replacements: 9 - 9 = 'try? '
        // TODO: Old parser expected note on line 4: did you mean to disable error propagation?, Fix-It replacements: 9 - 9 = 'try! '
      ]
    )
  }

  func testTry14() {
    AssertParse(
      """
      // <rdar://problem/21414023> Assertion failure when compiling function that takes throwing functions and rethrows
      func rethrowsDispatchError(handleError: ((Error) throws -> ()), body: () throws -> ()) rethrows {
        do {
          body()   
        } catch {
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: call can throw but is not marked with 'try'
        // TODO: Old parser expected note on line 4: did you mean to use 'try'?, Fix-It replacements: 5 - 5 = 'try '
        // TODO: Old parser expected note on line 4: did you mean to handle error as optional value?, Fix-It replacements: 5 - 5 = 'try? '
        // TODO: Old parser expected note on line 4: did you mean to disable error propagation?, Fix-It replacements: 5 - 5 = 'try! '
      ]
    )
  }

  func testTry15() {
    AssertParse(
      """
      // <rdar://problem/21432429> Calling rethrows from rethrows crashes Swift compiler
      struct r21432429 {
        func x(_ f: () throws -> ()) rethrows {}
        func y(_ f: () throws -> ()) rethrows {
          x(f)  
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: call can throw but is not marked with 'try'
        // TODO: Old parser expected note on line 5: call is to 'rethrows' function, but argument function can throw
      ]
    )
  }

  func testTry16() {
    AssertParse(
      """
      // <rdar://problem/21427855> Swift 2: Omitting try from call to throwing closure in rethrowing function crashes compiler
      func callThrowingClosureWithoutTry(closure: (Int) throws -> Int) rethrows {
        closure(0)  
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: call can throw but is not marked with 'try'
        // TODO: Old parser expected warning on line 3: result of call to function returning 'Int' is unused
        // TODO: Old parser expected note on line 3: did you mean to use 'try'?, Fix-It replacements: 3 - 3 = 'try '
        // TODO: Old parser expected note on line 3: did you mean to handle error as optional value?, Fix-It replacements: 3 - 3 = 'try? '
        // TODO: Old parser expected note on line 3: did you mean to disable error propagation?, Fix-It replacements: 3 - 3 = 'try! '
      ]
    )
  }

  func testTry17() {
    AssertParse(
      """
      func producesOptional() throws -> Int? { return nil }
      let _: String = try? producesOptional()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Int??' to specified type 'String'
      ]
    )
  }

  func testTry18() {
    AssertParse(
      """
      let _ = (try? foo())!!
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot force unwrap value of non-optional type 'Int'
      ]
    )
  }

  func testTry19() {
    AssertParse(
      """
      func producesDoubleOptional() throws -> Int?? { return 3 }
      let _: String = try? producesDoubleOptional()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Int???' to specified type 'String'
      ]
    )
  }

  func testTry20() {
    AssertParse(
      """
      func maybeThrow() throws {}
      try maybeThrow() // okay
      try! maybeThrow() // okay
      try? maybeThrow() // okay since return type of maybeThrow is Void
      _ = try? maybeThrow() // okay
      """
    )
  }

  func testTry21() {
    AssertParse(
      """
      let _: () -> Void = { try! maybeThrow() } // okay
      let _: () -> Void = { try? maybeThrow() } // okay since return type of maybeThrow is Void
      """
    )
  }

  func testTry22() {
    AssertParse(
      """
      if try? maybeThrow() { 
      }
      let _: Int = try? foo()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot be used as a boolean, Fix-It replacements: 4 - 4 = '((', 21 - 21 = ') != nil)'
        // TODO: Old parser expected error on line 3: value of optional type 'Int?' not unwrapped; did you mean to use 'try!' or chain with '?'?, Fix-It replacements: 14 - 18 = 'try!'
      ]
    )
  }

  func testTry23() {
    AssertParse(
      """
      class X {}
      func test(_: X) {}
      func producesObject() throws -> AnyObject { return X() }
      test(try producesObject())
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'AnyObject' is not convertible to 'X'
        // TODO: Old parser expected note on line 4: did you mean to use 'as!' to force downcast?, Fix-It replacements: 26 - 26 = ' as! X'
      ]
    )
  }

  func testTry24() {
    AssertParse(
      #"""
      _ = "a\(try maybeThrow())b"
      _ = try "a\(maybeThrow())b"
      _ = "a\(maybeThrow())"
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: call can throw but is not marked with 'try'
        // TODO: Old parser expected note on line 3: did you mean to use 'try'?, Fix-It replacements: 9 - 9 = 'try '
        // TODO: Old parser expected note on line 3: did you mean to handle error as optional value?, Fix-It replacements: 9 - 9 = 'try? '
        // TODO: Old parser expected note on line 3: did you mean to disable error propagation?, Fix-It replacements: 9 - 9 = 'try! '
      ]
    )
  }

  func testTry25() {
    AssertParse(
      """
      extension DefaultStringInterpolation {
        mutating func appendInterpolation() throws {}
      }
      """
    )
  }

  func testTry26() {
    AssertParse(
      #"""
      _ = try "a\()b"
      _ = "a\()b" 
      _ = try "\() \(1)"
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: interpolation can throw but is not marked with 'try'
        // TODO: Old parser expected note on line 2: did you mean to use 'try'?, Fix-It replacements: 5 - 5 = 'try '
        // TODO: Old parser expected note on line 2: did you mean to handle error as optional value?, Fix-It replacements: 5 - 5 = 'try? '
        // TODO: Old parser expected note on line 2: did you mean to disable error propagation?, Fix-It replacements: 5 - 5 = 'try! '
      ]
    )
  }

  func testTry27() {
    AssertParse(
      """
      func testGenericOptionalTry<T>(_ call: () throws -> T ) {
        let _: String = try? call() 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'T?' to specified type 'String'
      ]
    )
  }

  func testTry28() {
    AssertParse(
      """
      func genericOptionalTry<T>(_ call: () throws -> T ) -> T? {
        let x = try? call() // no error expected
        return x
      }
      """
    )
  }

  func testTry29() {
    AssertParse(
      """
      // Test with a non-optional type
      let _: String = genericOptionalTry({ () throws -> Int in return 3 })
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Int?' to specified type 'String'
      ]
    )
  }

  func testTry30() {
    AssertParse(
      """
      // Test with an optional type
      let _: String = genericOptionalTry({ () throws -> Int? in return nil })
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Int??' to specified type 'String'
      ]
    )
  }

  func testTry31() {
    AssertParse(
      """
      func produceAny() throws -> Any {
        return 3
      }
      """
    )
  }

  func testTry32() {
    AssertParse(
      """
      let _: Int? = try? produceAny() as? Int 
      let _: Int?? = (try? produceAny()) as? Int // good
      let _: String = try? produceAny() as? Int 
      let _: String = (try? produceAny()) as? Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: value of optional type 'Int??' not unwrapped; did you mean to use 'try!' or chain with '?'?
        // TODO: Old parser expected error on line 3: cannot convert value of type 'Int??' to specified type 'String'
        // TODO: Old parser expected error on line 4: cannot convert value of type 'Int?' to specified type 'String'
      ]
    )
  }

  func testTry33() {
    AssertParse(
      """
      struct ThingProducer {
        func produceInt() throws -> Int { return 3 }
        func produceIntNoThrowing() -> Int { return 3 }
        func produceAny() throws -> Any { return 3 }
        func produceOptionalAny() throws -> Any? { return 3 }
        func produceDoubleOptionalInt() throws -> Int?? { return 3 }
      }
      """
    )
  }

  func testTry34() {
    AssertParse(
      """
      let optProducer: ThingProducer? = ThingProducer()
      let _: Int? = try? optProducer?.produceInt() 
      let _: Int = try? optProducer?.produceInt() 
      let _: String = try? optProducer?.produceInt() 
      let _: Int?? = try? optProducer?.produceInt() // good
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: value of optional type 'Int??' not unwrapped; did you mean to use 'try!' or chain with '?'?
        // TODO: Old parser expected error on line 3: cannot convert value of type 'Int??' to specified type 'Int'
        // TODO: Old parser expected error on line 4: cannot convert value of type 'Int??' to specified type 'String'
      ]
    )
  }

  func testTry35() {
    AssertParse(
      """
      let _: Int? = try? optProducer?.produceIntNoThrowing() 
      let _: Int?? = try? optProducer?.produceIntNoThrowing()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: value of optional type 'Int??' not unwrapped; did you mean to use 'try!' or chain with '?'?
        // TODO: Old parser expected warning on line 2: no calls to throwing functions occur within 'try' expression
      ]
    )
  }

  func testTry36() {
    AssertParse(
      """
      let _: Int? = (try? optProducer?.produceAny()) as? Int // good
      let _: Int? = try? optProducer?.produceAny() as? Int 
      let _: Int?? = try? optProducer?.produceAny() as? Int // good
      let _: String = try? optProducer?.produceAny() as? Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: value of optional type 'Int??' not unwrapped; did you mean to use 'try!' or chain with '?'?
        // TODO: Old parser expected error on line 4: cannot convert value of type 'Int??' to specified type 'String'
      ]
    )
  }

  func testTry37() {
    AssertParse(
      """
      let _: String = try? optProducer?.produceDoubleOptionalInt()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Int???' to specified type 'String'
      ]
    )
  }

  func testTry38() {
    AssertParse(
      """
      let producer = ThingProducer()
      """
    )
  }

  func testTry39() {
    AssertParse(
      """
      let _: Int = try? producer.produceDoubleOptionalInt() 
      let _: Int? = try? producer.produceDoubleOptionalInt() 
      let _: Int?? = try? producer.produceDoubleOptionalInt() 
      let _: Int??? = try? producer.produceDoubleOptionalInt() // good
      let _: String = try? producer.produceDoubleOptionalInt()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: value of optional type 'Int???' not unwrapped; did you mean to use 'try!' or chain with '?'?
        // TODO: Old parser expected error on line 2: value of optional type 'Int???' not unwrapped; did you mean to use 'try!' or chain with '?'?
        // TODO: Old parser expected error on line 3: value of optional type 'Int???' not unwrapped; did you mean to use 'try!' or chain with '?'?
        // TODO: Old parser expected error on line 5: cannot convert value of type 'Int???' to specified type 'String'
      ]
    )
  }

  func testTry40() {
    AssertParse(
      """
      // rdar://problem/46742002
      protocol Dummy : class {}
      """
    )
  }

  func testTry41() {
    AssertParse(
      """
      class F<T> {
        func wait() throws -> T { fatalError() }
      }
      """
    )
  }

  func testTry42() {
    AssertParse(
      """
      func bar(_ a: F<Dummy>, _ b: F<Dummy>) {
        _ = (try? a.wait()) === (try? b.wait())
      }
      """
    )
  }

}
