 
python << EOF
import os
import sys

cwd = os.getcwd()
sitepkgs = cwd + "/lib/python3.6/site-packages"
path = os.path.expanduser(sitepkgs)
if not path in sys.path:
    sys.path.append(path)
EOF
