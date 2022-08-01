//
//  KiliaroTests.swift
//  KiliaroTests
//
//  Created by Sajjad Najafi on 7/14/22.
//

import XCTest
@testable import Kiliaro

class KiliaroTests: XCTestCase {

    func testMediaViewModel() {
        let media = Media(id: "",
                          thumbnail_url: URL(string: "https://google.com")!,
                          download_url: URL(string: "https://google.com")!,
                          resx: 5,
                          resy: 12,
                          created_at: "")
        let mediaViewModel = MediaViewModel(media: media)
        
        XCTAssertEqual(mediaViewModel.date, "", "Date should be empty for invalid values")
        mediaViewModel.setImage(on: UIImageView())
        XCTAssertEqual(mediaViewModel.state, ViewState.loading, "state should change to loading")
    }
    
    func testAlbumViewModel() {
        let albumViewModel = AlbumViewModel(album: "", useCase: TestAlbumUseCase())
        XCTAssertEqual(albumViewModel.numberOfItems(), 1, "Number of items should be equal to 1")
        XCTAssertEqual(albumViewModel.state, ViewState.loading, "Initial state should be loading")
    }

}

class TestAlbumUseCase: AlbumUseCaseable {
    func getMedia(for album: String) async throws -> [Media] {
        return [Media(id: "",
                      thumbnail_url: URL(string: "https://google.com")!,
                      download_url: URL(string: "https://google.com")!,
                      resx: 5,
                      resy: 12,
                      created_at: "")]
    }
    
    func invalidateCacheAndGetMedia(for album: String) async throws -> [Media] {
        return []
    }
}
