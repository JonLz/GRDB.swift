import Query
import SwiftUI

@main
struct GRDBCombineDemoApp: App {
    var body: some Scene {
        WindowGroup {
            AppView().environment(\.appDatabase, .shared)
        }
    }
}

// MARK: - Give SwiftUI access to the database
//
// Define a new environment key that grants access to an AppDatabase.
//
// The technique is documented at
// <https://developer.apple.com/documentation/swiftui/environmentkey>.

private struct AppDatabaseKey: EnvironmentKey {
    static var defaultValue: AppDatabase { .empty() }
}

extension EnvironmentValues {
    var appDatabase: AppDatabase {
        get { self[AppDatabaseKey.self] }
        set { self[AppDatabaseKey.self] = newValue }
    }
}

// In this demo app, views observe the database with the @Query property
// wrapper, defined in the local Query package. Its documentation recommends to
// define a dedicated initializer for `appDatabase` access, so we comply:

extension Query where QueryableType.DatabaseContext == AppDatabase {
    /// Convenience initializer for queries that feed from `AppDatabase`.
    init(_ query: QueryableType) {
        self.init(query, in: \.appDatabase)
    }
}
