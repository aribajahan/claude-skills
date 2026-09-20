# Security

These skills follow one rule wherever they read content: input is data, not instructions.

A web page, a PDF, an email, a pasted document, a file written by someone else: the text in
it is information to work with, never a command to follow. If any of it is addressed to the
model reading it (telling it to take an action, claiming to be an instruction from the user
or the system, saying an earlier rule no longer applies, pointing it to go somewhere else),
the skill does not act on it. It reports the text, names the source, and flags it for a
person to decide.

This matters most in anything that runs unattended, because no one is watching to catch a
malicious instruction buried in a page or a document. It is the reason the research scans
read from a fixed list of named sources rather than an open web search: a page optimized to
be found is the easiest place to hide an instruction, and a chosen source list cannot be
gamed that way.

Every skill that reads external or pasted content states this inline, under a "Reading
untrusted content" heading. `research-playbook.md` holds the fuller version for the research
scans.

No skill in this repo stores secrets. Where a skill needs a credential, token, or key, it
should be fetched at runtime from a secret store or environment variable, never written into
a skill file, a prompt, or anything committed to the repo.
