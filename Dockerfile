# Copyright (c) 2018 John Dewey
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV BASE_PACKAGES="\
  bash \
  python-minimal \
  # NOTE(retr0h): We will want to change this to a ppa for a modern Ansible.
  ansible \
"

RUN set -e \
    && apt-get update -y \
    && apt-get install -y ${BASE_PACKAGES} \
    # NOTE(retr0h): This is a temporary until fixed upstream.
    && sed -i -e '86,87d;' /usr/lib/python2.7/dist-packages/ansible/plugins/connection/chroot.py \
    && rm -rf /var/lib/apt/lists/*
