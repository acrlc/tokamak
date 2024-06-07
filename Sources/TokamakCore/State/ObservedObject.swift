import OpenCombineShim

public typealias ObservableObject = OpenCombineShim.ObservableObject
public typealias Published = OpenCombineShim.Published

public protocol ObservedProperty: DynamicProperty {
 var objectWillChange: AnyPublisher<(), Never> { get }
}

@propertyWrapper
public struct ObservedObject<ObjectType>: DynamicProperty where ObjectType: ObservableObject {
 @dynamicMemberLookup
 public struct Wrapper {
  var root: ObjectType
  public subscript<Subject>(
   dynamicMember keyPath: ReferenceWritableKeyPath<ObjectType, Subject>
  ) -> Binding<Subject> {
   .init(
    get: {
     self.root[keyPath: keyPath]
    },
    set: {
     self.root[keyPath: keyPath] = $0
    }
   )
  }
 }

 public var wrappedValue: ObjectType {
  get { projectedValue.root }
  set {
   projectedValue.root = newValue
  }
 }

 public init(wrappedValue: ObjectType) {
  projectedValue = Wrapper(root: wrappedValue)
 }

 public var projectedValue: Wrapper
}

extension ObservedObject: ObservedProperty {
 public var objectWillChange: AnyPublisher<(), Never> {
  wrappedValue.objectWillChange.map { _ in }.eraseToAnyPublisher()
 }
}
