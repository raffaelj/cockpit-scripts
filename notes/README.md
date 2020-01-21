# some random notes while fiddling with Cockpit

```bash
# remove color chars from cli output
./cp account/generate-password --passwd admin | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
```