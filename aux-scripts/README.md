# Auxiliary text-check-and-filter scripts

\+ unit test for the correctness of the auxiliary scripts themselves

## Test run sample

```
me@my-computer:~/Documents/my-blog/alignalghii.github.io$ aux-scripts/unit-test-of-the-scripts.bash
Unit test
- Feature: filter-mathjax-contents
  Samples:
  - Sample `simple-embedded-mathjax-content':
    Testers:
    - Tester `perl': OK
    - Tester `sed -n -f': OK
    - Tester `awk -f': OK
- Feature: skip-empty-lines-inside-mathjax
  Samples:
  - Sample `simple-embedded-mathjax-content':
    Testers:
    - Tester `perl': OK
    - Tester `sed -n -f': OK
    - Tester `awk -f': OK
  Samples:
  - Sample `empty':
    Testers:
    - Tester `perl': OK
    - Tester `sed -n -f': OK
    - Tester `awk -f': OK
  Samples:
  - Sample `nontrivial-general-case':
    Testers:
    - Tester `perl': OK
    - Tester `sed -n -f': OK
    - Tester `awk -f': OK
me@my-computer:~/Documents/my-blog/alignalghii.github.io$
```
