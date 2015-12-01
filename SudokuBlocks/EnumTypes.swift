import Foundation

/*
< todo?
<
< enum RowIndex
< enum ColIndex
< struct Key {
<     let row = RowIndex()
<     let col = ColIndex()
< }
<
< */

enum Difficulty {
    case easy
    case medium
    case hard
    case evil
}

enum MoveType {
    case insertion
    case deletion
    case substitution
}

enum HintType {
    case one
    case two
    case three
}

enum GroupType {
    case row
    case col
    case zone
}
