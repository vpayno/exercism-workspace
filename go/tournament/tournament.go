package tournament

import (
	"errors"
	"fmt"
	"io"
	"sort"
	"strings"
)

// Used to turn on print for the example test(s).
var debug bool = false

// Team struct holds a team's tournament information.
type Team struct {
	name   string
	played int
	won    int
	drawn  int
	lost   int
	points int
}

// Teams map holds a collection of Team structs for a single tournament.
type Teams map[string]Team

// Tally returns the results of a small football competition.
func Tally(reader io.Reader, writer io.Writer) error {
	teams := Teams{}

	var lines []string = []string{}
	var line string
	var size int
	var e error

	var team1 Team
	var team2 Team

	for e != io.EOF {

		// Why are we stuck doing this one byte at a time?
		b := make([]byte, 1)
		size, e = reader.Read(b)

		if size > 0 {
			char := b[0]

			// fmt.Printf("char: %c\n", char)

			if char == '\n' {
				lines = append(lines, line)
				line = ""
				continue
			}

			line += string(char)
		}
	}

	if len(lines) == 0 {
		return errors.New("blank line")
	}

	for _, line := range lines {
		fields := strings.Split(line, ";")

		/*
			fmt.Printf("  line: %#v (%d)\n", line, len(line))
			fmt.Printf("fields: %#v (%d)\n", fields, len(fields))
			fmt.Println()
		*/

		if len(fields) != 3 {
			continue
		}

		name1 := fields[0]
		name2 := fields[1]
		result := fields[2]

		// take the structs out of the map or create a new one
		if _, found := teams[name1]; found {
			team1 = teams[name1]
		} else {
			team1 = Team{}
			team1.name = name1
		}

		// take the structs out of the map or create a new one
		if _, found := teams[name2]; found {
			team2 = teams[name2]
		} else {
			team2 = Team{}
			team2.name = name2
		}

		/*
			fmt.Printf(" team1: %#v\n", team1)
			fmt.Printf(" team2: %#v\n", team2)
			fmt.Printf("result: %v\n", result)
			fmt.Println()

			fmt.Printf(" teams: %#v\n", teams)
			fmt.Printf(" teams[%s]: %#v\n", team1.name, teams[team1.name])
			fmt.Printf(" teams[%s].name: %#v\n", team1.name, teams[team1.name].name)
			fmt.Printf(" teams[%s].won: %#v\n", team1.name, teams[team1.name].won)
			fmt.Printf(" teams[%s]: %#v\n", team2.name, teams[team2.name])
			fmt.Println()
		*/

		switch result {
		case "win":
			/*
				fmt.Printf(" won: %s\n", team1.name)
				fmt.Printf("lost: %s\n", team2.name)
			*/
			team1.won++
			team1.points += 3
			team2.lost++
		case "loss":
			/*
				fmt.Printf("lost: %s\n", team1.name)
				fmt.Printf(" won: %s\n", team2.name)
			*/
			team1.lost++
			team2.won++
			team2.points += 3
		case "draw":
			/*
				fmt.Printf("draw: %s\n", team1.name)
				fmt.Printf("draw: %s\n", team2.name)
			*/
			team1.drawn++
			team2.drawn++
			team1.points++
			team2.points++
		}
		fmt.Println()

		team1.played++
		team2.played++

		// put the structs back in the map
		teams[name1] = team1
		teams[name2] = team2
	}

	var header string
	var output string

	header = fmt.Sprintf("%-30s | %2s | %2s | %2s | %2s | %2s\n", "Team", "MP", "W", "D", "L", "P")

	var rows []Team = []Team{}
	for _, t := range teams {
		rows = append(rows, t)
	}

	// fmt.Printf("rows: %#v\n", rows)
	sort.Slice(rows, func(i, j int) bool {
		if rows[i].points == rows[j].points {
			return rows[i].name < rows[j].name
		}
		return rows[i].points > rows[j].points
	})
	// fmt.Printf("rows: %#v\n", rows)

	for _, t := range rows {
		output += fmt.Sprintf("%-30s | %2d | %2d | %2d | %2d | %2d\n", t.name, t.played, t.won, t.drawn, t.lost, t.points)
	}

	if debug {
		fmt.Print(header)
		fmt.Print(output)
	}

	for _, char := range header {
		b := []byte{byte(char)}
		size, _ = writer.Write(b)
	}

	for _, char := range output {
		b := []byte{byte(char)}
		size, _ = writer.Write(b)
	}

	return nil
}
