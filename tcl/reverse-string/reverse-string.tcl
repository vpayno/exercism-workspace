proc reverse {text} {
    set rlist [lreverse [split $text ""]]
    set rtext [join $rlist ""]

    return $rtext
}
