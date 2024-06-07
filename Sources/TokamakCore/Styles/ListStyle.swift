public protocol ListStyle {
 var hasDividers: Bool { get }
}

/// A protocol implemented on the renderer to create platform-specific list
/// styles.
public protocol ListStyleDeferredToRenderer {
 func listBody<ListBody>(_ content: ListBody) -> AnyView where ListBody: View
 func listRow<Row>(_ row: Row) -> AnyView where Row: View
 func sectionHeader<Header>(_ header: Header) -> AnyView where Header: View
 func sectionBody<SectionBody>(_ section: SectionBody) -> AnyView
  where SectionBody: View
 func sectionFooter<Footer>(_ footer: Footer) -> AnyView where Footer: View
}

public extension ListStyleDeferredToRenderer {
 func listBody(_ content: some View) -> AnyView {
  AnyView(content)
 }

 func listRow(_ row: some View) -> AnyView {
  AnyView(row.padding([.trailing, .top, .bottom]))
 }

 func sectionHeader(_ header: some View) -> AnyView {
  AnyView(header)
 }

 func sectionBody(_ section: some View) -> AnyView {
  AnyView(section)
 }

 func sectionFooter(_ footer: some View) -> AnyView {
  AnyView(footer)
 }
}

public typealias DefaultListStyle = PlainListStyle

public struct PlainListStyle: ListStyle {
 public var hasDividers = true
 public init() {}
}

public extension ListStyle where Self == PlainListStyle {
 static var plain: Self { Self() }
}

public struct GroupedListStyle: ListStyle {
 public var hasDividers = true
 public init() {}
}

public extension ListStyle where Self == GroupedListStyle {
 static var grouped: Self { Self() }
}

public struct InsetListStyle: ListStyle {
 public var hasDividers = true
 public init() {}
}

public extension ListStyle where Self == InsetListStyle {
 static var inset: Self { Self() }
}

public struct InsetGroupedListStyle: ListStyle {
 public var hasDividers = true
 public init() {}
}

public extension ListStyle where Self == InsetGroupedListStyle {
 static var insetGrouped: Self { Self() }
}

public struct SidebarListStyle: ListStyle {
 public var hasDividers = false
 public init() {}
}

public extension ListStyle where Self == SidebarListStyle {
 static var sidebar: Self { Self() }
}

enum ListStyleKey: EnvironmentKey {
 static let defaultValue: ListStyle = DefaultListStyle()
}

extension EnvironmentValues {
 var listStyle: ListStyle {
  get {
   self[ListStyleKey.self]
  }
  set {
   self[ListStyleKey.self] = newValue
  }
 }
}

public extension View {
 func listStyle(_ style: some ListStyle) -> some View {
  environment(\.listStyle, style)
 }
}
