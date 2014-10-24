import subprocess


def copy(string):
    """Copy given string into system clipboard."""
    _cmd = ["xclip", "-selection", "primary"]
    subprocess.Popen(_cmd, stdin=subprocess.PIPE).communicate(
        string.encode('utf-8'))
    return


def paste():
    """Returns system clipboard contents."""
    return subprocess.Popen(["xclip", "-selection", "primary", "-o"],
                            stdout=subprocess.PIPE).communicate()[0].decode("utf-8")


class NvimClipboard(object):
    def __init__(self, vim):
        self.provides = ['clipboard']

    def clipboard_get(self):
        return paste().split('\n')

    def clipboard_set(self, lines):
        copy(u'\n'.join([line.decode('utf-8') for line in lines]))
