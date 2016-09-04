# This is free and unencumbered software released into the public domain.

"""Erlang/OTP marshaling."""

import erlang

def atom(str):
    return erlang.OtpErlangAtom(str)

def annotate(xs):
    if isinstance(xs, tuple):
        return tuple(annotate(x) for x in xs)
    if isinstance(xs, list):
        return [annotate(x) for x in xs]
    if isinstance(xs, str):
        return erlang.OtpErlangBinary(bytes(xs, 'UTF-8'))
    return xs

def encode(term):
    return erlang.term_to_binary(annotate(term))

def decode(binary):
    return erlang.binary_to_term(binary)
