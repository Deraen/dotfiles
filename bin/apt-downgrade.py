#!/usr/bin/env python

def user_proceed(prompt, default=True):
    if default == True and opts.yes:
        return True
    while True:
        rin = raw_input(prompt)
        if not rin:
            return default
        if "yes".startswith(rin.lower()):
            return True
        if "no".startswith(rin.lower()):
            return False

def pick_origin(pkgver):
    from sys import stderr
    goodors = filter(lambda x: x.archive != "now", pkgver.origins)
    if len(goodors) != 0:
        if len(goodors) != 1:
            print >>stderr, "Package %s-%s has multiple archives: " % (
                    pkgver.package.name, pkgver.version) + ", ".join(
                    map(lambda x: x.archive, goodors))
        return goodors[0]
    else:
        assert len(pkgver.origins) == 1, pkgver.origins
        return pkgver.origins[0]
from optparse import OptionParser
parser = OptionParser()
parser.add_option("-u", "--update", action="store_true", default=False,
        help="update the package cache first")
parser.add_option("-y", "--yes", action="store_true", default=False,
        help="assume yes to all questions for which yes is the default")
parser.add_option("-f", "--force", action="store_true", default=False,
        help="force the requested changes, don't resolve problems")
opts, args = parser.parse_args()

import apt, apt.progress, apt_pkg

# try to grab the system lock briefly, so we're not caught without it later
try:
    with apt_pkg.SystemLock():
        pass
except SystemError as exc:
    print exc
    raise SystemExit(100) # see apt-get(8)

print "Loading package cache..."
cache = apt.Cache()

if opts.update:
    print "Updating package cache..."
    cache.update(apt.progress.TextFetchProgress())

print "Searching for installed packages that are no longer available..."
for pkg in cache:
    if pkg.installed and not pkg.candidate.downloadable:
        cand = None
        for ver in pkg.versions:
            if ver.downloadable and ver > cand:
                cand = ver
        #print pkg.installed, "->", cand
        if cand is None:
            if user_proceed(
                    "Remove '%s' version %s [y]?" % (
                    pkg.name, pkg.installed.version)):
                #pkg.candidate = None
                pkg.mark_delete(autoFix=False, purge=False)
                assert pkg.marked_delete
        if cand != None:
            if user_proceed(
                    "Force '%s' version\n  from %s\n  to   %s (%s) [y]? "
                    % ( pkg.name,
                        pkg.installed.version,
                        cand.version,
                        pick_origin(cand).archive)):
                pkg.candidate = cand
                pkg.mark_install(autoFix=False, fromUser=False)
            #pkg.mark_upgrade()

print "Resolving package problems (pass -f to disable this step)..."
apt.cache.ProblemResolver(cache).resolve()

if cache.get_changes():
    print "The following changes will be made..."
    for pkg in cache.get_changes():
        print "  %s %s => %s (%s)" % (
                pkg.name,
                pkg.installed and pkg.installed.version,
                None if pkg.marked_delete else pkg.candidate.version,
                pick_origin(pkg.candidate).archive)
    print "%.1f MB will be downloaded" % (cache.required_download / 1e6)
    if user_proceed("Do you wish to make the changes above? [n]? ", default=False):
        while True:
            try:
                cache.commit(
                        apt.progress.TextFetchProgress(),
                        apt.progress.InstallProgress())
            except SystemError as exc:
                print exc
                if not user_proceed("An error occurred, try again? [y]? "):
                    raise SystemExit(100) # see apt-get(8)
                continue
            else:
                break
    else:
        print "User cancelled."
else:
    print "There are no changes to be made."
