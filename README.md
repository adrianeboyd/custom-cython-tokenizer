# A minimal custom Cython spaCy tokenizer

This package demonstrates how to create a registered custom tokenizer that
extends the [spaCy Tokenizer](https://spacy.io/api/tokenizer) in Cython for use
with spaCy v3.

## Install

```bash
pip install -U pip
pip install .
```

Or from the repo URL:

```bash
pip install -U pip
pip install https://github.com/adrianeboyd/custom-cython-tokenizer/archive/master.zip
```

## Usage

Once this package is installed, the custom tokenizer is registered under the
entry point `spacy_tokenizers`, so you can specify it your config like this:

```ini
[nlp]
tokenizer = {"@tokenizers":"custom_tokenizer.v1"}
```

Or start from a blank model in python:

```python
import spacy

nlp = spacy.blank("en", config={"nlp": {"tokenizer": {"@tokenizers": "custom_tokenizer.v1"}}})
```

## Packaging a pipeline

If your packaged spaCy pipeline requires this package, specify it in
`meta.json` under `requirements` before calling [`spacy
package`](https://spacy.io/api/cli#package):

```json
  "requirements":[
    "custom-tokenizer>=0.0.2,<0.1.0"
  ]
```
