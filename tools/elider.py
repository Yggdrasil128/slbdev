#
# (C) Ralf Laemmel, 2015, elision preprocessor for softlangbook resources
#

import os
import string

exts = dict()
exts["hs"] = ("-- BEGIN ...", "-- END ...", "-- ...")
exts["java"] = ("// BEGIN ...", "// END ...", "// ...")
exts["fsml"] = None
exts["g4"] = None
exts["Makefile"] = None
exts["json"] = None
exts["py"] = ("# BEGIN ...", "# END ...", "# ...")
exts["input"] = None
exts["output"] = None
exts["py-template"] = exts["py"]
exts["dot"] = None
exts["pro"] = ("% BEGIN ...", "% END ...", "% ...")
exts["term"] = exts["pro"]
exts["ptree"] = exts["pro"]
exts["bgl"] = exts["pro"]
exts["egl"] = exts["pro"]
exts["bsl"] = exts["pro"]
exts["esl"] = exts["pro"]
exts["bfpl"] = exts["hs"]
exts["bipl"] = exts["java"]
for (dirpath, dirnames, filenames) in os.walk("src"):
    print dirpath
    for filename in filenames:
        ext = filename.rpartition('.')[-1]
        if ext in exts:
            print " " + filename
            with open(dirpath + "/" + filename, "r") as infile:
                with open(dirpath + "/" + filename + "...", "w") as outfile:
                    if exts[ext] is None:
                        for line in infile:
                            outfile.write(line)
                    else:
                        (begin, end, ddd) = exts[ext]
                        skip = False
                        for line in infile:
                            if line.startswith(begin):
                                skip = True
                            elif line.startswith(end):
                                skip = False
                            elif ddd in line:
                                line = string.replace(line, ddd, "...")
                                outfile.write(line)
                            elif not skip:
                                outfile.write(line)
