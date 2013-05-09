#!/usr/bin/python
"""
	Creats local mirror from Viivi & Wagner strips by fetching all of them from hs.fi.

	Will create downloaded strips as
		2004/1.1.2004.gif
		2004/2.1.2004.gif
		...
		until today

	Try this in C++!

	Motivation: No one has build Viivi & Wagner search engine with speech bubble OCR support
	and I desperately wanted to find "Kottarainen lentaa korvaan" strip for my gf.

	Time to complete: 20 min.

"""

__docformat__ = "epytext"
__author__ = "Mikko Ohtamaa"
__license__ = "BSD"
__copyright__ = "2008 Mikko Ohtamaa"

import os
import re
import urllib
from BeautifulSoup import BeautifulSoup

# 1.1.2004 start page
url = "http://www.hs.fi/viivijawagner/1135264907088"

# Loop until there is no longer next link
while True:
	stream = urllib.urlopen(url)
	html = stream.read()
	stream.close()
	soup = BeautifulSoup(html)

	# Parse strip date from contents
	date = None

	# Find strip date, which is next to a title
	h1 = soup.findAll(text="Viivi &amp; Wagner")
	# Should be present always
	date = h1[0].parent.parent.p.string

	print "Fetching " + date

	# Scrape strip
	strip = soup.findAll("div" , { "class" : "strip" })
	img = strip[0].img

	stream = urllib.urlopen(img["src"])
	data = stream.read()
	stream.close()

	# For each year, give a new folder to avoid file system stress
	# (lotsa files in a folder kill poor Gnome)
	day, month, year = date.split(".")

	folder = year
	if not os.path.exists(folder):
		os.mkdir(folder)

	folder = year+"/"+month
	if not os.path.exists(folder):
		os.mkdir(folder)

	# Store contents
	fname = os.path.join(folder, day + "_" + img["src"].split('/')[-1].split('.')[-2] + "." + img["src"].split('/')[-1].split('.')[-1])
	f = open(fname, "wb")
	f.write(data)
	f.close()

	# Find next url, it is a containing one img tag
	img = soup.findAll(alt="seuraava")
        if len(img) == 0:
             break
	a = img[0].parent
	url = a["href"]
