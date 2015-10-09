#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/xattr.h>
#include <string.h>

int main(int argc, char**argv) {
  DIR *d;
  struct dirent *dir;
  char buffer[32];
  int i;
  if (argc > 1) {
    d = opendir(argv[1]);
  } else {
    d = opendir(".");
  }
  if (d) {
    while ((dir = readdir(d)) != NULL) {
      if (dir->d_type == DT_REG) {
        memset(buffer, 0, 32),
        getxattr(dir->d_name, "user.uses", &buffer, 32);
        i = atoi(buffer);
        printf("%i	%s\n", i, dir->d_name);
      }
    }

    closedir(d);
  }

  return(0);
}
