import Foundation
import Testing
@testable import DesignSystemPro

@Suite("Toast manager")
@MainActor
struct ToastManagerTests {
    @Test func showAppendsAndDismissRemoves() {
        let manager = DSToastManager()
        manager.show(DSToastData(id: "a", title: "Saved", duration: 0))
        manager.show(DSToastData(id: "b", title: "Synced", duration: 0))
        #expect(manager.toasts.map(\.id) == ["a", "b"])

        manager.dismiss(id: "a")
        #expect(manager.toasts.map(\.id) == ["b"])

        manager.dismissAll()
        #expect(manager.toasts.isEmpty)
    }

    @Test func showingSameIdReplacesToast() {
        let manager = DSToastManager()
        manager.show(DSToastData(id: "upload", title: "Uploading", duration: 0))
        manager.show(DSToastData(id: "upload", title: "Uploaded", variant: .success, duration: 0))
        #expect(manager.toasts.count == 1)
        #expect(manager.toasts.first?.title == "Uploaded")
    }

    @Test func convenienceMethodsSetVariant() {
        let manager = DSToastManager()
        manager.success("Done")
        manager.error("Failed", message: "Try again")
        #expect(manager.toasts.map(\.variant) == [.success, .error])
        #expect(manager.toasts.last?.message == "Try again")
    }

    @Test func autoDismissesAfterDuration() async throws {
        let manager = DSToastManager()
        manager.show(DSToastData(id: "short", title: "Bye", duration: 0.05))
        #expect(manager.toasts.count == 1)

        try await Task.sleep(nanoseconds: 400_000_000)
        #expect(manager.toasts.isEmpty)
    }

    @Test func replacedToastIsNotDismissedByOldTimer() async throws {
        let manager = DSToastManager()
        manager.show(DSToastData(id: "status", title: "Working", duration: 0.05))
        manager.show(DSToastData(id: "status", title: "Still working", duration: 0))

        try await Task.sleep(nanoseconds: 400_000_000)
        #expect(manager.toasts.map(\.title) == ["Still working"])
    }
}
