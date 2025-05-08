#!/bin/bash

# Create judge.yml with environment variables
cat << EOF > /home/judge_server/judge.yml
id: $judge_server_id
key: "$TOKEN"
problem_storage_root:
    - /home/judge_server/problems
runtime:
    as_x64: /usr/bin/x86_64-linux-gnu-as
    as_x86: /usr/bin/as
    awk: /usr/bin/mawk
    cat: /usr/bin/cat
    g++: /usr/bin/g++
    g++11: /usr/bin/g++
    g++14: /usr/bin/g++
    g++17: /usr/bin/g++
    gcc: /usr/bin/gcc
    gcc11: /usr/bin/gcc
    ld_x64: /usr/bin/x86_64-linux-gnu-ld
    ld_x86: /usr/bin/ld
    perl: /usr/bin/perl
    python3: /usr/bin/python3
    sed: /usr/bin/sed
EOF

# Run DMOJ with the generated judge.yml and server_ip
exec dmoj -c /home/judge_server/judge.yml -p $PORT $server_ip
