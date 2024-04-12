proc reverse {text} {
    set rtext ""

    foreach char [lreverse [split $text ""]] {
        append rtext $char
    }

    return $rtext
}
