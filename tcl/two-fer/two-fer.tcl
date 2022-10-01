proc two-fer {{name ""}} {
    if {$name == ""} { set name "you"; }

	return "One for $name, one for me.";
}
