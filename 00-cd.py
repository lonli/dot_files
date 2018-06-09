#!/usr/bin/env python3

# from ~/.ipython/profile_default/startup/00-cd.py

import os

_workspace = os.getenv("HOME") + "/code/py"
if os.path.exists(_workspace):
    os.chdir(_workspace)

_color_fmt = "\033[1;33;45m{}\033[0m"
_auto_imports = [
    "datetime",
    "json",
    "requests",
    "re",
    "sys",
]

for m in _auto_imports:
    exec("import {}".format(m))

print("\ncd {} :".format(_color_fmt).format(_workspace))
print("The following modules are imported:")
print("\n".join("    {}".format(_color_fmt).format(n) for n in
                sorted(_auto_imports + ["os"])))
