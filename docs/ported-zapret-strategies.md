# Ported Zapret strategies

These `nfqws` profiles adapt configurations from Flowseal's
`zapret-discord-youtube` 1.10.2 distribution. The source batch files launch
Windows `winws.exe`; portable filtering arguments were retained while local
`%LISTS%` and `%BIN%` paths were replaced with `${hostlists}`, `${ipsets}` and
`${bin:id}` references. Google/general list selectors use `${hostlists}` and
therefore follow the lists enabled by the target app.

| Profile | Source configuration |
| --- | --- |
| `strategy-alt9` | `general (ALT9).bat` |
| `strategy-alt12` | `general (ALT12).bat` |
| `strategy-alt13` | `general (ALT13).bat` |
| `strategy-exp` | `general (EXP).bat` |
| `strategy-general-simple-fake-alt2` | `general (SIMPLE FAKE ALT2).bat` |

The binary fakes referenced by these profiles are included as separate `bin`
artifacts with SHA-256 manifests. Existing repository fakes are reused instead
of duplicated. The profiles are configuration ports, not a claim that each
variant has been validated against every network or provider. The source
distribution's dynamic `%GameFilterTCP%` and `%GameFilterUDP%` rules are omitted
because this repository has no equivalent runtime port-filter variables.
