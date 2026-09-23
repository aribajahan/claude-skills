# Skills

A set of Claude skills for running a personal operating system: writing clearly, keeping work
resumable across sessions, and researching a subject on a fixed cadence. Each skill is a
`SKILL.md` file with instructions Claude follows when the skill is invoked.

These are adapted from a working system. They use a `WORKSPACE/` placeholder wherever a file
path is needed. Point it at your own workspace root, and adjust the placeholder file names
(a wins log, a journal, a project index) to whatever you already keep.

## What's here

### Writing
- **plain-english**: removes the patterns that make a draft sound AI-written, then checks it
  actually says something. Based on Wikipedia's "Signs of AI writing," plus an opinionated
  second pass on specificity.

### Session and project continuity
- **resume**: pick work back up where it stopped, from the plan and the last session log.
- **wrap**: close out a session so the next one starts from somewhere: update the plan, log
  what was decided and what was ruled out, stage what's next.
- **new-project**: scaffold a project folder so work in it is resumable.
- **portfolio**: regenerate a derived index of every project and where it stands.
- **portfolio-check**: one page showing the next move on each active project.
- **map**: regenerate an index of the skills in your system from their frontmatter.
- **decision-log**: capture a decision: what was decided, why, and what was ruled out.
- **drift-check**: read-only audit that finds the parts of a skill system that broke quietly.
- **drift-fix**: the repair companion to drift-check. Fixes broken path references (when
  there's exactly one match on disk) and git filename case mismatches. Everything requiring
  judgment stays in drift-check's report for you.

### Research
- **research-playbook.md**: the shared contract every research scan reads first: how to
  source, how to tell evidence from interpretation, the output shape, how to write.
- **ai-industry-scan**: what changed in AI products, deployment, and business models.
- **human-and-ai**: what AI is doing to human judgment, learning, and agency.
- **product-and-habit**: which products earn a real place in people's lives, and how.
- **brand-strategy-scan**: how brands build meaning, distinctiveness, and trust.
- **product-strategy-scan**: how products are built and positioned to win.
- **growth-marketing-scan**: how companies acquire, activate, and retain users.
- **research-synthesis**: reads across the scan reports and says what's worth writing about.
- **research-agent-audit**: a second-pass agent that audits research desk outputs against
  your playbook rules, fixes what it can directly in the report files, and flags what it
  can't. Needs research desks producing dated reports and a playbook or rules file.

### Capture
- **content-seed**: catch an observation worth writing about later, before it's lost.
- **brain-dump**: catch what you said thinking out loud, and sort it before writing anything.
- **granola-sync**: weekly sync of new Granola meetings into a local markdown archive with
  an index by date and person. Needs the Granola MCP connector.

### Commands
- **ask**: routed search across your knowledge base. `/ask [person]` searches one person's
  meetings, `/ask meetings` searches all transcripts, `/ask emails` searches Gmail,
  `/ask courses` searches course transcripts, `/ask reference` searches your reference files,
  or `/ask` searches everything.
- **do**: the action counterpart to `/ask`. `/do [person]` preps for a session or drafts an
  email, `/do emails` triages your inbox, `/do courses` extracts frameworks from course
  transcripts, `/do sync|wrap|drift` dispatches to existing skills, or `/do` with a plain
  instruction.

### Meta
- **prepare-for-sharing**: turn a private skill into a clean, publicly shareable copy without leaking anything. The method that produced this repo, including the skill you're reading.

## Using these

Skills load from `~/.claude/skills/` (or a symlink to it). Copy the folders you want into
that directory, edit the `WORKSPACE/` paths and placeholder file names to match your setup,
and invoke a skill by name or by the trigger phrases in its `description`.

Each skill is self-contained except the research scans, which all read `research-playbook.md`.

## Safety check

`scripts/check.sh` scans the repo for anything that shouldn't ship: private paths or
identifiers, stray em dashes, skills with broken frontmatter, and skills missing the
injection guardrail. Run it any time with `scripts/check.sh`.

It also runs automatically before every push, as a pre-push hook. Enable the hook once per
clone with:

```
git config core.hooksPath hooks
```

A failed check blocks the push and prints what to fix. To push anyway in a case you're sure
about, use `git push --no-verify`.

## License

MIT. See [LICENSE](LICENSE).
