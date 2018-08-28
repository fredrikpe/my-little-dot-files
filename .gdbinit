set history save on
set history size 10000
set history remove-duplicates 1
set history filename ~/.gdb_history

# Stdlib gcc is using I think
skip -gfile /usr/local/include/c++/9.0.0/bits/*


# I don't understand why this strange dir path must be used.
skip -gfile /usr/bin/../lib/gcc/x86_64-linux-gnu/7.3.0/../../../../include/c++/7.3.0/bits/*
# Because this doesn't seem to work
skip -gfile /usr/include/c++/7.3.0/bits/*
