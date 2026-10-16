"""Structural checks for docs/discovery. Usage: python3 tools/check_discovery.py docs/discovery"""
import re, glob, sys, os

d = sys.argv[1] if len(sys.argv) > 1 else 'docs/discovery'
files = sorted(glob.glob(os.path.join(d, '*.md')))
text = {os.path.basename(f): open(f, encoding='utf-8').read() for f in files}
allt = '\n'.join(text.values())
problems = []

def defined(prefix, width):
    rows = set(re.findall(r'^\| (%s-\d{%d}) \|' % (prefix, width), allt, re.M))
    heads = set(re.findall(r'^#{2,4} (%s-\d{%d})\b' % (prefix, width), allt, re.M))
    return rows | heads

def used(prefix, width):
    return set(re.findall(r'\b%s-\d{%d}\b' % (prefix, width), allt))

# register-style IDs (must be defined as table rows or headings)
for prefix, width in [('S', 3), ('ASM', 2), ('OPEN', 2), ('HYP', 2), ('OBJ', 2), ('GAP', 2), ('PRB', 2), ('UQ', 2),
                      ('DR', 2), ('CMP', 2), ('EVD', 2), ('SQ', 2), ('IQ', 2), ('TH', 2), ('CON', 2), ('SCP-IN', 2), ('SCP-OUT', 2),
                      ('CL', 2), ('OPT', 2), ('TD', 2), ('SPK', 2), ('GT', 2), ('RSK', 2), ('KC', 2),
                      ('FR', 2), ('NFR', 2), ('US', 2), ('INT', 2), ('DAT', 2), ('ADR', 2), ('DEP', 2),
                      ('SPR', 2), ('ROL', 2), ('GIT', 2), ('DEL', 3)]:
    missing = sorted(used(prefix, width) - defined(prefix, width))
    if missing:
        problems.append('%s used but not defined: %s' % (prefix, missing))
personas = set(re.findall(r'^### (PER-\d{2})', allt, re.M))
miss = sorted(used('PER', 2) - personas)
if miss:
    problems.append('PER used but not defined: %s' % miss)

# provisional ids must not survive
left = sorted(set(re.findall(r'\b(?:S|ASM|OPEN)-9\d\d\b', ''.join(t for n, t in text.items() if n != '04-FEASIBILITY.md'))))
if left:
    problems.append('provisional 9xx ids outside 04-FEASIBILITY.md: %s' % left)

body = ''.join(t for n, t in text.items() if n != 'B-SOURCES.md')
unused = sorted(defined('S', 3) - set(re.findall(r'\bS-\d{3}\b', body)))
if unused:
    print('note: sources never cited in the body:', unused)

en = re.findall(r'^\| (SQ-\d{2}) \|', text.get('03-USER-RESEARCH.md', ''), re.M)
ar = re.findall(r'^\| (SQ-\d{2}) \|', text.get('03a-SURVEY-AR.md', ''), re.M)
if en != ar:
    problems.append('SQ ids differ between English and Arabic survey')

for name, t in text.items():
    for link in re.findall(r'\]\(([^)#]+\.md)\)', t):
        if link not in text:
            problems.append('%s links to missing file %s' % (name, link))
    for pre in ('OPEN', 'ASM', 'S'):
        ids = re.findall(r'^\| (%s-\d+) \|' % pre, t, re.M)
        if ids != sorted(ids, key=lambda x: int(x.split('-')[1])):
            problems.append('%s: %s rows not sorted' % (name, pre))
    if len(re.findall(r'^\| (?:S|ASM|OPEN)-\d+ \|', t, re.M)) != len(set(re.findall(r'^\| ((?:S|ASM|OPEN)-\d+) \|', t, re.M))):
        problems.append('%s: duplicate register row ids' % name)

# product name: NutriVision allowed only as the course-brief title or in the naming history
for name, t in text.items():
    if name in ('NAMING.md',):
        continue
    for i, line in enumerate(t.splitlines(), 1):
        if 'NutriVision' in line and not re.search(r'course-brief title|brief title|renaming the project from|NutriVision is only', line) and 'Nesba' not in line:
            problems.append('%s:%d mentions NutriVision as the product name' % (name, i))

wrapped = len(re.findall(r'`\[[VAUT][:\]]', allt))
print('code-wrapped tags:', wrapped, '| [U]:', allt.count('[U]'), '| [T]:', allt.count('[T]') + allt.count('[T:'))
print('PROBLEMS:' if problems else 'no structural problems found')
for p in problems:
    print(' -', p)
sys.exit(1 if problems else 0)
