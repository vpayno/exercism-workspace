<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# protein

```go
import "protein"
```

Package protein is used to translate RNA sequences into proteins.

## Index

- [Variables](<#variables>)
- [func FromCodon(codon string) (string, error)](<#func-fromcodon>)
- [func FromRNA(rna string) ([]string, error)](<#func-fromrna>)


## Variables

ErrInvalidBase is used to signal FronCodon that an invalid codon has been encountered.

```go
var ErrInvalidBase = errors.New("Invalid Base")
```

ErrStop is used to signal FromCodon to stop processing codons.

```go
var ErrStop = errors.New("STOP")
```

## func [FromCodon](<https://github.com/vpayno/exercism-workspace/blob/main/go/protein-translation/protein_translation.go#L46>)

```go
func FromCodon(codon string) (string, error)
```

FromCodon returns a single protein from a codon.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(FromCodon("AUG"))

}
```

#### Output

```
Methionine <nil>
```

</p>
</details>

## func [FromRNA](<https://github.com/vpayno/exercism-workspace/blob/main/go/protein-translation/protein_translation.go#L16>)

```go
func FromRNA(rna string) ([]string, error)
```

FromRNA returns a protein sequence from an RNA sequence.

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(FromRNA("UGGUGUUAUUAAUGGUUU"))

}
```

#### Output

```
[Tryptophan Cysteine Tyrosine] <nil>
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
