# cython: embedsignature=True, profile=True, binding=True
from spacy.tokenizer cimport Tokenizer

from typing import Callable
from spacy.language import Language
from spacy import util


def custom_tokenizer_v1() -> Callable[[Language], "CustomTokenizer"]:
    """Function to create a tokenizer. Returns a factory that takes the nlp
    object and returns a Tokenizer instance using the language detaults.
    """

    def tokenizer_factory(nlp: Language) -> "CustomTokenizer":
        prefixes = nlp.Defaults.prefixes
        suffixes = nlp.Defaults.suffixes
        infixes = nlp.Defaults.infixes
        prefix_search = util.compile_prefix_regex(prefixes).search if prefixes else None
        suffix_search = util.compile_suffix_regex(suffixes).search if suffixes else None
        infix_finditer = util.compile_infix_regex(infixes).finditer if infixes else None
        return CustomTokenizer(
            nlp.vocab,
            rules=nlp.Defaults.tokenizer_exceptions,
            prefix_search=prefix_search,
            suffix_search=suffix_search,
            infix_finditer=infix_finditer,
            token_match=nlp.Defaults.token_match,
            url_match=nlp.Defaults.url_match,
        )

    return tokenizer_factory


cdef class CustomTokenizer(Tokenizer):
    def __call__(self, str string):
        return self._tokenize_affixes(string, True)
