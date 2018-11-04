import XCTest
@testable import RnaTranscription

class RnaTranscriptionTests: XCTestCase {
    static let longTest = (0..<100000).reduce("") { acc, _ in acc + "A" }
    static let x = (0..<100000).reduce("") { acc, _ in acc + "U" }
    func testRnaComplementOfCytosineIsGuanine() {
        XCTAssertEqual("G", try Nucleotide("C").complementOfDNA())
    }

    func testRnaComplementOfGuanineIsCytosine() {
        XCTAssertEqual("C", try Nucleotide("G").complementOfDNA())
    }

    func testRnaComplementOfThymineIsAdenine() {
        XCTAssertEqual("A", try Nucleotide("T").complementOfDNA())
    }

    func testRnaComplementOfAdenineIsUracil() {
        XCTAssertEqual("U", try Nucleotide("A").complementOfDNA())
    }

    func testRnaComplement() {
        XCTAssertEqual("UGCACCAGAAUU" + RnaTranscriptionTests.x, try Nucleotide("ACGTGGTCTTAA" + RnaTranscriptionTests.longTest).complementOfDNA())
    }

    func testInvalidRnaComplementOfUracil() {
        XCTAssertThrowsError(try Nucleotide("U").complementOfDNA())

        // Uncomment to see more specific error handling
        XCTAssertThrowsError(try Nucleotide("U").complementOfDNA(), "This didn't work") { (error) in
            XCTAssertEqual(error as? RnaTranscription.TranscriptionError, RnaTranscription.TranscriptionError.invalidNucleotide)
        }
    }

    func testInvalidRnaComplementOfXXX() {
        XCTAssertThrowsError(try Nucleotide("XXX").complementOfDNA())

        // Uncomment to see more specific error handling
        XCTAssertThrowsError(try Nucleotide("XXX").complementOfDNA(), "This didn't work") { (error) in
            XCTAssertEqual(error as? RnaTranscription.TranscriptionError, RnaTranscription.TranscriptionError.invalidNucleotide)
        }
    }

    func testInvalidRnaComplementOfACGTXXXCTTAA() {
        XCTAssertThrowsError(try Nucleotide("ACGTXXXCTTAA").complementOfDNA())

        // Uncomment to see more specific error handling
        XCTAssertThrowsError(try Nucleotide("ACGTXXXCTTAA").complementOfDNA(), "This didn't work") { (error) in
            XCTAssertEqual(error as? RnaTranscription.TranscriptionError, RnaTranscription.TranscriptionError.invalidNucleotide)
        }
    }

    static var allTests: [(String, (RnaTranscriptionTests) -> () throws -> Void)] {
        return [
            ("testRnaComplementOfCytosineIsGuanine", testRnaComplementOfCytosineIsGuanine),
            ("testRnaComplementOfGuanineIsCytosine", testRnaComplementOfGuanineIsCytosine),
            ("testRnaComplementOfThymineIsAdenine", testRnaComplementOfThymineIsAdenine),
            ("testRnaComplementOfAdenineIsUracil", testRnaComplementOfAdenineIsUracil),
            ("testRnaComplement", testRnaComplement),
            ("testInvalidRnaComplementOfUracil", testInvalidRnaComplementOfUracil),
            ("testInvalidRnaComplementOfXXX", testInvalidRnaComplementOfXXX),
            ("testInvalidRnaComplementOfACGTXXXCTTAA", testInvalidRnaComplementOfACGTXXXCTTAA)
        ]
    }
}
